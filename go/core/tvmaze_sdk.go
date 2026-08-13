package core

import (
	"fmt"
	"strings"

	vs "github.com/voxgig-sdk/tvmaze-sdk/go/utility/struct"
)

type TvmazeSDK struct {
	Mode     string
	options  map[string]any
	utility  *Utility
	Features []Feature
	rootctx  *Context
}

func NewTvmazeSDK(options map[string]any) *TvmazeSDK {
	sdk := &TvmazeSDK{
		Mode:     "live",
		Features: []Feature{},
	}

	sdk.utility = NewUtility()

	config := MakeConfig()

	sdk.rootctx = sdk.utility.MakeContext(map[string]any{
		"client":  sdk,
		"utility": sdk.utility,
		"config":  config,
		"options": options,
		"shared":  map[string]any{},
	}, nil)

	sdk.options = sdk.utility.MakeOptions(sdk.rootctx)

	if vs.GetPath([]any{"feature", "test", "active"}, sdk.options) == true {
		sdk.Mode = "test"
	}

	sdk.rootctx.Options = sdk.options

	// Add features in the resolved order (MakeOptions puts an explicit array
	// order first, else defaults to test-first). Ordering matters: the `test`
	// feature installs the base mock transport and the transport features
	// (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
	// must be added before them to sit at the base of the chain.
	featureOpts := ToMapAny(vs.GetProp(sdk.options, "feature"))
	if featureOpts != nil {
		if fo, ok := vs.GetPath([]any{"__derived__", "featureorder"}, sdk.options).([]any); ok {
			for _, n := range fo {
				fname, _ := n.(string)
				fopts := ToMapAny(featureOpts[fname])
				if fopts != nil {
					if active, ok := fopts["active"]; ok {
						if ab, ok := active.(bool); ok && ab {
							sdk.utility.FeatureAdd(sdk.rootctx, makeFeature(fname))
						}
					}
				}
			}
		}
	}

	// Add extension features.
	if extend := vs.GetProp(sdk.options, "extend"); extend != nil {
		if extList, ok := extend.([]any); ok {
			for _, f := range extList {
				if feat, ok := f.(Feature); ok {
					sdk.utility.FeatureAdd(sdk.rootctx, feat)
				}
			}
		}
	}

	// Initialize features.
	for _, f := range sdk.Features {
		sdk.utility.FeatureInit(sdk.rootctx, f)
	}

	sdk.utility.FeatureHook(sdk.rootctx, "PostConstruct")

	return sdk
}

func (sdk *TvmazeSDK) OptionsMap() map[string]any {
	out := vs.Clone(sdk.options)
	if om, ok := out.(map[string]any); ok {
		return om
	}
	return map[string]any{}
}

func (sdk *TvmazeSDK) GetUtility() *Utility {
	return CopyUtility(sdk.utility)
}

func (sdk *TvmazeSDK) GetRootCtx() *Context {
	return sdk.rootctx
}

func (sdk *TvmazeSDK) Prepare(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "prepare",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	options := sdk.options

	path, _ := vs.GetProp(fetchargs, "path").(string)
	method, _ := vs.GetProp(fetchargs, "method").(string)
	if method == "" {
		method = "GET"
	}

	params := ToMapAny(vs.GetProp(fetchargs, "params"))
	if params == nil {
		params = map[string]any{}
	}
	query := ToMapAny(vs.GetProp(fetchargs, "query"))
	if query == nil {
		query = map[string]any{}
	}

	headers := utility.PrepareHeaders(ctx)

	base, _ := vs.GetProp(options, "base").(string)
	prefix, _ := vs.GetProp(options, "prefix").(string)
	suffix, _ := vs.GetProp(options, "suffix").(string)

	ctx.Spec = NewSpec(map[string]any{
		"base":    base,
		"prefix":  prefix,
		"suffix":  suffix,
		"path":    path,
		"method":  method,
		"params":  params,
		"query":   query,
		"headers": headers,
		"body":    vs.GetProp(fetchargs, "body"),
		"step":    "start",
	})

	// Merge user-provided headers.
	if uh := vs.GetProp(fetchargs, "headers"); uh != nil {
		if uhm, ok := uh.(map[string]any); ok {
			for k, v := range uhm {
				ctx.Spec.Headers[k] = v
			}
		}
	}

	_, err := utility.PrepareAuth(ctx)
	if err != nil {
		return nil, err
	}

	return utility.MakeFetchDef(ctx)
}

// Raw endpoint access is operator-controllable, like every entity op.
// Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
// either one reaches the same endpoint.
func (sdk *TvmazeSDK) Direct(fetchargs map[string]any) (map[string]any, error) {
	if !sdk.opAllowed("direct") {
		return sdk.opDenied("direct"), nil
	}

	return sdk.rawRequest(fetchargs)
}

// Is this raw-access op permitted by the SDK's allow.op option?
func (sdk *TvmazeSDK) opAllowed(op string) bool {
	allowOp, _ := vs.GetPath([]any{"allow", "op"}, sdk.options).(string)
	return strings.Contains(allowOp, op)
}

func (sdk *TvmazeSDK) opDenied(op string) map[string]any {
	allowOp, _ := vs.GetPath([]any{"allow", "op"}, sdk.options).(string)
	return map[string]any{
		"ok": false,
		"err": fmt.Errorf("TvmazeSDK: %s: operation not allowed by"+
			" SDK option allow.op value: \"%s\"", op, allowOp),
	}
}

// Ungated request path shared by Direct and Graphql, each of which checks
// its own allow.op token first. Unexported, rather than a flag on fetchargs:
// a caller-supplied marker would let anyone opt straight back out of the
// gate by passing it.
func (sdk *TvmazeSDK) rawRequest(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	fetchdef, err := sdk.Prepare(fetchargs)
	if err != nil {
		return map[string]any{"ok": false, "err": err}, nil
	}

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "direct",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	url, _ := fetchdef["url"].(string)
	fetched, fetchErr := utility.Fetcher(ctx, url, fetchdef)

	if fetchErr != nil {
		return map[string]any{"ok": false, "err": fetchErr}, nil
	}

	if fetched == nil {
		return map[string]any{
			"ok":  false,
			"err": ctx.MakeError("direct_no_response", "response: undefined"),
		}, nil
	}

	if fm, ok := fetched.(map[string]any); ok {
		status := ToInt(vs.GetProp(fm, "status"))
		headers := vs.GetProp(fm, "headers")

		// No-body responses (204, 304) and explicit zero content-length
		// must skip JSON parsing — calling json() on an empty body errors.
		var contentLength string
		if hm, ok := headers.(map[string]any); ok {
			if cl, ok := hm["content-length"]; ok {
				contentLength = fmt.Sprintf("%v", cl)
			}
		}
		noBody := status == 204 || status == 304 || contentLength == "0"

		var jsonData any
		if !noBody {
			if jf := vs.GetProp(fm, "json"); jf != nil {
				if f, ok := jf.(func() any); ok {
					// f() returns nil on parse error in our fetcher.
					jsonData = f()
				}
			}
		}

		return map[string]any{
			"ok":      status >= 200 && status < 300,
			"status":  status,
			"headers": headers,
			"data":    jsonData,
		}, nil
	}

	return map[string]any{"ok": false, "err": ctx.MakeError("direct_invalid", "invalid response type")}, nil
}

// Raw GraphQL access: the pressure valve that makes the generated surface's
// deliberate omissions (per-call selection sets, typed filter builders,
// batching, subscriptions) livable — the whole schema stays reachable.
//
// Thin wrapper over the same prepare/fetch path Direct uses, with the one
// thing raw Direct cannot do for GraphQL: a GraphQL failure rides HTTP 200
// as a top-level `errors` array, so status alone would report a failed query
// as ok.
//
// NOTE: like Direct, this bypasses the feature pipeline — no retry,
// ratelimit or paging features apply.
func (sdk *TvmazeSDK) Graphql(
	query string, variables map[string]any, ctrl map[string]any,
) (map[string]any, error) {
	if !sdk.opAllowed("graphql") {
		return sdk.opDenied("graphql"), nil
	}

	if variables == nil {
		variables = map[string]any{}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	res, err := sdk.rawRequest(map[string]any{
		"method":  "POST",
		"headers": map[string]any{"content-type": "application/json"},
		"body":    map[string]any{"query": query, "variables": variables},
		"ctrl":    ctrl,
	})

	if err != nil {
		return res, err
	}

	// Errors are read BEFORE any status check: a GraphQL parse or validation
	// failure comes back as HTTP 400 carrying the standard { errors: [...] }
	// body, and the raw path represents a non-2xx as ok:false with no err —
	// so returning early on status would discard the server's own
	// diagnostics, which are the only useful part of that response.
	errors, _ := vs.GetPath([]any{"data", "errors"}, res).([]any)

	if 0 < len(errors) {
		msg, _ := vs.GetProp(errors[0], "message").(string)
		if msg == "" {
			msg = "graphql error"
		}
		res["ok"] = false
		res["err"] = fmt.Errorf("TvmazeSDK: graphql: %s", msg)
		res["graphql"] = errors
	}

	return res, nil
}


// Aka returns a Aka entity bound to this client.
// Idiomatic usage: client.Aka(nil).List(nil, nil) or
// client.Aka(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Aka(data map[string]any) TvmazeEntity {
	return NewAkaEntityFunc(sdk, data)
}


// AlternateList returns a AlternateList entity bound to this client.
// Idiomatic usage: client.AlternateList(nil).List(nil, nil) or
// client.AlternateList(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) AlternateList(data map[string]any) TvmazeEntity {
	return NewAlternateListEntityFunc(sdk, data)
}


// Cast returns a Cast entity bound to this client.
// Idiomatic usage: client.Cast(nil).List(nil, nil) or
// client.Cast(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Cast(data map[string]any) TvmazeEntity {
	return NewCastEntityFunc(sdk, data)
}


// CastCredit returns a CastCredit entity bound to this client.
// Idiomatic usage: client.CastCredit(nil).List(nil, nil) or
// client.CastCredit(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) CastCredit(data map[string]any) TvmazeEntity {
	return NewCastCreditEntityFunc(sdk, data)
}


// CastMember returns a CastMember entity bound to this client.
// Idiomatic usage: client.CastMember(nil).List(nil, nil) or
// client.CastMember(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) CastMember(data map[string]any) TvmazeEntity {
	return NewCastMemberEntityFunc(sdk, data)
}


// Crew returns a Crew entity bound to this client.
// Idiomatic usage: client.Crew(nil).List(nil, nil) or
// client.Crew(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Crew(data map[string]any) TvmazeEntity {
	return NewCrewEntityFunc(sdk, data)
}


// CrewCredit returns a CrewCredit entity bound to this client.
// Idiomatic usage: client.CrewCredit(nil).List(nil, nil) or
// client.CrewCredit(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) CrewCredit(data map[string]any) TvmazeEntity {
	return NewCrewCreditEntityFunc(sdk, data)
}


// CrewMember returns a CrewMember entity bound to this client.
// Idiomatic usage: client.CrewMember(nil).List(nil, nil) or
// client.CrewMember(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) CrewMember(data map[string]any) TvmazeEntity {
	return NewCrewMemberEntityFunc(sdk, data)
}


// Episode returns a Episode entity bound to this client.
// Idiomatic usage: client.Episode(nil).List(nil, nil) or
// client.Episode(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Episode(data map[string]any) TvmazeEntity {
	return NewEpisodeEntityFunc(sdk, data)
}


// GuestCastCredit returns a GuestCastCredit entity bound to this client.
// Idiomatic usage: client.GuestCastCredit(nil).List(nil, nil) or
// client.GuestCastCredit(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) GuestCastCredit(data map[string]any) TvmazeEntity {
	return NewGuestCastCreditEntityFunc(sdk, data)
}


// Image returns a Image entity bound to this client.
// Idiomatic usage: client.Image(nil).List(nil, nil) or
// client.Image(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Image(data map[string]any) TvmazeEntity {
	return NewImageEntityFunc(sdk, data)
}


// Person returns a Person entity bound to this client.
// Idiomatic usage: client.Person(nil).List(nil, nil) or
// client.Person(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Person(data map[string]any) TvmazeEntity {
	return NewPersonEntityFunc(sdk, data)
}


// Schedule returns a Schedule entity bound to this client.
// Idiomatic usage: client.Schedule(nil).List(nil, nil) or
// client.Schedule(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Schedule(data map[string]any) TvmazeEntity {
	return NewScheduleEntityFunc(sdk, data)
}


// ScheduledEpisode returns a ScheduledEpisode entity bound to this client.
// Idiomatic usage: client.ScheduledEpisode(nil).List(nil, nil) or
// client.ScheduledEpisode(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) ScheduledEpisode(data map[string]any) TvmazeEntity {
	return NewScheduledEpisodeEntityFunc(sdk, data)
}


// Search returns a Search entity bound to this client.
// Idiomatic usage: client.Search(nil).List(nil, nil) or
// client.Search(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Search(data map[string]any) TvmazeEntity {
	return NewSearchEntityFunc(sdk, data)
}


// Season returns a Season entity bound to this client.
// Idiomatic usage: client.Season(nil).List(nil, nil) or
// client.Season(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Season(data map[string]any) TvmazeEntity {
	return NewSeasonEntityFunc(sdk, data)
}


// Show returns a Show entity bound to this client.
// Idiomatic usage: client.Show(nil).List(nil, nil) or
// client.Show(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Show(data map[string]any) TvmazeEntity {
	return NewShowEntityFunc(sdk, data)
}


// Update returns a Update entity bound to this client.
// Idiomatic usage: client.Update(nil).List(nil, nil) or
// client.Update(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *TvmazeSDK) Update(data map[string]any) TvmazeEntity {
	return NewUpdateEntityFunc(sdk, data)
}



func TestSDK(testopts map[string]any, sdkopts map[string]any) *TvmazeSDK {
	if sdkopts == nil {
		sdkopts = map[string]any{}
	}
	sdkopts = vs.Clone(sdkopts).(map[string]any)

	if testopts == nil {
		testopts = map[string]any{}
	}
	testopts = vs.Clone(testopts).(map[string]any)
	testopts["active"] = true

	vs.SetPath(sdkopts, []any{"feature", "test"}, testopts)

	sdk := NewTvmazeSDK(sdkopts)
	sdk.Mode = "test"

	return sdk
}

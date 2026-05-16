package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/tvmaze-sdk"
	"github.com/voxgig-sdk/tvmaze-sdk/core"

	vs "github.com/voxgig/struct"
)

func TestGuestCastCreditEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.GuestCastCredit(nil)
		if ent == nil {
			t.Fatal("expected non-nil GuestCastCreditEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := guest_cast_creditBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "guest_cast_credit." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		guestCastCreditRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.guest_cast_credit", setup.data)))
		var guestCastCreditRef01Data map[string]any
		if len(guestCastCreditRef01DataRaw) > 0 {
			guestCastCreditRef01Data = core.ToMapAny(guestCastCreditRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = guestCastCreditRef01Data

		// LIST
		guestCastCreditRef01Ent := client.GuestCastCredit(nil)
		guestCastCreditRef01Match := map[string]any{
			"person_id": setup.idmap["person01"],
		}

		guestCastCreditRef01ListResult, err := guestCastCreditRef01Ent.List(guestCastCreditRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, guestCastCreditRef01ListOk := guestCastCreditRef01ListResult.([]any)
		if !guestCastCreditRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", guestCastCreditRef01ListResult)
		}

	})
}

func guest_cast_creditBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "guest_cast_credit", "GuestCastCreditTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read guest_cast_credit test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse guest_cast_credit test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"guest_cast_credit01", "guest_cast_credit02", "guest_cast_credit03", "person01", "person02", "person03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID": idmap,
		"TVMAZE_TEST_LIVE":      "FALSE",
		"TVMAZE_TEST_EXPLAIN":   "FALSE",
		"TVMAZE_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["TVMAZE_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["TVMAZE_APIKEY"],
			},
			extra,
		})
		client = sdk.NewTvmazeSDK(core.ToMapAny(mergedOpts))
	}

	live := env["TVMAZE_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["TVMAZE_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}

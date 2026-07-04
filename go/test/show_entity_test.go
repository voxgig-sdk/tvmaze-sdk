package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/tvmaze-sdk/go"
	"github.com/voxgig-sdk/tvmaze-sdk/go/core"

	vs "github.com/voxgig-sdk/tvmaze-sdk/go/utility/struct"
)

func TestShowEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Show(nil)
		if ent == nil {
			t.Fatal("expected non-nil ShowEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := showBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "show." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set TVMAZE_TEST_SHOW_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		showRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.show", setup.data)))
		var showRef01Data map[string]any
		if len(showRef01DataRaw) > 0 {
			showRef01Data = core.ToMapAny(showRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = showRef01Data

		// LIST
		showRef01Ent := client.Show(nil)
		showRef01Match := map[string]any{}

		showRef01ListResult, err := showRef01Ent.List(showRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, showRef01ListOk := showRef01ListResult.([]any)
		if !showRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", showRef01ListResult)
		}

		// LOAD
		showRef01MatchDt0 := map[string]any{
			"id": showRef01Data["id"],
		}
		showRef01DataDt0Loaded, err := showRef01Ent.Load(showRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		showRef01DataDt0LoadResult := core.ToMapAny(showRef01DataDt0Loaded)
		if showRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if showRef01DataDt0LoadResult["id"] != showRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func showBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "show", "ShowTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read show test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse show test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"show01", "show02", "show03", "alternatelist01", "alternatelist02", "alternatelist03"},
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
	entidEnvRaw := os.Getenv("TVMAZE_TEST_SHOW_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"TVMAZE_TEST_SHOW_ENTID": idmap,
		"TVMAZE_TEST_LIVE":      "FALSE",
		"TVMAZE_TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["TVMAZE_TEST_SHOW_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["TVMAZE_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
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

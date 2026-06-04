<?php
declare(strict_types=1);

// GuestCastCredit entity test

require_once __DIR__ . '/../tvmaze_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class GuestCastCreditEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = TvmazeSDK::test(null, null);
        $ent = $testsdk->GuestCastCredit(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = guest_cast_credit_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["list"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "guest_cast_credit." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $guest_cast_credit_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.guest_cast_credit")));
        $guest_cast_credit_ref01_data = null;
        if (count($guest_cast_credit_ref01_data_raw) > 0) {
            $guest_cast_credit_ref01_data = Helpers::to_map($guest_cast_credit_ref01_data_raw[0][1]);
        }

        // LIST
        $guest_cast_credit_ref01_ent = $client->GuestCastCredit(null);
        $guest_cast_credit_ref01_match = [
            "person_id" => $setup["idmap"]["person01"],
        ];

        [$guest_cast_credit_ref01_list_result, $err] = $guest_cast_credit_ref01_ent->list($guest_cast_credit_ref01_match, null);
        $this->assertNull($err);
        $this->assertIsArray($guest_cast_credit_ref01_list_result);

    }
}

function guest_cast_credit_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/guest_cast_credit/GuestCastCreditTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = TvmazeSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["guest_cast_credit01", "guest_cast_credit02", "guest_cast_credit03", "person01", "person02", "person03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID" => $idmap,
        "TVMAZE_TEST_LIVE" => "FALSE",
        "TVMAZE_TEST_EXPLAIN" => "FALSE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["TVMAZE_TEST_GUEST_CAST_CREDIT_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["TVMAZE_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
            ],
            $extra ?? [],
        ]);
        $client = new TvmazeSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["TVMAZE_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["TVMAZE_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}

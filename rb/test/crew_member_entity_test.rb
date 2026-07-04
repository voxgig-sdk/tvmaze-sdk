# CrewMember entity test

require "minitest/autorun"
require "json"
require_relative "../Tvmaze_sdk"
require_relative "runner"

class CrewMemberEntityTest < Minitest::Test
  def test_create_instance
    testsdk = TvmazeSDK.test(nil, nil)
    ent = testsdk.CrewMember(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = crew_member_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["list"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "crew_member." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set TVMAZE_TEST_CREW_MEMBER_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    crew_member_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.crew_member")))
    crew_member_ref01_data = nil
    if crew_member_ref01_data_raw.length > 0
      crew_member_ref01_data = Helpers.to_map(crew_member_ref01_data_raw[0][1])
    end

    # LIST
    crew_member_ref01_ent = client.CrewMember(nil)
    crew_member_ref01_match = {
      "episode_id" => setup[:idmap]["episode01"],
    }

    crew_member_ref01_list_result = crew_member_ref01_ent.list(crew_member_ref01_match, nil)
    assert crew_member_ref01_list_result.is_a?(Array)

  end
end

def crew_member_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "crew_member", "CrewMemberTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = TvmazeSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["crew_member01", "crew_member02", "crew_member03", "episode01", "episode02", "episode03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["TVMAZE_TEST_CREW_MEMBER_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "TVMAZE_TEST_CREW_MEMBER_ENTID" => idmap,
    "TVMAZE_TEST_LIVE" => "FALSE",
    "TVMAZE_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["TVMAZE_TEST_CREW_MEMBER_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["TVMAZE_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
      },
      extra || {},
    ])
    client = TvmazeSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["TVMAZE_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["TVMAZE_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end

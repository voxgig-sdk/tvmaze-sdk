<?php
declare(strict_types=1);

// Tvmaze SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

class TvmazeSDK
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new TvmazeUtility();
        $this->_utility = $utility;

        $config = TvmazeConfig::make_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Add features from config.
        $feature_opts = TvmazeHelpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $items = Struct::items($feature_opts);
            if ($items) {
                foreach ($items as $item) {
                    $fname = $item[0];
                    $fopts = TvmazeHelpers::to_map($item[1]);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        ($utility->feature_add)($this->_rootctx, TvmazeFeatures::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        $extend_val = Struct::getprop($this->options, "extend");
        if (is_array($extend_val)) {
            foreach ($extend_val as $f) {
                if (is_object($f) && method_exists($f, 'get_name')) {
                    ($utility->feature_add)($this->_rootctx, $f);
                }
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    public function get_utility()
    {
        return TvmazeUtility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): array
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = TvmazeHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = TvmazeHelpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = TvmazeHelpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new TvmazeSpec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return [null, $err];
        }

        return ($utility->make_fetch_def)($ctx);
    }

    public function direct(array $fetchargs = []): array
    {
        $utility = $this->_utility;

        [$fetchdef, $err] = $this->prepare($fetchargs);
        if ($err) {
            return [["ok" => false, "err" => $err], null];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = TvmazeHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return [["ok" => false, "err" => $fetch_err], null];
        }

        if ($fetched === null) {
            return [[
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ], null];
        }

        if (is_array($fetched)) {
            $status = TvmazeHelpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [[
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ], null];
        }

        return [[
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ], null];
    }


    public function Aka($data = null)
    {
        require_once __DIR__ . '/entity/aka_entity.php';
        return new AkaEntity($this, $data);
    }


    public function AlternateList($data = null)
    {
        require_once __DIR__ . '/entity/alternate_list_entity.php';
        return new AlternateListEntity($this, $data);
    }


    public function Cast($data = null)
    {
        require_once __DIR__ . '/entity/cast_entity.php';
        return new CastEntity($this, $data);
    }


    public function CastCredit($data = null)
    {
        require_once __DIR__ . '/entity/cast_credit_entity.php';
        return new CastCreditEntity($this, $data);
    }


    public function CastMember($data = null)
    {
        require_once __DIR__ . '/entity/cast_member_entity.php';
        return new CastMemberEntity($this, $data);
    }


    public function Crew($data = null)
    {
        require_once __DIR__ . '/entity/crew_entity.php';
        return new CrewEntity($this, $data);
    }


    public function CrewCredit($data = null)
    {
        require_once __DIR__ . '/entity/crew_credit_entity.php';
        return new CrewCreditEntity($this, $data);
    }


    public function CrewMember($data = null)
    {
        require_once __DIR__ . '/entity/crew_member_entity.php';
        return new CrewMemberEntity($this, $data);
    }


    public function Episode($data = null)
    {
        require_once __DIR__ . '/entity/episode_entity.php';
        return new EpisodeEntity($this, $data);
    }


    public function GuestCastCredit($data = null)
    {
        require_once __DIR__ . '/entity/guest_cast_credit_entity.php';
        return new GuestCastCreditEntity($this, $data);
    }


    public function Image($data = null)
    {
        require_once __DIR__ . '/entity/image_entity.php';
        return new ImageEntity($this, $data);
    }


    public function Person($data = null)
    {
        require_once __DIR__ . '/entity/person_entity.php';
        return new PersonEntity($this, $data);
    }


    public function Schedule($data = null)
    {
        require_once __DIR__ . '/entity/schedule_entity.php';
        return new ScheduleEntity($this, $data);
    }


    public function ScheduledEpisode($data = null)
    {
        require_once __DIR__ . '/entity/scheduled_episode_entity.php';
        return new ScheduledEpisodeEntity($this, $data);
    }


    public function Search($data = null)
    {
        require_once __DIR__ . '/entity/search_entity.php';
        return new SearchEntity($this, $data);
    }


    public function Season($data = null)
    {
        require_once __DIR__ . '/entity/season_entity.php';
        return new SeasonEntity($this, $data);
    }


    public function Show($data = null)
    {
        require_once __DIR__ . '/entity/show_entity.php';
        return new ShowEntity($this, $data);
    }


    public function Update($data = null)
    {
        require_once __DIR__ . '/entity/update_entity.php';
        return new UpdateEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new TvmazeSDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}

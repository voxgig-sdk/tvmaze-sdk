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

    public function prepare(array $fetchargs = []): mixed
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
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    public function direct(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
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
            return ["ok" => false, "err" => $fetch_err];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
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

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }


    private $_aka = null;

    // Canonical facade: $client->Aka()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->aka()
    // resolves here too.
    public function Aka($data = null)
    {
        require_once __DIR__ . '/entity/aka_entity.php';
        if ($data === null) {
            if ($this->_aka === null) {
                $this->_aka = new AkaEntity($this, null);
            }
            return $this->_aka;
        }
        return new AkaEntity($this, $data);
    }


    private $_alternate_list = null;

    // Canonical facade: $client->AlternateList()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->alternate_list()
    // resolves here too.
    public function AlternateList($data = null)
    {
        require_once __DIR__ . '/entity/alternate_list_entity.php';
        if ($data === null) {
            if ($this->_alternate_list === null) {
                $this->_alternate_list = new AlternateListEntity($this, null);
            }
            return $this->_alternate_list;
        }
        return new AlternateListEntity($this, $data);
    }


    private $_cast = null;

    // Canonical facade: $client->Cast()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->cast()
    // resolves here too.
    public function Cast($data = null)
    {
        require_once __DIR__ . '/entity/cast_entity.php';
        if ($data === null) {
            if ($this->_cast === null) {
                $this->_cast = new CastEntity($this, null);
            }
            return $this->_cast;
        }
        return new CastEntity($this, $data);
    }


    private $_cast_credit = null;

    // Canonical facade: $client->CastCredit()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->cast_credit()
    // resolves here too.
    public function CastCredit($data = null)
    {
        require_once __DIR__ . '/entity/cast_credit_entity.php';
        if ($data === null) {
            if ($this->_cast_credit === null) {
                $this->_cast_credit = new CastCreditEntity($this, null);
            }
            return $this->_cast_credit;
        }
        return new CastCreditEntity($this, $data);
    }


    private $_cast_member = null;

    // Canonical facade: $client->CastMember()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->cast_member()
    // resolves here too.
    public function CastMember($data = null)
    {
        require_once __DIR__ . '/entity/cast_member_entity.php';
        if ($data === null) {
            if ($this->_cast_member === null) {
                $this->_cast_member = new CastMemberEntity($this, null);
            }
            return $this->_cast_member;
        }
        return new CastMemberEntity($this, $data);
    }


    private $_crew = null;

    // Canonical facade: $client->Crew()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->crew()
    // resolves here too.
    public function Crew($data = null)
    {
        require_once __DIR__ . '/entity/crew_entity.php';
        if ($data === null) {
            if ($this->_crew === null) {
                $this->_crew = new CrewEntity($this, null);
            }
            return $this->_crew;
        }
        return new CrewEntity($this, $data);
    }


    private $_crew_credit = null;

    // Canonical facade: $client->CrewCredit()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->crew_credit()
    // resolves here too.
    public function CrewCredit($data = null)
    {
        require_once __DIR__ . '/entity/crew_credit_entity.php';
        if ($data === null) {
            if ($this->_crew_credit === null) {
                $this->_crew_credit = new CrewCreditEntity($this, null);
            }
            return $this->_crew_credit;
        }
        return new CrewCreditEntity($this, $data);
    }


    private $_crew_member = null;

    // Canonical facade: $client->CrewMember()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->crew_member()
    // resolves here too.
    public function CrewMember($data = null)
    {
        require_once __DIR__ . '/entity/crew_member_entity.php';
        if ($data === null) {
            if ($this->_crew_member === null) {
                $this->_crew_member = new CrewMemberEntity($this, null);
            }
            return $this->_crew_member;
        }
        return new CrewMemberEntity($this, $data);
    }


    private $_episode = null;

    // Canonical facade: $client->Episode()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->episode()
    // resolves here too.
    public function Episode($data = null)
    {
        require_once __DIR__ . '/entity/episode_entity.php';
        if ($data === null) {
            if ($this->_episode === null) {
                $this->_episode = new EpisodeEntity($this, null);
            }
            return $this->_episode;
        }
        return new EpisodeEntity($this, $data);
    }


    private $_guest_cast_credit = null;

    // Canonical facade: $client->GuestCastCredit()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->guest_cast_credit()
    // resolves here too.
    public function GuestCastCredit($data = null)
    {
        require_once __DIR__ . '/entity/guest_cast_credit_entity.php';
        if ($data === null) {
            if ($this->_guest_cast_credit === null) {
                $this->_guest_cast_credit = new GuestCastCreditEntity($this, null);
            }
            return $this->_guest_cast_credit;
        }
        return new GuestCastCreditEntity($this, $data);
    }


    private $_image = null;

    // Canonical facade: $client->Image()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->image()
    // resolves here too.
    public function Image($data = null)
    {
        require_once __DIR__ . '/entity/image_entity.php';
        if ($data === null) {
            if ($this->_image === null) {
                $this->_image = new ImageEntity($this, null);
            }
            return $this->_image;
        }
        return new ImageEntity($this, $data);
    }


    private $_person = null;

    // Canonical facade: $client->Person()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->person()
    // resolves here too.
    public function Person($data = null)
    {
        require_once __DIR__ . '/entity/person_entity.php';
        if ($data === null) {
            if ($this->_person === null) {
                $this->_person = new PersonEntity($this, null);
            }
            return $this->_person;
        }
        return new PersonEntity($this, $data);
    }


    private $_schedule = null;

    // Canonical facade: $client->Schedule()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->schedule()
    // resolves here too.
    public function Schedule($data = null)
    {
        require_once __DIR__ . '/entity/schedule_entity.php';
        if ($data === null) {
            if ($this->_schedule === null) {
                $this->_schedule = new ScheduleEntity($this, null);
            }
            return $this->_schedule;
        }
        return new ScheduleEntity($this, $data);
    }


    private $_scheduled_episode = null;

    // Canonical facade: $client->ScheduledEpisode()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->scheduled_episode()
    // resolves here too.
    public function ScheduledEpisode($data = null)
    {
        require_once __DIR__ . '/entity/scheduled_episode_entity.php';
        if ($data === null) {
            if ($this->_scheduled_episode === null) {
                $this->_scheduled_episode = new ScheduledEpisodeEntity($this, null);
            }
            return $this->_scheduled_episode;
        }
        return new ScheduledEpisodeEntity($this, $data);
    }


    private $_search = null;

    // Canonical facade: $client->Search()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->search()
    // resolves here too.
    public function Search($data = null)
    {
        require_once __DIR__ . '/entity/search_entity.php';
        if ($data === null) {
            if ($this->_search === null) {
                $this->_search = new SearchEntity($this, null);
            }
            return $this->_search;
        }
        return new SearchEntity($this, $data);
    }


    private $_season = null;

    // Canonical facade: $client->Season()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->season()
    // resolves here too.
    public function Season($data = null)
    {
        require_once __DIR__ . '/entity/season_entity.php';
        if ($data === null) {
            if ($this->_season === null) {
                $this->_season = new SeasonEntity($this, null);
            }
            return $this->_season;
        }
        return new SeasonEntity($this, $data);
    }


    private $_show = null;

    // Canonical facade: $client->Show()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->show()
    // resolves here too.
    public function Show($data = null)
    {
        require_once __DIR__ . '/entity/show_entity.php';
        if ($data === null) {
            if ($this->_show === null) {
                $this->_show = new ShowEntity($this, null);
            }
            return $this->_show;
        }
        return new ShowEntity($this, $data);
    }


    private $_update = null;

    // Canonical facade: $client->Update()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->update()
    // resolves here too.
    public function Update($data = null)
    {
        require_once __DIR__ . '/entity/update_entity.php';
        if ($data === null) {
            if ($this->_update === null) {
                $this->_update = new UpdateEntity($this, null);
            }
            return $this->_update;
        }
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

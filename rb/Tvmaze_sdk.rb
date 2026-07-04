# Tvmaze SDK

require_relative 'utility/struct/voxgig_struct'
require_relative 'core/utility_type'
require_relative 'core/spec'
require_relative 'core/helpers'

# Load utility registration
require_relative 'utility/register'

# Load config and features
require_relative 'config'
require_relative 'feature/base_feature'
require_relative 'features'

# Load typed models (Struct value objects).
require_relative 'Tvmaze_types'


class TvmazeSDK
  attr_accessor :mode, :features, :options

  def initialize(options = {})
    @mode = "live"
    @features = []
    @options = nil

    utility = TvmazeUtility.new
    @_utility = utility

    config = TvmazeConfig.make_config

    @_rootctx = utility.make_context.call({
      "client" => self,
      "utility" => utility,
      "config" => config,
      "options" => options || {},
      "shared" => {},
    }, nil)

    @options = utility.make_options.call(@_rootctx)

    if VoxgigStruct.getpath(@options, "feature.test.active") == true
      @mode = "test"
    end

    @_rootctx.options = @options

    # Add features from config.
    feature_opts = TvmazeHelpers.to_map(VoxgigStruct.getprop(@options, "feature"))
    if feature_opts
      items = VoxgigStruct.items(feature_opts)
      if items
        items.each do |item|
          fname = item[0]
          fopts = TvmazeHelpers.to_map(item[1])
          if fopts && fopts["active"] == true
            utility.feature_add.call(@_rootctx, TvmazeFeatures.make_feature(fname))
          end
        end
      end
    end

    # Add extension features.
    extend_val = VoxgigStruct.getprop(@options, "extend")
    if extend_val.is_a?(Array)
      extend_val.each do |f|
        if f.respond_to?(:get_name)
          utility.feature_add.call(@_rootctx, f)
        end
      end
    end

    # Initialize features.
    @features.each do |f|
      utility.feature_init.call(@_rootctx, f)
    end

    utility.feature_hook.call(@_rootctx, "PostConstruct")
  end

  def options_map
    out = VoxgigStruct.clone(@options)
    out.is_a?(Hash) ? out : {}
  end

  def get_utility
    TvmazeUtility.copy(@_utility)
  end

  def get_root_ctx
    @_rootctx
  end

  def prepare(fetchargs = {})
    utility = @_utility
    fetchargs ||= {}

    ctrl = TvmazeHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "prepare",
      "ctrl" => ctrl,
    }, @_rootctx)

    opts = @options
    path = VoxgigStruct.getprop(fetchargs, "path") || ""
    path = "" unless path.is_a?(String)
    method_val = VoxgigStruct.getprop(fetchargs, "method") || "GET"
    method_val = "GET" unless method_val.is_a?(String)
    params = TvmazeHelpers.to_map(VoxgigStruct.getprop(fetchargs, "params")) || {}
    query = TvmazeHelpers.to_map(VoxgigStruct.getprop(fetchargs, "query")) || {}
    headers = utility.prepare_headers.call(ctx)

    base = VoxgigStruct.getprop(opts, "base") || ""
    base = "" unless base.is_a?(String)
    prefix = VoxgigStruct.getprop(opts, "prefix") || ""
    prefix = "" unless prefix.is_a?(String)
    suffix = VoxgigStruct.getprop(opts, "suffix") || ""
    suffix = "" unless suffix.is_a?(String)

    ctx.spec = TvmazeSpec.new({
      "base" => base, "prefix" => prefix, "suffix" => suffix,
      "path" => path, "method" => method_val,
      "params" => params, "query" => query, "headers" => headers,
      "body" => VoxgigStruct.getprop(fetchargs, "body"),
      "step" => "start",
    })

    # Merge user-provided headers.
    uh = VoxgigStruct.getprop(fetchargs, "headers")
    if uh.is_a?(Hash)
      uh.each { |k, v| ctx.spec.headers[k] = v }
    end

    _, err = utility.prepare_auth.call(ctx)
    raise err if err

    utility.make_fetch_def.call(ctx)
  end

  def direct(fetchargs = {})
    utility = @_utility

    # direct() is the raw-HTTP escape hatch: it always returns a result hash
    # ({ "ok" => ..., ... }) and never raises. prepare() raises on error, so
    # trap that and surface it in the hash.
    begin
      fetchdef = prepare(fetchargs)
    rescue TvmazeError => err
      return { "ok" => false, "err" => err }
    end

    fetchargs ||= {}
    ctrl = TvmazeHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "direct",
      "ctrl" => ctrl,
    }, @_rootctx)

    url = fetchdef["url"] || ""
    fetched, fetch_err = utility.fetcher.call(ctx, url, fetchdef)

    return { "ok" => false, "err" => fetch_err } if fetch_err

    if fetched.nil?
      return {
        "ok" => false,
        "err" => ctx.make_error("direct_no_response", "response: undefined"),
      }
    end

    if fetched.is_a?(Hash)
      status = TvmazeHelpers.to_int(VoxgigStruct.getprop(fetched, "status"))
      headers = VoxgigStruct.getprop(fetched, "headers") || {}

      # No-body responses (204, 304) and explicit zero content-length must
      # skip JSON parsing — calling json() on an empty body errors.
      content_length = headers.is_a?(Hash) ? headers["content-length"] : nil
      no_body = status == 204 || status == 304 || content_length.to_s == "0"

      json_data = nil
      unless no_body
        jf = VoxgigStruct.getprop(fetched, "json")
        if jf.is_a?(Proc)
          begin
            json_data = jf.call
          rescue StandardError
            # Non-JSON body — leave data nil, keep status/headers.
            json_data = nil
          end
        end
      end

      return {
        "ok" => status >= 200 && status < 300,
        "status" => status,
        "headers" => headers,
        "data" => json_data,
      }
    end

    return {
      "ok" => false,
      "err" => ctx.make_error("direct_invalid", "invalid response type"),
    }
  end


  # Idiomatic facade: client.aka.list / client.aka.load({ "id" => ... })
  def aka
    require_relative 'entity/aka_entity'
    @aka ||= AkaEntity.new(self, nil)
  end

  # Deprecated: use client.aka instead.
  def Aka(data = nil)
    require_relative 'entity/aka_entity'
    AkaEntity.new(self, data)
  end


  # Idiomatic facade: client.alternate_list.list / client.alternate_list.load({ "id" => ... })
  def alternate_list
    require_relative 'entity/alternate_list_entity'
    @alternate_list ||= AlternateListEntity.new(self, nil)
  end

  # Deprecated: use client.alternate_list instead.
  def AlternateList(data = nil)
    require_relative 'entity/alternate_list_entity'
    AlternateListEntity.new(self, data)
  end


  # Idiomatic facade: client.cast.list / client.cast.load({ "id" => ... })
  def cast
    require_relative 'entity/cast_entity'
    @cast ||= CastEntity.new(self, nil)
  end

  # Deprecated: use client.cast instead.
  def Cast(data = nil)
    require_relative 'entity/cast_entity'
    CastEntity.new(self, data)
  end


  # Idiomatic facade: client.cast_credit.list / client.cast_credit.load({ "id" => ... })
  def cast_credit
    require_relative 'entity/cast_credit_entity'
    @cast_credit ||= CastCreditEntity.new(self, nil)
  end

  # Deprecated: use client.cast_credit instead.
  def CastCredit(data = nil)
    require_relative 'entity/cast_credit_entity'
    CastCreditEntity.new(self, data)
  end


  # Idiomatic facade: client.cast_member.list / client.cast_member.load({ "id" => ... })
  def cast_member
    require_relative 'entity/cast_member_entity'
    @cast_member ||= CastMemberEntity.new(self, nil)
  end

  # Deprecated: use client.cast_member instead.
  def CastMember(data = nil)
    require_relative 'entity/cast_member_entity'
    CastMemberEntity.new(self, data)
  end


  # Idiomatic facade: client.crew.list / client.crew.load({ "id" => ... })
  def crew
    require_relative 'entity/crew_entity'
    @crew ||= CrewEntity.new(self, nil)
  end

  # Deprecated: use client.crew instead.
  def Crew(data = nil)
    require_relative 'entity/crew_entity'
    CrewEntity.new(self, data)
  end


  # Idiomatic facade: client.crew_credit.list / client.crew_credit.load({ "id" => ... })
  def crew_credit
    require_relative 'entity/crew_credit_entity'
    @crew_credit ||= CrewCreditEntity.new(self, nil)
  end

  # Deprecated: use client.crew_credit instead.
  def CrewCredit(data = nil)
    require_relative 'entity/crew_credit_entity'
    CrewCreditEntity.new(self, data)
  end


  # Idiomatic facade: client.crew_member.list / client.crew_member.load({ "id" => ... })
  def crew_member
    require_relative 'entity/crew_member_entity'
    @crew_member ||= CrewMemberEntity.new(self, nil)
  end

  # Deprecated: use client.crew_member instead.
  def CrewMember(data = nil)
    require_relative 'entity/crew_member_entity'
    CrewMemberEntity.new(self, data)
  end


  # Idiomatic facade: client.episode.list / client.episode.load({ "id" => ... })
  def episode
    require_relative 'entity/episode_entity'
    @episode ||= EpisodeEntity.new(self, nil)
  end

  # Deprecated: use client.episode instead.
  def Episode(data = nil)
    require_relative 'entity/episode_entity'
    EpisodeEntity.new(self, data)
  end


  # Idiomatic facade: client.guest_cast_credit.list / client.guest_cast_credit.load({ "id" => ... })
  def guest_cast_credit
    require_relative 'entity/guest_cast_credit_entity'
    @guest_cast_credit ||= GuestCastCreditEntity.new(self, nil)
  end

  # Deprecated: use client.guest_cast_credit instead.
  def GuestCastCredit(data = nil)
    require_relative 'entity/guest_cast_credit_entity'
    GuestCastCreditEntity.new(self, data)
  end


  # Idiomatic facade: client.image.list / client.image.load({ "id" => ... })
  def image
    require_relative 'entity/image_entity'
    @image ||= ImageEntity.new(self, nil)
  end

  # Deprecated: use client.image instead.
  def Image(data = nil)
    require_relative 'entity/image_entity'
    ImageEntity.new(self, data)
  end


  # Idiomatic facade: client.person.list / client.person.load({ "id" => ... })
  def person
    require_relative 'entity/person_entity'
    @person ||= PersonEntity.new(self, nil)
  end

  # Deprecated: use client.person instead.
  def Person(data = nil)
    require_relative 'entity/person_entity'
    PersonEntity.new(self, data)
  end


  # Idiomatic facade: client.schedule.list / client.schedule.load({ "id" => ... })
  def schedule
    require_relative 'entity/schedule_entity'
    @schedule ||= ScheduleEntity.new(self, nil)
  end

  # Deprecated: use client.schedule instead.
  def Schedule(data = nil)
    require_relative 'entity/schedule_entity'
    ScheduleEntity.new(self, data)
  end


  # Idiomatic facade: client.scheduled_episode.list / client.scheduled_episode.load({ "id" => ... })
  def scheduled_episode
    require_relative 'entity/scheduled_episode_entity'
    @scheduled_episode ||= ScheduledEpisodeEntity.new(self, nil)
  end

  # Deprecated: use client.scheduled_episode instead.
  def ScheduledEpisode(data = nil)
    require_relative 'entity/scheduled_episode_entity'
    ScheduledEpisodeEntity.new(self, data)
  end


  # Idiomatic facade: client.search.list / client.search.load({ "id" => ... })
  def search
    require_relative 'entity/search_entity'
    @search ||= SearchEntity.new(self, nil)
  end

  # Deprecated: use client.search instead.
  def Search(data = nil)
    require_relative 'entity/search_entity'
    SearchEntity.new(self, data)
  end


  # Idiomatic facade: client.season.list / client.season.load({ "id" => ... })
  def season
    require_relative 'entity/season_entity'
    @season ||= SeasonEntity.new(self, nil)
  end

  # Deprecated: use client.season instead.
  def Season(data = nil)
    require_relative 'entity/season_entity'
    SeasonEntity.new(self, data)
  end


  # Idiomatic facade: client.show.list / client.show.load({ "id" => ... })
  def show
    require_relative 'entity/show_entity'
    @show ||= ShowEntity.new(self, nil)
  end

  # Deprecated: use client.show instead.
  def Show(data = nil)
    require_relative 'entity/show_entity'
    ShowEntity.new(self, data)
  end


  # Idiomatic facade: client.update.list / client.update.load({ "id" => ... })
  def update
    require_relative 'entity/update_entity'
    @update ||= UpdateEntity.new(self, nil)
  end

  # Deprecated: use client.update instead.
  def Update(data = nil)
    require_relative 'entity/update_entity'
    UpdateEntity.new(self, data)
  end



  def self.test(testopts = nil, sdkopts = nil)
    sdkopts = sdkopts || {}
    sdkopts = VoxgigStruct.clone(sdkopts)
    sdkopts = {} unless sdkopts.is_a?(Hash)

    testopts = testopts || {}
    testopts = VoxgigStruct.clone(testopts)
    testopts = {} unless testopts.is_a?(Hash)
    testopts["active"] = true

    VoxgigStruct.setpath(sdkopts, "feature.test", testopts)

    sdk = TvmazeSDK.new(sdkopts)
    sdk.mode = "test"
    sdk
  end
end

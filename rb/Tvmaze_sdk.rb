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

    # Add features in the resolved order (make_options puts an explicit array
    # order first, else defaults to test-first). Ordering matters: the `test`
    # feature installs the base mock transport and the transport features
    # (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
    # must be added before them to sit at the base of the chain.
    feature_opts = TvmazeHelpers.to_map(VoxgigStruct.getprop(@options, "feature"))
    if feature_opts
      featureorder = VoxgigStruct.getpath(@options, "__derived__.featureorder")
      if featureorder.is_a?(Array)
        featureorder.each do |fname|
          fopts = TvmazeHelpers.to_map(feature_opts[fname])
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

    # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
    # return just the fetchdef Hash (raising on error) so callers — including
    # direct(), which indexes fetchdef["url"] — receive a Hash, mirroring the
    # ts/py prepare().
    fetchdef, fd_err = utility.make_fetch_def.call(ctx)
    raise fd_err if fd_err

    fetchdef
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


  # Canonical facade: client.Aka.list / client.Aka.load({ "id" => ... })
  def Aka(data = nil)
    require_relative 'entity/aka_entity'
    AkaEntity.new(self, data)
  end


  # Canonical facade: client.AlternateList.list / client.AlternateList.load({ "id" => ... })
  def AlternateList(data = nil)
    require_relative 'entity/alternate_list_entity'
    AlternateListEntity.new(self, data)
  end


  # Canonical facade: client.Cast.list / client.Cast.load({ "id" => ... })
  def Cast(data = nil)
    require_relative 'entity/cast_entity'
    CastEntity.new(self, data)
  end


  # Canonical facade: client.CastCredit.list / client.CastCredit.load({ "id" => ... })
  def CastCredit(data = nil)
    require_relative 'entity/cast_credit_entity'
    CastCreditEntity.new(self, data)
  end


  # Canonical facade: client.CastMember.list / client.CastMember.load({ "id" => ... })
  def CastMember(data = nil)
    require_relative 'entity/cast_member_entity'
    CastMemberEntity.new(self, data)
  end


  # Canonical facade: client.Crew.list / client.Crew.load({ "id" => ... })
  def Crew(data = nil)
    require_relative 'entity/crew_entity'
    CrewEntity.new(self, data)
  end


  # Canonical facade: client.CrewCredit.list / client.CrewCredit.load({ "id" => ... })
  def CrewCredit(data = nil)
    require_relative 'entity/crew_credit_entity'
    CrewCreditEntity.new(self, data)
  end


  # Canonical facade: client.CrewMember.list / client.CrewMember.load({ "id" => ... })
  def CrewMember(data = nil)
    require_relative 'entity/crew_member_entity'
    CrewMemberEntity.new(self, data)
  end


  # Canonical facade: client.Episode.list / client.Episode.load({ "id" => ... })
  def Episode(data = nil)
    require_relative 'entity/episode_entity'
    EpisodeEntity.new(self, data)
  end


  # Canonical facade: client.GuestCastCredit.list / client.GuestCastCredit.load({ "id" => ... })
  def GuestCastCredit(data = nil)
    require_relative 'entity/guest_cast_credit_entity'
    GuestCastCreditEntity.new(self, data)
  end


  # Canonical facade: client.Image.list / client.Image.load({ "id" => ... })
  def Image(data = nil)
    require_relative 'entity/image_entity'
    ImageEntity.new(self, data)
  end


  # Canonical facade: client.Person.list / client.Person.load({ "id" => ... })
  def Person(data = nil)
    require_relative 'entity/person_entity'
    PersonEntity.new(self, data)
  end


  # Canonical facade: client.Schedule.list / client.Schedule.load({ "id" => ... })
  def Schedule(data = nil)
    require_relative 'entity/schedule_entity'
    ScheduleEntity.new(self, data)
  end


  # Canonical facade: client.ScheduledEpisode.list / client.ScheduledEpisode.load({ "id" => ... })
  def ScheduledEpisode(data = nil)
    require_relative 'entity/scheduled_episode_entity'
    ScheduledEpisodeEntity.new(self, data)
  end


  # Canonical facade: client.Search.list / client.Search.load({ "id" => ... })
  def Search(data = nil)
    require_relative 'entity/search_entity'
    SearchEntity.new(self, data)
  end


  # Canonical facade: client.Season.list / client.Season.load({ "id" => ... })
  def Season(data = nil)
    require_relative 'entity/season_entity'
    SeasonEntity.new(self, data)
  end


  # Canonical facade: client.Show.list / client.Show.load({ "id" => ... })
  def Show(data = nil)
    require_relative 'entity/show_entity'
    ShowEntity.new(self, data)
  end


  # Canonical facade: client.Update.list / client.Update.load({ "id" => ... })
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

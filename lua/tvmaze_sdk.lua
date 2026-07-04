-- Tvmaze SDK

local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Load features
local BaseFeature = require("feature.base_feature")
local features_factory = require("features")


local TvmazeSDK = {}
TvmazeSDK.__index = TvmazeSDK


local function _make_feature(name)
  local factory = features_factory[name]
  if factory ~= nil then
    return factory()
  end
  return features_factory.base()
end

TvmazeSDK._make_feature = _make_feature


function TvmazeSDK.new(options)
  local self = setmetatable({}, TvmazeSDK)
  self.mode = "live"
  self.features = {}
  self.options = nil

  local utility = Utility.new()
  self._utility = utility

  local config = require("config")()

  self._rootctx = utility.make_context({
    client = self,
    utility = utility,
    config = config,
    options = options or {},
    shared = {},
  }, nil)

  self.options = utility.make_options(self._rootctx)

  if vs.getpath(self.options, "feature.test.active") == true then
    self.mode = "test"
  end

  self._rootctx.options = self.options

  -- Add features from config.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local feature_items = vs.items(feature_opts)
    if feature_items ~= nil then
      for _, item in ipairs(feature_items) do
        local fname = item[1]
        local fopts = helpers.to_map(item[2])
        if fopts ~= nil and fopts["active"] == true then
          utility.feature_add(self._rootctx, _make_feature(fname))
        end
      end
    end
  end

  -- Add extension features.
  local extend = vs.getprop(self.options, "extend")
  if type(extend) == "table" then
    for _, f in ipairs(extend) do
      if type(f) == "table" and type(f.get_name) == "function" then
        utility.feature_add(self._rootctx, f)
      end
    end
  end

  -- Initialize features.
  for _, f in ipairs(self.features) do
    utility.feature_init(self._rootctx, f)
  end

  utility.feature_hook(self._rootctx, "PostConstruct")

  -- #BuildFeatures

  return self
end


function TvmazeSDK:options_map()
  local out = vs.clone(self.options)
  if type(out) == "table" then
    return out
  end
  return {}
end


function TvmazeSDK:get_utility()
  return Utility.copy(self._utility)
end


function TvmazeSDK:get_root_ctx()
  return self._rootctx
end


function TvmazeSDK:prepare(fetchargs)
  local utility = self._utility

  fetchargs = fetchargs or {}

  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "prepare",
    ctrl = ctrl,
  }, self._rootctx)

  local options = self.options

  local path = vs.getprop(fetchargs, "path") or ""
  if type(path) ~= "string" then path = "" end

  local method = vs.getprop(fetchargs, "method") or "GET"
  if type(method) ~= "string" then method = "GET" end

  local params = helpers.to_map(vs.getprop(fetchargs, "params")) or {}
  local query = helpers.to_map(vs.getprop(fetchargs, "query")) or {}

  local headers = utility.prepare_headers(ctx)

  local base = vs.getprop(options, "base") or ""
  if type(base) ~= "string" then base = "" end
  local prefix = vs.getprop(options, "prefix") or ""
  if type(prefix) ~= "string" then prefix = "" end
  local suffix = vs.getprop(options, "suffix") or ""
  if type(suffix) ~= "string" then suffix = "" end

  ctx.spec = Spec.new({
    base = base,
    prefix = prefix,
    suffix = suffix,
    path = path,
    method = method,
    params = params,
    query = query,
    headers = headers,
    body = vs.getprop(fetchargs, "body"),
    step = "start",
  })

  -- Merge user-provided headers.
  local uh = vs.getprop(fetchargs, "headers")
  if type(uh) == "table" then
    for k, v in pairs(uh) do
      ctx.spec.headers[k] = v
    end
  end

  local _, err = utility.prepare_auth(ctx)
  if err ~= nil then
    return nil, err
  end

  return utility.make_fetch_def(ctx)
end


function TvmazeSDK:direct(fetchargs)
  local utility = self._utility

  local fetchdef, err = self:prepare(fetchargs)
  if err ~= nil then
    return { ok = false, err = err }, nil
  end

  fetchargs = fetchargs or {}
  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "direct",
    ctrl = ctrl,
  }, self._rootctx)

  local url = fetchdef["url"] or ""
  local fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

  if fetch_err ~= nil then
    return { ok = false, err = fetch_err }, nil
  end

  if fetched == nil then
    return {
      ok = false,
      err = ctx:make_error("direct_no_response", "response: undefined"),
    }, nil
  end

  if type(fetched) == "table" then
    local status = helpers.to_int(vs.getprop(fetched, "status"))
    local headers = vs.getprop(fetched, "headers") or {}

    -- No-body responses (204, 304) and explicit zero content-length
    -- must skip JSON parsing — calling json() on an empty body errors.
    local content_length = nil
    if type(headers) == "table" then
      content_length = headers["content-length"]
    end
    local no_body = status == 204 or status == 304 or tostring(content_length) == "0"

    local json_data = nil
    if not no_body then
      local jf = vs.getprop(fetched, "json")
      if type(jf) == "function" then
        local ok, result = pcall(jf)
        if ok then
          json_data = result
        end
        -- Non-JSON body: json_data stays nil, status/headers preserved.
      end
    end

    return {
      ok = status >= 200 and status < 300,
      status = status,
      headers = headers,
      data = json_data,
    }, nil
  end

  return {
    ok = false,
    err = ctx:make_error("direct_invalid", "invalid response type"),
  }, nil
end



-- Idiomatic facade: client:aka():list() / client:aka():load({ id = ... })
function TvmazeSDK:aka(data)
  local EntityMod = require("entity.aka_entity")
  if data == nil then
    if self._aka == nil then
      self._aka = EntityMod.new(self, nil)
    end
    return self._aka
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:aka() instead.
function TvmazeSDK:Aka(data)
  local EntityMod = require("entity.aka_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:alternate_list():list() / client:alternate_list():load({ id = ... })
function TvmazeSDK:alternate_list(data)
  local EntityMod = require("entity.alternate_list_entity")
  if data == nil then
    if self._alternate_list == nil then
      self._alternate_list = EntityMod.new(self, nil)
    end
    return self._alternate_list
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:alternate_list() instead.
function TvmazeSDK:AlternateList(data)
  local EntityMod = require("entity.alternate_list_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:cast():list() / client:cast():load({ id = ... })
function TvmazeSDK:cast(data)
  local EntityMod = require("entity.cast_entity")
  if data == nil then
    if self._cast == nil then
      self._cast = EntityMod.new(self, nil)
    end
    return self._cast
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:cast() instead.
function TvmazeSDK:Cast(data)
  local EntityMod = require("entity.cast_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:cast_credit():list() / client:cast_credit():load({ id = ... })
function TvmazeSDK:cast_credit(data)
  local EntityMod = require("entity.cast_credit_entity")
  if data == nil then
    if self._cast_credit == nil then
      self._cast_credit = EntityMod.new(self, nil)
    end
    return self._cast_credit
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:cast_credit() instead.
function TvmazeSDK:CastCredit(data)
  local EntityMod = require("entity.cast_credit_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:cast_member():list() / client:cast_member():load({ id = ... })
function TvmazeSDK:cast_member(data)
  local EntityMod = require("entity.cast_member_entity")
  if data == nil then
    if self._cast_member == nil then
      self._cast_member = EntityMod.new(self, nil)
    end
    return self._cast_member
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:cast_member() instead.
function TvmazeSDK:CastMember(data)
  local EntityMod = require("entity.cast_member_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:crew():list() / client:crew():load({ id = ... })
function TvmazeSDK:crew(data)
  local EntityMod = require("entity.crew_entity")
  if data == nil then
    if self._crew == nil then
      self._crew = EntityMod.new(self, nil)
    end
    return self._crew
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:crew() instead.
function TvmazeSDK:Crew(data)
  local EntityMod = require("entity.crew_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:crew_credit():list() / client:crew_credit():load({ id = ... })
function TvmazeSDK:crew_credit(data)
  local EntityMod = require("entity.crew_credit_entity")
  if data == nil then
    if self._crew_credit == nil then
      self._crew_credit = EntityMod.new(self, nil)
    end
    return self._crew_credit
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:crew_credit() instead.
function TvmazeSDK:CrewCredit(data)
  local EntityMod = require("entity.crew_credit_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:crew_member():list() / client:crew_member():load({ id = ... })
function TvmazeSDK:crew_member(data)
  local EntityMod = require("entity.crew_member_entity")
  if data == nil then
    if self._crew_member == nil then
      self._crew_member = EntityMod.new(self, nil)
    end
    return self._crew_member
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:crew_member() instead.
function TvmazeSDK:CrewMember(data)
  local EntityMod = require("entity.crew_member_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:episode():list() / client:episode():load({ id = ... })
function TvmazeSDK:episode(data)
  local EntityMod = require("entity.episode_entity")
  if data == nil then
    if self._episode == nil then
      self._episode = EntityMod.new(self, nil)
    end
    return self._episode
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:episode() instead.
function TvmazeSDK:Episode(data)
  local EntityMod = require("entity.episode_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:guest_cast_credit():list() / client:guest_cast_credit():load({ id = ... })
function TvmazeSDK:guest_cast_credit(data)
  local EntityMod = require("entity.guest_cast_credit_entity")
  if data == nil then
    if self._guest_cast_credit == nil then
      self._guest_cast_credit = EntityMod.new(self, nil)
    end
    return self._guest_cast_credit
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:guest_cast_credit() instead.
function TvmazeSDK:GuestCastCredit(data)
  local EntityMod = require("entity.guest_cast_credit_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:image():list() / client:image():load({ id = ... })
function TvmazeSDK:image(data)
  local EntityMod = require("entity.image_entity")
  if data == nil then
    if self._image == nil then
      self._image = EntityMod.new(self, nil)
    end
    return self._image
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:image() instead.
function TvmazeSDK:Image(data)
  local EntityMod = require("entity.image_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:person():list() / client:person():load({ id = ... })
function TvmazeSDK:person(data)
  local EntityMod = require("entity.person_entity")
  if data == nil then
    if self._person == nil then
      self._person = EntityMod.new(self, nil)
    end
    return self._person
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:person() instead.
function TvmazeSDK:Person(data)
  local EntityMod = require("entity.person_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:schedule():list() / client:schedule():load({ id = ... })
function TvmazeSDK:schedule(data)
  local EntityMod = require("entity.schedule_entity")
  if data == nil then
    if self._schedule == nil then
      self._schedule = EntityMod.new(self, nil)
    end
    return self._schedule
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:schedule() instead.
function TvmazeSDK:Schedule(data)
  local EntityMod = require("entity.schedule_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:scheduled_episode():list() / client:scheduled_episode():load({ id = ... })
function TvmazeSDK:scheduled_episode(data)
  local EntityMod = require("entity.scheduled_episode_entity")
  if data == nil then
    if self._scheduled_episode == nil then
      self._scheduled_episode = EntityMod.new(self, nil)
    end
    return self._scheduled_episode
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:scheduled_episode() instead.
function TvmazeSDK:ScheduledEpisode(data)
  local EntityMod = require("entity.scheduled_episode_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:search():list() / client:search():load({ id = ... })
function TvmazeSDK:search(data)
  local EntityMod = require("entity.search_entity")
  if data == nil then
    if self._search == nil then
      self._search = EntityMod.new(self, nil)
    end
    return self._search
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:search() instead.
function TvmazeSDK:Search(data)
  local EntityMod = require("entity.search_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:season():list() / client:season():load({ id = ... })
function TvmazeSDK:season(data)
  local EntityMod = require("entity.season_entity")
  if data == nil then
    if self._season == nil then
      self._season = EntityMod.new(self, nil)
    end
    return self._season
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:season() instead.
function TvmazeSDK:Season(data)
  local EntityMod = require("entity.season_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:show():list() / client:show():load({ id = ... })
function TvmazeSDK:show(data)
  local EntityMod = require("entity.show_entity")
  if data == nil then
    if self._show == nil then
      self._show = EntityMod.new(self, nil)
    end
    return self._show
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:show() instead.
function TvmazeSDK:Show(data)
  local EntityMod = require("entity.show_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:update():list() / client:update():load({ id = ... })
function TvmazeSDK:update(data)
  local EntityMod = require("entity.update_entity")
  if data == nil then
    if self._update == nil then
      self._update = EntityMod.new(self, nil)
    end
    return self._update
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:update() instead.
function TvmazeSDK:Update(data)
  local EntityMod = require("entity.update_entity")
  return EntityMod.new(self, data)
end




function TvmazeSDK.test(testopts, sdkopts)
  sdkopts = sdkopts or {}
  sdkopts = vs.clone(sdkopts)
  if type(sdkopts) ~= "table" then
    sdkopts = {}
  end

  testopts = testopts or {}
  testopts = vs.clone(testopts)
  if type(testopts) ~= "table" then
    testopts = {}
  end
  testopts["active"] = true

  vs.setpath(sdkopts, "feature.test", testopts)

  local sdk = TvmazeSDK.new(sdkopts)
  sdk.mode = "test"

  return sdk
end


return TvmazeSDK

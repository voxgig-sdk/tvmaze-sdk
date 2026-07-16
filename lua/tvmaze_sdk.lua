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

  -- Add features in the resolved order (make_options puts an explicit list
  -- order first, else defaults to test-first). Ordering matters: the `test`
  -- feature installs the base mock transport and the transport features
  -- (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
  -- must be added before them to sit at the base of the chain.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local featureorder = vs.getpath(self.options, "__derived__.featureorder")
    if type(featureorder) == "table" then
      for _, fname in ipairs(featureorder) do
        local fopts = helpers.to_map(feature_opts[fname])
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



-- Idiomatic facade: client:Aka():list() / client:Aka():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Aka(data)
  local EntityMod = require("entity.aka_entity")
  if data == nil then
    if self._aka == nil then
      self._aka = EntityMod.new(self, nil)
    end
    return self._aka
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:AlternateList():list() / client:AlternateList():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:AlternateList(data)
  local EntityMod = require("entity.alternate_list_entity")
  if data == nil then
    if self._alternate_list == nil then
      self._alternate_list = EntityMod.new(self, nil)
    end
    return self._alternate_list
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Cast():list() / client:Cast():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Cast(data)
  local EntityMod = require("entity.cast_entity")
  if data == nil then
    if self._cast == nil then
      self._cast = EntityMod.new(self, nil)
    end
    return self._cast
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:CastCredit():list() / client:CastCredit():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:CastCredit(data)
  local EntityMod = require("entity.cast_credit_entity")
  if data == nil then
    if self._cast_credit == nil then
      self._cast_credit = EntityMod.new(self, nil)
    end
    return self._cast_credit
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:CastMember():list() / client:CastMember():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:CastMember(data)
  local EntityMod = require("entity.cast_member_entity")
  if data == nil then
    if self._cast_member == nil then
      self._cast_member = EntityMod.new(self, nil)
    end
    return self._cast_member
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Crew():list() / client:Crew():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Crew(data)
  local EntityMod = require("entity.crew_entity")
  if data == nil then
    if self._crew == nil then
      self._crew = EntityMod.new(self, nil)
    end
    return self._crew
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:CrewCredit():list() / client:CrewCredit():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:CrewCredit(data)
  local EntityMod = require("entity.crew_credit_entity")
  if data == nil then
    if self._crew_credit == nil then
      self._crew_credit = EntityMod.new(self, nil)
    end
    return self._crew_credit
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:CrewMember():list() / client:CrewMember():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:CrewMember(data)
  local EntityMod = require("entity.crew_member_entity")
  if data == nil then
    if self._crew_member == nil then
      self._crew_member = EntityMod.new(self, nil)
    end
    return self._crew_member
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Episode():list() / client:Episode():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Episode(data)
  local EntityMod = require("entity.episode_entity")
  if data == nil then
    if self._episode == nil then
      self._episode = EntityMod.new(self, nil)
    end
    return self._episode
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:GuestCastCredit():list() / client:GuestCastCredit():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:GuestCastCredit(data)
  local EntityMod = require("entity.guest_cast_credit_entity")
  if data == nil then
    if self._guest_cast_credit == nil then
      self._guest_cast_credit = EntityMod.new(self, nil)
    end
    return self._guest_cast_credit
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Image():list() / client:Image():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Image(data)
  local EntityMod = require("entity.image_entity")
  if data == nil then
    if self._image == nil then
      self._image = EntityMod.new(self, nil)
    end
    return self._image
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Person():list() / client:Person():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Person(data)
  local EntityMod = require("entity.person_entity")
  if data == nil then
    if self._person == nil then
      self._person = EntityMod.new(self, nil)
    end
    return self._person
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Schedule():list() / client:Schedule():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Schedule(data)
  local EntityMod = require("entity.schedule_entity")
  if data == nil then
    if self._schedule == nil then
      self._schedule = EntityMod.new(self, nil)
    end
    return self._schedule
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ScheduledEpisode():list() / client:ScheduledEpisode():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:ScheduledEpisode(data)
  local EntityMod = require("entity.scheduled_episode_entity")
  if data == nil then
    if self._scheduled_episode == nil then
      self._scheduled_episode = EntityMod.new(self, nil)
    end
    return self._scheduled_episode
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Search():list() / client:Search():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Search(data)
  local EntityMod = require("entity.search_entity")
  if data == nil then
    if self._search == nil then
      self._search = EntityMod.new(self, nil)
    end
    return self._search
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Season():list() / client:Season():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Season(data)
  local EntityMod = require("entity.season_entity")
  if data == nil then
    if self._season == nil then
      self._season = EntityMod.new(self, nil)
    end
    return self._season
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Show():list() / client:Show():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Show(data)
  local EntityMod = require("entity.show_entity")
  if data == nil then
    if self._show == nil then
      self._show = EntityMod.new(self, nil)
    end
    return self._show
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Update():list() / client:Update():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function TvmazeSDK:Update(data)
  local EntityMod = require("entity.update_entity")
  if data == nil then
    if self._update == nil then
      self._update = EntityMod.new(self, nil)
    end
    return self._update
  end
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

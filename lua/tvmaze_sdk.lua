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



function TvmazeSDK:Aka(data)
  local EntityMod = require("entity.aka_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:AlternateList(data)
  local EntityMod = require("entity.alternate_list_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Cast(data)
  local EntityMod = require("entity.cast_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:CastCredit(data)
  local EntityMod = require("entity.cast_credit_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:CastMember(data)
  local EntityMod = require("entity.cast_member_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Crew(data)
  local EntityMod = require("entity.crew_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:CrewCredit(data)
  local EntityMod = require("entity.crew_credit_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:CrewMember(data)
  local EntityMod = require("entity.crew_member_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Episode(data)
  local EntityMod = require("entity.episode_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:GuestCastCredit(data)
  local EntityMod = require("entity.guest_cast_credit_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Image(data)
  local EntityMod = require("entity.image_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Person(data)
  local EntityMod = require("entity.person_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Schedule(data)
  local EntityMod = require("entity.schedule_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:ScheduledEpisode(data)
  local EntityMod = require("entity.scheduled_episode_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Search(data)
  local EntityMod = require("entity.search_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Season(data)
  local EntityMod = require("entity.season_entity")
  return EntityMod.new(self, data)
end


function TvmazeSDK:Show(data)
  local EntityMod = require("entity.show_entity")
  return EntityMod.new(self, data)
end


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

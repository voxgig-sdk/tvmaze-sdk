-- Tvmaze SDK error

local TvmazeError = {}
TvmazeError.__index = TvmazeError


function TvmazeError.new(code, msg, ctx)
  local self = setmetatable({}, TvmazeError)
  self.is_sdk_error = true
  self.sdk = "Tvmaze"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function TvmazeError:error()
  return self.msg
end


function TvmazeError:__tostring()
  return self.msg
end


return TvmazeError

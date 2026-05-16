package = "voxgig-sdk-tvmaze"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/tvmaze-sdk.git"
}
description = {
  summary = "Tvmaze SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["tvmaze_sdk"] = "tvmaze_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}

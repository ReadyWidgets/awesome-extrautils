---@diagnostic disable: undefined-global
---@class AwesomeExtrautils.capi
local capi = { mt = {} }

capi.awesome      = awesome
capi.client       = client
capi.keygrabber   = keygrabber
capi.mouse        = mouse
capi.mousegrabber = mousegrabber
capi.root         = root
capi.screen       = screen
capi.tag          = tag

return setmetatable(capi, capi.mt)

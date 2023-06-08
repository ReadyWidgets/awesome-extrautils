---@diagnostic disable: undefined-global
local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.capi : AwesomeExtrautils.table.Table
local capi = extrautils_table.create()

capi.awesome      = awesome
capi.client       = client
capi.keygrabber   = keygrabber
capi.mouse        = mouse
capi.mousegrabber = mousegrabber
capi.root         = root
capi.screen       = screen
capi.tag          = tag

return capi

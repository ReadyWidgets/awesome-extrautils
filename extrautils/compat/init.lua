---@class AwesomeExtrautils.compat
local compat = { mt = {} }

compat.unpack = unpack or table.unpack

return setmetatable(compat, compat.mt)

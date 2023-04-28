---@class AwesomeExtrautils
local extrautils = { mt = {} }

for _, module_name in ipairs({ "apps", "awesome", "capi", "compat", "math", "string", "table" }) do
	extrautils[module_name] = require("extrautils." .. module_name)
end

return setmetatable(extrautils, extrautils.mt)

---@meta lgi.GLib

---@class lgi.GLib
---@field Bytes lgi.GLib.Bytes
---@field KeyFile lgi.GLib.KeyFile
---@field MainLoop lgi.GLib.MainLoop
---@field Thread lgi.GLib.Thread
local GLib = {}

--- Run a callback after a set delay (in milliseconds)
---@param io_priority integer
---@param timeout_ms number
---@param callback function
function GLib.timeout_add(io_priority, timeout_ms, callback) end

return GLib

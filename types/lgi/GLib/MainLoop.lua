---@meta lgi.GLib.MainLoop

---@class lgi.GLib.MainLoop
local MainLoop = {}

---@param context? unknown
---@param is_running unknown
---@return lgi.GLib.MainLoop
function MainLoop.new(context, is_running) end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:get_context() end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:is_running() end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:quit() end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:ref() end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:run() end

---@param self lgi.GLib.MainLoop
---@return unknown
function MainLoop:unref() end

return MainLoop


---@meta lgi.GLib.Thread

---@class lgi.GLib.Thread
local Thread = {}

---@param name? unknown
---@param func unknown
---@param data? unknown
---@return lgi.GLib.Thread
function Thread.new(name, func, data) end

---@param name? unknown
---@param func unknown
---@param data? unknown
---@return lgi.GLib.Thread
function Thread.try_new(name, func, data) end

---@param self lgi.GLib.Thread
---@return unknown
function Thread:join() end

---@param self lgi.GLib.Thread
---@return unknown
function Thread:ref() end

---@param self lgi.GLib.Thread
---@return unknown
function Thread:unref() end

---@return unknown
function Thread.error_quark() end

---@param retval? unknown
---@return unknown
function Thread.exit(retval) end

---@return unknown
function Thread.self() end

---@return unknown
function Thread.yield() end

return Thread


---@meta lgi.Gio.Cancellable

---@class lgi.Gio.Cancellable : lgi.GObject.Object
local Cancellable = {}

---@return lgi.Gio.Cancellable
function Cancellable.new() end

---@return unknown
function Cancellable.get_current() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:cancel() end

---@param self lgi.Gio.Cancellable
---@param callback unknown
---@param data? unknown
---@param data_destroy_func? unknown
---@return unknown
function Cancellable:connect(callback, data, data_destroy_func) end

---@param self lgi.Gio.Cancellable
---@param handler_id unknown
---@return unknown
function Cancellable:disconnect(handler_id) end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:get_fd() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:is_cancelled() end

---@param self lgi.Gio.Cancellable
---@param pollfd unknown
---@return unknown
function Cancellable:make_pollfd(pollfd) end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:pop_current() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:push_current() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:release_fd() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:reset() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:set_error_if_cancelled() end

---@param self lgi.Gio.Cancellable
---@return unknown
function Cancellable:source_new() end

return Cancellable


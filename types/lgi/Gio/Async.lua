---@meta lgi.Gio.Async

---@class lgi.Gio.Async
local Async = {}

---@generic T1 : function
---@param user_function T1
---@param cancellable? lgi.Gio.Cancellable
---@param io_priority? integer
---@return T1
function Async.call(user_function, cancellable, io_priority) end

---@generic T1 : function
---@param user_function T1
---@param cancellable? lgi.Gio.Cancellable
---@param io_priority? integer
---@return T1
function Async.start(user_function, cancellable, io_priority) end

return Async

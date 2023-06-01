---@meta lgi.Gio.InputStream

---@class lgi.Gio.InputStream : lgi.GObject.Object
local InputStream = {}

---@param self lgi.Gio.InputStream
---@return unknown
function InputStream:clear_pending() end

---@param self lgi.Gio.InputStream
---@param cancellable? unknown
---@return unknown
function InputStream:close(cancellable) end

---@param self lgi.Gio.InputStream
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function InputStream:close_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.InputStream
---@param result unknown
---@return unknown
function InputStream:close_finish(result) end

---@param self lgi.Gio.InputStream
---@return unknown
function InputStream:has_pending() end

---@param self lgi.Gio.InputStream
---@return unknown
function InputStream:is_closed() end

---@param self lgi.Gio.InputStream
---@param buffer unknown
---@param count unknown
---@param cancellable? unknown
---@return unknown
function InputStream:read(buffer, count, cancellable) end

---@param self lgi.Gio.InputStream
---@param buffer unknown
---@param count unknown
---@param cancellable? unknown
---@return unknown
function InputStream:read_all(buffer, count, cancellable) end

---@param self lgi.Gio.InputStream
---@param buffer unknown
---@param count unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function InputStream:read_all_async(buffer, count, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.InputStream
---@param result unknown
---@return unknown
function InputStream:read_all_finish(result) end

---@param self lgi.Gio.InputStream
---@param buffer unknown
---@param count unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function InputStream:read_async(buffer, count, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.InputStream
---@param count unknown
---@param cancellable? unknown
---@return unknown
function InputStream:read_bytes(count, cancellable) end

---@param self lgi.Gio.InputStream
---@param count unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function InputStream:read_bytes_async(count, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.InputStream
---@param result unknown
---@return unknown
function InputStream:read_bytes_finish(result) end

---@param self lgi.Gio.InputStream
---@param result unknown
---@return unknown
function InputStream:read_finish(result) end

---@param self lgi.Gio.InputStream
---@return unknown
function InputStream:set_pending() end

---@param self lgi.Gio.InputStream
---@param count unknown
---@param cancellable? unknown
---@return unknown
function InputStream:skip(count, cancellable) end

---@param self lgi.Gio.InputStream
---@param count unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function InputStream:skip_async(count, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.InputStream
---@param result unknown
---@return unknown
function InputStream:skip_finish(result) end

return InputStream


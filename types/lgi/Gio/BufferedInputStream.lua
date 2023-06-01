---@meta lgi.Gio.BufferedInputStream

---@class lgi.Gio.BufferedInputStream : lgi.Gio.FilterInputStream, lgi.Gio.Seekable
local BufferedInputStream = {}

---@param base_stream unknown
---@return lgi.Gio.BufferedInputStream
function BufferedInputStream.new(base_stream) end

---@param base_stream unknown
---@param size unknown
---@return lgi.Gio.BufferedInputStream
function BufferedInputStream.new_sized(base_stream, size) end

---@param self lgi.Gio.BufferedInputStream
---@param count unknown
---@param cancellable? unknown
---@return unknown
function BufferedInputStream:fill(count, cancellable) end

---@param self lgi.Gio.BufferedInputStream
---@param count unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function BufferedInputStream:fill_async(count, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.BufferedInputStream
---@param result unknown
---@return unknown
function BufferedInputStream:fill_finish(result) end

---@param self lgi.Gio.BufferedInputStream
---@return unknown
function BufferedInputStream:get_available() end

---@param self lgi.Gio.BufferedInputStream
---@return unknown
function BufferedInputStream:get_buffer_size() end

---@param self lgi.Gio.BufferedInputStream
---@param buffer unknown
---@param offset unknown
---@param count unknown
---@return unknown
function BufferedInputStream:peek(buffer, offset, count) end

---@param self lgi.Gio.BufferedInputStream
---@return unknown
function BufferedInputStream:peek_buffer() end

---@param self lgi.Gio.BufferedInputStream
---@param cancellable? unknown
---@return unknown
function BufferedInputStream:read_byte(cancellable) end

---@param self lgi.Gio.BufferedInputStream
---@param size unknown
---@return unknown
function BufferedInputStream:set_buffer_size(size) end

return BufferedInputStream


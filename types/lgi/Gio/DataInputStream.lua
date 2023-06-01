---@meta lgi.Gio.DataInputStream

---@class lgi.Gio.DataInputStream : lgi.Gio.BufferedInputStream, lgi.Gio.Seekable
local DataInputStream = {}

---@param base_stream unknown
---@return lgi.Gio.DataInputStream
function DataInputStream.new(base_stream) end

---@param self lgi.Gio.DataInputStream
---@return unknown
function DataInputStream:get_byte_order() end

---@param self lgi.Gio.DataInputStream
---@return unknown
function DataInputStream:get_newline_type() end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_byte(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_int16(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_int32(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_int64(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_line(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function DataInputStream:read_line_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.DataInputStream
---@param result unknown
---@return unknown
function DataInputStream:read_line_finish(result) end

---@param self lgi.Gio.DataInputStream
---@param result unknown
---@return unknown
function DataInputStream:read_line_finish_utf8(result) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_line_utf8(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_uint16(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_uint32(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_uint64(cancellable) end

---@param self lgi.Gio.DataInputStream
---@param stop_chars unknown
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_until(stop_chars, cancellable) end

---@param self lgi.Gio.DataInputStream
---@param stop_chars unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function DataInputStream:read_until_async(stop_chars, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.DataInputStream
---@param result unknown
---@return unknown
function DataInputStream:read_until_finish(result) end

---@param self lgi.Gio.DataInputStream
---@param stop_chars unknown
---@param stop_chars_len unknown
---@param cancellable? unknown
---@return unknown
function DataInputStream:read_upto(stop_chars, stop_chars_len, cancellable) end

---@param self lgi.Gio.DataInputStream
---@param stop_chars unknown
---@param stop_chars_len unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function DataInputStream:read_upto_async(stop_chars, stop_chars_len, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.DataInputStream
---@param result unknown
---@return unknown
function DataInputStream:read_upto_finish(result) end

---@param self lgi.Gio.DataInputStream
---@param order unknown
---@return unknown
function DataInputStream:set_byte_order(order) end

---@param self lgi.Gio.DataInputStream
---@param type unknown
---@return unknown
function DataInputStream:set_newline_type(type) end

return DataInputStream


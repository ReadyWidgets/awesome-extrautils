---@meta lgi.Gio.FilterInputStream

---@class lgi.Gio.FilterInputStream : lgi.Gio.InputStream
local FilterInputStream = {}

---@param self lgi.Gio.FilterInputStream
---@return unknown
function FilterInputStream:get_base_stream() end

---@param self lgi.Gio.FilterInputStream
---@return unknown
function FilterInputStream:get_close_base_stream() end

---@param self lgi.Gio.FilterInputStream
---@param close_base unknown
---@return unknown
function FilterInputStream:set_close_base_stream(close_base) end

return FilterInputStream


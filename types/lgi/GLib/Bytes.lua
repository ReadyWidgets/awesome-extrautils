---@meta lgi.GLib.Bytes

---@class lgi.GLib.Bytes
local Bytes = {}

---@param data? unknown
---@param size unknown
---@return lgi.GLib.Bytes
function Bytes.new(data, size) end

---@param data? unknown
---@param size unknown
---@return lgi.GLib.Bytes
function Bytes.new_take(data, size) end

---@param self lgi.GLib.Bytes
---@param bytes2 unknown
---@return unknown
function Bytes:compare(bytes2) end

---@param self lgi.GLib.Bytes
---@param bytes2 unknown
---@return unknown
function Bytes:equal(bytes2) end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:get_data() end

---@param self lgi.GLib.Bytes
---@param element_size unknown
---@param offset unknown
---@param n_elements unknown
---@return unknown
function Bytes:get_region(element_size, offset, n_elements) end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:get_size() end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:hash() end

---@param self lgi.GLib.Bytes
---@param offset unknown
---@param length unknown
---@return unknown
function Bytes:new_from_bytes(offset, length) end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:ref() end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:unref() end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:unref_to_array() end

---@param self lgi.GLib.Bytes
---@return unknown
function Bytes:unref_to_data() end

return Bytes


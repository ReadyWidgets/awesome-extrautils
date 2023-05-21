---@meta lgi.Gio.Icon

---@class lgi.Gio.Icon
local Icon = {}

---@param value unknown
---@return unknown
function Icon.deserialize(value) end

---@param str unknown
---@return unknown
function Icon.new_for_string(str) end

---@param self lgi.Gio.Icon
---@param icon2? unknown
---@return unknown
function Icon:equal(icon2) end

---@param self lgi.Gio.Icon
---@return unknown
function Icon:hash() end

---@param self lgi.Gio.Icon
---@return unknown
function Icon:serialize() end

---@param self lgi.Gio.Icon
---@return unknown
function Icon:to_string() end

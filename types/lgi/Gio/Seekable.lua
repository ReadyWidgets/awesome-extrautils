---@meta lgi.Gio.Seekable

---@class lgi.Gio.Seekable
local Seekable = {}

---@param self lgi.Gio.Seekable
---@return unknown
function Seekable:can_seek() end

---@param self lgi.Gio.Seekable
---@return unknown
function Seekable:can_truncate() end

---@param self lgi.Gio.Seekable
---@param offset unknown
---@param type unknown
---@param cancellable? unknown
---@return unknown
function Seekable:seek(offset, type, cancellable) end

---@param self lgi.Gio.Seekable
---@return unknown
function Seekable:tell() end

---@param self lgi.Gio.Seekable
---@param offset unknown
---@param cancellable? unknown
---@return unknown
function Seekable:truncate(offset, cancellable) end

return Seekable


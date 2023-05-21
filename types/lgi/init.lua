---@meta lgi

---@class lgi
---@field Gio lgi.Gio
---@field GLib lgi.GLib
---@field GObject lgi.GObject
---@field Gtk lgi.Gtk
local lgi = {}

--- Require a specific version of a gi module
---@param module string A module, like `"Gtk"`
---@param version string A version, like `"3.0"`
---@return unknown
function lgi.require(module, version) end

return lgi

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.apps : AwesomeExtrautils.Table
local apps = extrautils_table.create()

local lgi, Gio, Gtk
do
	local success, result = pcall(function()
		lgi = require("lgi") ---@type lgi
		Gio = lgi.Gio ---@type lgi.Gio
		Gtk = lgi.require("Gtk", "3.0") ---@type lgi.Gtk
	end)

	if not success then
		return apps
	end
end

local function generic_lookup_icon(callback)
	local icon_theme = Gtk.IconTheme.get_default()

	if not icon_theme then
		return
	end

	local icon = callback(icon_theme)

	if not icon then
		return
	end

	return icon:get_filename()
end

--- Lookup an icon by name in the default Gtk icon theme.
---
--- The names have to be in 'plain' format, i.e. "firefox" to get the icon for
--- everyone's favorite web browser.
---
--- ---
---
---@param icon_name string
---@return string? path The full path to the icon, or `nil` if not found
function apps.lookup_icon(icon_name)
	return generic_lookup_icon(function(icon_theme)
		return icon_theme:lookup_icon(icon_name, 48, 0)
	end)
end

--- Lookup an icon by a `Gio.Icon` object in the default Gtk icon theme.
---
--- ---
---
---@param gicon lgi.Gio.Icon
---@return string? path The full path to the icon, or `nil` if not found
function apps.lookup_gicon(gicon)
	return generic_lookup_icon(function(icon_theme)
		return icon_theme:lookup_by_gicon(gicon, 48, 0)
	end)
end

function apps.get_app_categories()
	return {
		"AudioVideo",
		"Development",
		"Education",
		"Game",
		"Graphics",
		"Network",
		"Office",
		"Science",
		"Settings",
		"System",
		"Utility",
		"Other",
	}
end

---@param gappinfo lgi.Gio.DesktopAppInfo
function apps.get_data_from_gappinfo(gappinfo)
	assert(gappinfo, "")

	return {
		name = gappinfo:get_name(),
		description = gappinfo:get_description(),
		launch = function()
			return gappinfo:launch()
		end,
		icon = apps.lookup_gicon(gappinfo:get_icon()),
		gappinfo = gappinfo,
	}
end

return apps

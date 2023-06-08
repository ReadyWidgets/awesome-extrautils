local extrautils_table = require("extrautils.table")
local class = require("extrautils.class")

---@class AwesomeExtrautils.apps : AwesomeExtrautils.table.Table
local apps = extrautils_table.create()

local lgi ---@type lgi
local Gio ---@type lgi.Gio
local GLib ---@type lgi.GLib
local Gtk ---@type lgi.Gtk
do
	local success, result = pcall(function()
		lgi = require("lgi")
		Gio = lgi.Gio
		GLib = lgi.GLib
		Gtk = lgi.require("Gtk", "3.0")
	end)

	if not success then
		return apps
	end
end

---@diagnostic disable-next-line: undefined-doc-name
---@type fun(surface_convertable): gears.surface
local gsurface
do
	local success, result = pcall(function()
		gsurface = require("gears").surface
	end)

	if not success then
		gsurface = function(surface)
			return surface
		end
	end
end

local icon_theme_cached
local function generic_lookup_icon(callback)
	icon_theme_cached = icon_theme_cached or Gtk.IconTheme.get_default()

	if not icon_theme_cached then
		return
	end

	local icon = callback(icon_theme_cached)

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

apps.all_categories = {
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

apps.pretty_category_names = {
	AudioVideo  = "Multimedia",
	Development = "Development",
	Education   = "Education",
	Game        = "Games",
	Graphics    = "Graphics",
	Network     = "Internet",
	Office      = "Office",
	Science     = "Science",
	Settings    = "Settings",
	System      = "System",
	Utility     = "Utilities",
	Other       = "Other",
}

local function smart_tostring(obj)
	local type_tb = type(obj)

	if type_tb == "string" then
		return '"' .. obj .. '"'
	elseif type_tb == "table" then
		local mt = getmetatable(obj)

		if mt and rawget(mt, "__tostring") then
			return tostring(obj)
		end

		if next(obj) == nil then
			return "{}"
		end

		local out = "{"

		local first = true
		for _, v in pairs(obj) do
			if first then
				first = false
				out = out ..  " " .. smart_tostring(v)
			else
				out = out .. ", " .. smart_tostring(v)
			end
		end

		return out .. " }"
	end

	return tostring(obj)
end

---@alias AwesomeExtrautils.apps.AppData.args {name: string, description: string, categories: string[], launch: fun(), icon: (string|nil), show: boolean, filename: string, gappinfo: lgi.Gio.DesktopAppInfo}

---@class AwesomeExtrautils.apps.AppData : AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.apps.AppData.__class
---@field from_gappinfo fun(cls: AwesomeExtrautils.apps.AppData.__class, gappinfo: lgi.Gio.DesktopAppInfo): AwesomeExtrautils.apps.AppData
---@field from_desktop_id fun(cls: AwesomeExtrautils.apps.AppData.__class, desktop_id: string): AwesomeExtrautils.apps.AppData
---@field name string
---@field description string
---@field categories string[]
---@field launch fun()
---@field icon string|nil
---@field show boolean
---@field filename string
---@field gappinfo lgi.Gio.DesktopAppInfo

---@class AwesomeExtrautils.apps.AppData.__class : AwesomeExtrautils.class.Class
---@operator call(AwesomeExtrautils.apps.AppData.args): AwesomeExtrautils.apps.AppData
---@field __init fun(args: AwesomeExtrautils.apps.AppData.args): AwesomeExtrautils.apps.AppData
---@field from_gappinfo fun(cls: AwesomeExtrautils.apps.AppData.__class, gappinfo: lgi.Gio.DesktopAppInfo): AwesomeExtrautils.apps.AppData
---@field from_desktop_id fun(cls: AwesomeExtrautils.apps.AppData.__class, desktop_id: string): AwesomeExtrautils.apps.AppData
apps.AppData = class.create("extrautils.apps.AppData", {
	---@param self AwesomeExtrautils.apps.AppData
	---@param args AwesomeExtrautils.apps.AppData.args
	__init = function(self, args)
		args = args or {}
		for k, v in pairs(args) do
			self[k] = v
		end
	end,

	__tostring = function(self)
		local out = self.__class.__name .. " {\n"

		local longest_key_length = 0

		for k, _ in pairs(self) do
			local k_len = #tostring(k)
			if k_len > longest_key_length then
				longest_key_length = k_len
			end
		end

		for k, v in pairs(self) do
			local k_str = tostring(k)
			out = out .. "    " .. k_str .. (" "):rep(longest_key_length - #k_str) .. " = " .. smart_tostring(v) .. ",\n"
		end

		return out .. "}"
	end,

	---@param cls AwesomeExtrautils.apps.AppData.__class
	---@param gappinfo lgi.Gio.DesktopAppInfo
	from_gappinfo = function(cls, gappinfo)
		local gicon = gappinfo:get_icon()

		local self = cls {
			name = gappinfo:get_name(),
			description = gappinfo:get_description(),
			categories = gappinfo:get_string_list("Categories"),
			launch = function() return gappinfo:launch() end,
			icon = (gicon) and (apps.lookup_gicon(gicon)),
			show = (not gappinfo:get_boolean("NoDisplay")) and (gappinfo:get_show_in()), ---@type boolean
			filename = gappinfo:get_filename(),
			desktop_id = gappinfo:get_filename():match("^.*/(.*%.desktop)$"),
			gappinfo = gappinfo,
		}

		return self
	end,

	from_desktop_id = function(cls, desktop_id)
		return cls:from_gappinfo(Gio.DesktopAppInfo.new(desktop_id))
	end,
})

local AppData = apps.AppData

function apps.parse_action(gappinfo)
	if not gappinfo then
		return
	end

	local file = gappinfo:get_filename()
	local keyfile = GLib.KeyFile()

	if not keyfile:load_from_file(file, {}) then
		return {}
	end

	local actions = {}

	for _, action in ipairs(gappinfo:list_actions()) do
		local action_entry = "Desktop Action " .. action
		local action_icon = keyfile:get_string(action_entry, "Icon")
		local icon

		if action_icon then
			icon = gsurface(action_icon)
		end

		actions[action] = {
			name = gappinfo:get_action_name(action),
			icon = icon,
			launch = function()
				return gappinfo:launch_action(action)
			end
		}
	end

	return actions
end

---@type AwesomeExtrautils.apps.AppData[]
local all_apps_cached
---@param unached? boolean
---@return AwesomeExtrautils.apps.AppData[]
function apps.get_all(unached)
	if (not unached) and all_apps_cached then
		return all_apps_cached
	end

	all_apps_cached = {}

	for _, gappinfo in ipairs(Gio.DesktopAppInfo.get_all()) do
		all_apps_cached[#all_apps_cached+1] = AppData:from_gappinfo(gappinfo)
	end

	return all_apps_cached
end

---@alias AwesomeExtrautils.apps.categorized_apps {Multimedia: (nil|AwesomeExtrautils.apps.AppData[]), Development: (nil|AwesomeExtrautils.apps.AppData[]), Education: (nil|AwesomeExtrautils.apps.AppData[]), Games: (nil|AwesomeExtrautils.apps.AppData[]), Graphics: (nil|AwesomeExtrautils.apps.AppData[]), Internet: (nil|AwesomeExtrautils.apps.AppData[]), Office: (nil|AwesomeExtrautils.apps.AppData[]), Science: (nil|AwesomeExtrautils.apps.AppData[]), Settings: (nil|AwesomeExtrautils.apps.AppData[]), System: (nil|AwesomeExtrautils.apps.AppData[]), Utilities: (nil|AwesomeExtrautils.apps.AppData[]), Other: (nil|AwesomeExtrautils.apps.AppData[])}

--- Get a table of apps, sorted into categories
---
--- ---
--- 
--- Example:
---
--- ```
--- for name, category in pairs(apps.get_all_categorized()) do
--- 	print(name)
--- 	for _, app in ipairs(category) do
--- 		print(" * " .. app.name)
--- 	end
--- end
--- ```
---
--- ---
---
---@param app_list? AwesomeExtrautils.apps.AppData[]
---@return AwesomeExtrautils.apps.categorized_apps
function apps.get_all_categorized(app_list)
	app_list = app_list or apps.get_all()
	---@type AwesomeExtrautils.apps.categorized_apps
	local categorized_apps = {}

	for _, app in ipairs(app_list) do
		if not app.show then
			goto app_was_categorized
		end

		for _, app_category in ipairs(app.categories) do
			for _, known_category in ipairs(apps.all_categories) do
				if app_category == known_category then
					local fixed_category = apps.pretty_category_names[known_category]

					if categorized_apps[fixed_category] == nil then
						categorized_apps[fixed_category] = {}
					end

					categorized_apps[fixed_category][#categorized_apps[fixed_category] + 1] = app

					goto app_was_categorized
				end
			end
		end

		if categorized_apps.Other == nil then
			categorized_apps.Other = {}
		end

		categorized_apps.Other[#categorized_apps.Other + 1] = app

		::app_was_categorized::
	end

	for _, category in pairs(categorized_apps) do
		table.sort(category, function(a, b)
			return a.name:lower() < b.name:lower()
		end)
	end

	return categorized_apps
end

local function has_schema(schema)
	for _, s in ipairs(Gio.Settings.list_schemas() --[[@as (string[])]]) do
		if s == schema then
			return true
		end
	end

	return false
end

---@return AwesomeExtrautils.apps.AppData[]
function apps.get_gnome_favorites()
	local shell_schema = "org.gnome.shell"
	local favorites = {}

	if not has_schema(shell_schema) then
		return {}
	end

	for _, desktop_id in ipairs(Gio.Settings({ schema = shell_schema }):get_strv("favorite-apps") --[[@as (string[])]]) do
		favorites[#favorites+1] = AppData:from_desktop_id(desktop_id)
	end

	return favorites
end

function apps.set_gnome_favorites(favorites)
	do
		local type_favorites = type(favorites)
		assert(type_favorites == "table", "ERROR: Wrong parameter #1 to function apps.set_gnome_favorites (expected table, got: " .. type_favorites .. ")")
	end

	local shell_schema = "org.gnome.shell"

	if not has_schema(shell_schema) then
		return
	end

	Gio.Settings({ schema = shell_schema }):set_strv("favorite-apps", favorites)
end

return apps

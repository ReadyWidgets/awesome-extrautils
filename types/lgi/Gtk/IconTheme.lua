---@meta lgi.Gtk.IconTheme

---@class lgi.Gtk.IconTheme : lgi.GObject.Object
local IconTheme = {}

---@return lgi.Gtk.IconTheme
function IconTheme.new() end

---@param icon_name unknown
---@param size unknown
---@param pixbuf unknown
---@return unknown
function IconTheme.add_builtin_icon(icon_name, size, pixbuf) end

---@return unknown
function IconTheme.get_default() end

---@param screen unknown
---@return unknown
function IconTheme.get_for_screen(screen) end

---@param self lgi.Gtk.IconTheme
---@param path unknown
---@return unknown
function IconTheme:add_resource_path(path) end

---@param self lgi.Gtk.IconTheme
---@param path unknown
---@return unknown
function IconTheme:append_search_path(path) end

---@param self lgi.Gtk.IconTheme
---@param icon_names unknown
---@param size unknown
---@param flags unknown
---@return unknown
function IconTheme:choose_icon(icon_names, size, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon_names unknown
---@param size unknown
---@param scale unknown
---@param flags unknown
---@return unknown
function IconTheme:choose_icon_for_scale(icon_names, size, scale, flags) end

---@param self lgi.Gtk.IconTheme
---@return unknown
function IconTheme:get_example_icon_name() end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@return unknown
function IconTheme:get_icon_sizes(icon_name) end

---@param self lgi.Gtk.IconTheme
---@return unknown
function IconTheme:get_search_path() end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@return unknown
function IconTheme:has_icon(icon_name) end

---@param self lgi.Gtk.IconTheme
---@return unknown
function IconTheme:list_contexts() end

---@param self lgi.Gtk.IconTheme
---@param context? unknown
---@return unknown
function IconTheme:list_icons(context) end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@param size unknown
---@param flags unknown
---@return unknown
function IconTheme:load_icon(icon_name, size, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@param size unknown
---@param scale unknown
---@param flags unknown
---@return unknown
function IconTheme:load_icon_for_scale(icon_name, size, scale, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@param size unknown
---@param scale unknown
---@param for_window? unknown
---@param flags unknown
---@return unknown
function IconTheme:load_surface(icon_name, size, scale, for_window, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon unknown
---@param size unknown
---@param flags unknown
---@return unknown
function IconTheme:lookup_by_gicon(icon, size, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon unknown
---@param size unknown
---@param scale unknown
---@param flags unknown
---@return unknown
function IconTheme:lookup_by_gicon_for_scale(icon, size, scale, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@param size unknown
---@param flags unknown
---@return unknown
function IconTheme:lookup_icon(icon_name, size, flags) end

---@param self lgi.Gtk.IconTheme
---@param icon_name unknown
---@param size unknown
---@param scale unknown
---@param flags unknown
---@return unknown
function IconTheme:lookup_icon_for_scale(icon_name, size, scale, flags) end

---@param self lgi.Gtk.IconTheme
---@param path unknown
---@return unknown
function IconTheme:prepend_search_path(path) end

---@param self lgi.Gtk.IconTheme
---@return unknown
function IconTheme:rescan_if_needed() end

---@param self lgi.Gtk.IconTheme
---@param theme_name? unknown
---@return unknown
function IconTheme:set_custom_theme(theme_name) end

---@param self lgi.Gtk.IconTheme
---@param screen unknown
---@return unknown
function IconTheme:set_screen(screen) end

---@param self lgi.Gtk.IconTheme
---@param path unknown
---@param n_elements unknown
---@return unknown
function IconTheme:set_search_path(path, n_elements) end

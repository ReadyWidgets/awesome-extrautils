---@meta lgi.Gio.DesktopAppInfo

---@class lgi.Gio.DesktopAppInfo : lgi.GObject.Object, lgi.Gio.AppInfo
local DesktopAppInfo = {}

---@param desktop_id unknown
---@return lgi.Gio.DesktopAppInfo
function DesktopAppInfo.new(desktop_id) end

---@param filename unknown
---@return lgi.Gio.DesktopAppInfo
function DesktopAppInfo.new_from_filename(filename) end

---@param key_file unknown
---@return lgi.Gio.DesktopAppInfo
function DesktopAppInfo.new_from_keyfile(key_file) end

---@param interface unknown
---@return unknown
function DesktopAppInfo.get_implementations(interface) end

---@param search_string unknown
---@return unknown
function DesktopAppInfo.search(search_string) end

---@param desktop_env unknown
---@return unknown
function DesktopAppInfo.set_desktop_env(desktop_env) end

---@param self lgi.Gio.DesktopAppInfo
---@param action_name unknown
---@return unknown
function DesktopAppInfo:get_action_name(action_name) end

---@param self lgi.Gio.DesktopAppInfo
---@param key unknown
---@return unknown
function DesktopAppInfo:get_boolean(key) end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_categories() end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_filename() end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_generic_name() end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_is_hidden() end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_keywords() end

---@param self lgi.Gio.DesktopAppInfo
---@param key unknown
---@return unknown
function DesktopAppInfo:get_locale_string(key) end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_nodisplay() end

---@param self lgi.Gio.DesktopAppInfo
---@param desktop_env? unknown
---@return unknown
function DesktopAppInfo:get_show_in(desktop_env) end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:get_startup_wm_class() end

---@param self lgi.Gio.DesktopAppInfo
---@param key unknown
---@return unknown
function DesktopAppInfo:get_string(key) end

---@param self lgi.Gio.DesktopAppInfo
---@param key unknown
---@return unknown
function DesktopAppInfo:get_string_list(key) end

---@param self lgi.Gio.DesktopAppInfo
---@param key unknown
---@return unknown
function DesktopAppInfo:has_key(key) end

---@param self lgi.Gio.DesktopAppInfo
---@param action_name unknown
---@param launch_context? unknown
---@return unknown
function DesktopAppInfo:launch_action(action_name, launch_context) end

---@param self lgi.Gio.DesktopAppInfo
---@param uris unknown
---@param launch_context? unknown
---@param spawn_flags unknown
---@param user_setup? unknown
---@param user_setup_data? unknown
---@param pid_callback? unknown
---@param pid_callback_data? unknown
---@return unknown
function DesktopAppInfo:launch_uris_as_manager(uris, launch_context, spawn_flags, user_setup, user_setup_data, pid_callback, pid_callback_data) end

---@param self lgi.Gio.DesktopAppInfo
---@param uris unknown
---@param launch_context? unknown
---@param spawn_flags unknown
---@param user_setup? unknown
---@param user_setup_data? unknown
---@param pid_callback? unknown
---@param pid_callback_data? unknown
---@param stdin_fd unknown
---@param stdout_fd unknown
---@param stderr_fd unknown
---@return unknown
function DesktopAppInfo:launch_uris_as_manager_with_fds(uris, launch_context, spawn_flags, user_setup, user_setup_data, pid_callback, pid_callback_data, stdin_fd, stdout_fd, stderr_fd) end

---@param self lgi.Gio.DesktopAppInfo
---@return unknown
function DesktopAppInfo:list_actions() end

return DesktopAppInfo

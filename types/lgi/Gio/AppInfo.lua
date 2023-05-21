---@meta lgi.Gio.AppInfo

---@class lgi.Gio.AppInfo
local AppInfo = {}

---@param commandline unknown
---@param application_name? unknown
---@param flags unknown
---@return unknown
function AppInfo.create_from_commandline(commandline, application_name, flags) end

---@return unknown
function AppInfo.get_all() end

---@param content_type unknown
---@return unknown
function AppInfo.get_all_for_type(content_type) end

---@param content_type unknown
---@param must_support_uris unknown
---@return unknown
function AppInfo.get_default_for_type(content_type, must_support_uris) end

---@param content_type unknown
---@param must_support_uris unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function AppInfo.get_default_for_type_async(content_type, must_support_uris, cancellable, callback, user_data) end

---@param result unknown
---@return unknown
function AppInfo.get_default_for_type_finish(result) end

---@param uri_scheme unknown
---@return unknown
function AppInfo.get_default_for_uri_scheme(uri_scheme) end

---@param uri_scheme unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function AppInfo.get_default_for_uri_scheme_async(uri_scheme, cancellable, callback, user_data) end

---@param result unknown
---@return unknown
function AppInfo.get_default_for_uri_scheme_finish(result) end

---@param content_type unknown
---@return unknown
function AppInfo.get_fallback_for_type(content_type) end

---@param content_type unknown
---@return unknown
function AppInfo.get_recommended_for_type(content_type) end

---@param uri unknown
---@param context? unknown
---@return unknown
function AppInfo.launch_default_for_uri(uri, context) end

---@param uri unknown
---@param context? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function AppInfo.launch_default_for_uri_async(uri, context, cancellable, callback, user_data) end

---@param result unknown
---@return unknown
function AppInfo.launch_default_for_uri_finish(result) end

---@param content_type unknown
---@return unknown
function AppInfo.reset_type_associations(content_type) end

---@param self lgi.Gio.AppInfo
---@param content_type unknown
---@return unknown
function AppInfo:add_supports_type(content_type) end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:can_delete() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:can_remove_supports_type() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:delete() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:dup() end

---@param self lgi.Gio.AppInfo
---@param appinfo2 unknown
---@return unknown
function AppInfo:equal(appinfo2) end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_commandline() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_description() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_display_name() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_executable() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_icon() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_id() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_name() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:get_supported_types() end

---@param self lgi.Gio.AppInfo
---@param files? unknown
---@param context? unknown
---@return unknown
function AppInfo:launch(files, context) end

---@param self lgi.Gio.AppInfo
---@param uris? unknown
---@param context? unknown
---@return unknown
function AppInfo:launch_uris(uris, context) end

---@param self lgi.Gio.AppInfo
---@param uris? unknown
---@param context? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function AppInfo:launch_uris_async(uris, context, cancellable, callback, user_data) end

---@param self lgi.Gio.AppInfo
---@param result unknown
---@return unknown
function AppInfo:launch_uris_finish(result) end

---@param self lgi.Gio.AppInfo
---@param content_type unknown
---@return unknown
function AppInfo:remove_supports_type(content_type) end

---@param self lgi.Gio.AppInfo
---@param extension unknown
---@return unknown
function AppInfo:set_as_default_for_extension(extension) end

---@param self lgi.Gio.AppInfo
---@param content_type unknown
---@return unknown
function AppInfo:set_as_default_for_type(content_type) end

---@param self lgi.Gio.AppInfo
---@param content_type unknown
---@return unknown
function AppInfo:set_as_last_used_for_type(content_type) end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:should_show() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:supports_files() end

---@param self lgi.Gio.AppInfo
---@return unknown
function AppInfo:supports_uris() end

return AppInfo

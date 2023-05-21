---@meta lgi.GLib.KeyFile

---@class lgi.GLib.KeyFile
local KeyFile = {}

---@return lgi.GLib.KeyFile
function KeyFile.new() end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_boolean(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_boolean_list(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name? unknown
---@param key? unknown
---@return unknown
function KeyFile:get_comment(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_double(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_double_list(group_name, key) end

---@param self lgi.GLib.KeyFile
---@return unknown
function KeyFile:get_groups() end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_int64(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_integer(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_integer_list(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@return unknown
function KeyFile:get_keys(group_name) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param locale? unknown
---@return unknown
function KeyFile:get_locale_for_key(group_name, key, locale) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param locale? unknown
---@return unknown
function KeyFile:get_locale_string(group_name, key, locale) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param locale? unknown
---@return unknown
function KeyFile:get_locale_string_list(group_name, key, locale) end

---@param self lgi.GLib.KeyFile
---@return unknown
function KeyFile:get_start_group() end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_string(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_string_list(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_uint64(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:get_value(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@return unknown
function KeyFile:has_group(group_name) end

---@param self lgi.GLib.KeyFile
---@param bytes unknown
---@param flags unknown
---@return unknown
function KeyFile:load_from_bytes(bytes, flags) end

---@param self lgi.GLib.KeyFile
---@param data unknown
---@param length unknown
---@param flags unknown
---@return unknown
function KeyFile:load_from_data(data, length, flags) end

---@param self lgi.GLib.KeyFile
---@param file unknown
---@param flags unknown
---@return unknown
function KeyFile:load_from_data_dirs(file, flags) end

---@param self lgi.GLib.KeyFile
---@param file unknown
---@param search_dirs unknown
---@param flags unknown
---@return unknown
function KeyFile:load_from_dirs(file, search_dirs, flags) end

---@param self lgi.GLib.KeyFile
---@param file unknown
---@param flags unknown
---@return unknown
function KeyFile:load_from_file(file, flags) end

---@param self lgi.GLib.KeyFile
---@param group_name? unknown
---@param key? unknown
---@return unknown
function KeyFile:remove_comment(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@return unknown
function KeyFile:remove_group(group_name) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@return unknown
function KeyFile:remove_key(group_name, key) end

---@param self lgi.GLib.KeyFile
---@param filename unknown
---@return unknown
function KeyFile:save_to_file(filename) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_boolean(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param list unknown
---@param length unknown
---@return unknown
function KeyFile:set_boolean_list(group_name, key, list, length) end

---@param self lgi.GLib.KeyFile
---@param group_name? unknown
---@param key? unknown
---@param comment unknown
---@return unknown
function KeyFile:set_comment(group_name, key, comment) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_double(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param list unknown
---@param length unknown
---@return unknown
function KeyFile:set_double_list(group_name, key, list, length) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_int64(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_integer(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param list unknown
---@param length unknown
---@return unknown
function KeyFile:set_integer_list(group_name, key, list, length) end

---@param self lgi.GLib.KeyFile
---@param separator unknown
---@return unknown
function KeyFile:set_list_separator(separator) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param locale unknown
---@param string unknown
---@return unknown
function KeyFile:set_locale_string(group_name, key, locale, string) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param locale unknown
---@param list unknown
---@param length unknown
---@return unknown
function KeyFile:set_locale_string_list(group_name, key, locale, list, length) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param string unknown
---@return unknown
function KeyFile:set_string(group_name, key, string) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param list unknown
---@param length unknown
---@return unknown
function KeyFile:set_string_list(group_name, key, list, length) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_uint64(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@param group_name unknown
---@param key unknown
---@param value unknown
---@return unknown
function KeyFile:set_value(group_name, key, value) end

---@param self lgi.GLib.KeyFile
---@return unknown
function KeyFile:to_data() end

---@param self lgi.GLib.KeyFile
---@return unknown
function KeyFile:unref() end

---@return unknown
function KeyFile.error_quark() end

return KeyFile

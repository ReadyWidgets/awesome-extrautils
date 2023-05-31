---@meta lgi.Gio.Settings

---@class lgi.Gio.Settings : lgi.GObject.Object
local Settings = {}

---@param schema_id unknown
---@return lgi.Gio.Settings
function Settings.new(schema_id) end

---@param schema unknown
---@param backend? unknown
---@param path? unknown
---@return lgi.Gio.Settings
function Settings.new_full(schema, backend, path) end

---@param schema_id unknown
---@param backend unknown
---@return lgi.Gio.Settings
function Settings.new_with_backend(schema_id, backend) end

---@param schema_id unknown
---@param backend unknown
---@param path unknown
---@return lgi.Gio.Settings
function Settings.new_with_backend_and_path(schema_id, backend, path) end

---@param schema_id unknown
---@param path unknown
---@return lgi.Gio.Settings
function Settings.new_with_path(schema_id, path) end

---@return unknown
function Settings.list_relocatable_schemas() end

---@return unknown
function Settings.list_schemas() end

---@return unknown
function Settings.sync() end

---@param object unknown
---@param property unknown
---@return unknown
function Settings.unbind(object, property) end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:apply() end

---@param self lgi.Gio.Settings
---@param key unknown
---@param object unknown
---@param property unknown
---@param flags unknown
---@return unknown
function Settings:bind(key, object, property, flags) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param object unknown
---@param property unknown
---@param inverted unknown
---@return unknown
function Settings:bind_writable(key, object, property, inverted) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:create_action(key) end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:delay() end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_boolean(key) end

---@param self lgi.Gio.Settings
---@param name unknown
---@return unknown
function Settings:get_child(name) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_default_value(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_double(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_enum(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_flags(key) end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:get_has_unapplied() end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_int(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_int64(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param mapping unknown
---@param user_data? unknown
---@return unknown
function Settings:get_mapped(key, mapping, user_data) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_range(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_string(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_strv(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_uint(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_uint64(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_user_value(key) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:get_value(key) end

---@param self lgi.Gio.Settings
---@param name unknown
---@return unknown
function Settings:is_writable(name) end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:list_children() end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:list_keys() end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:range_check(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@return unknown
function Settings:reset(key) end

---@param self lgi.Gio.Settings
---@return unknown
function Settings:revert() end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_boolean(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_double(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_enum(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_flags(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_int(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_int64(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_string(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value? unknown
---@return unknown
function Settings:set_strv(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_uint(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_uint64(key, value) end

---@param self lgi.Gio.Settings
---@param key unknown
---@param value unknown
---@return unknown
function Settings:set_value(key, value) end

return Settings


---@meta lgi.GObject.Object

---@class lgi.GObject.Object
local Object = {}

---@param object_type unknown
---@param n_parameters unknown
---@param parameters unknown
---@return lgi.GObject.Object
function Object.newv(object_type, n_parameters, parameters) end

---@param what unknown
---@param data? unknown
---@return unknown
function Object.compat_control(what, data) end

---@param g_iface unknown
---@param property_name unknown
---@return unknown
function Object.interface_find_property(g_iface, property_name) end

---@param g_iface unknown
---@param pspec unknown
---@return unknown
function Object.interface_install_property(g_iface, pspec) end

---@param g_iface unknown
---@return unknown
function Object.interface_list_properties(g_iface) end

---@param self lgi.GObject.Object
---@param source_property unknown
---@param target unknown
---@param target_property unknown
---@param flags unknown
---@return unknown
function Object:bind_property(source_property, target, target_property, flags) end

---@param self lgi.GObject.Object
---@param source_property unknown
---@param target unknown
---@param target_property unknown
---@param flags unknown
---@param transform_to unknown
---@param transform_from unknown
---@return unknown
function Object:bind_property_full(source_property, target, target_property, flags, transform_to, transform_from) end

---@param self lgi.GObject.Object
---@return unknown
function Object:force_floating() end

---@param self lgi.GObject.Object
---@return unknown
function Object:freeze_notify() end

---@param self lgi.GObject.Object
---@param key unknown
---@return unknown
function Object:get_data(key) end

---@param self lgi.GObject.Object
---@param property_name unknown
---@param value unknown
---@return unknown
function Object:get_property(property_name, value) end

---@param self lgi.GObject.Object
---@param quark unknown
---@return unknown
function Object:get_qdata(quark) end

---@param self lgi.GObject.Object
---@param n_properties unknown
---@param names unknown
---@param values unknown
---@return unknown
function Object:getv(n_properties, names, values) end

---@param self lgi.GObject.Object
---@return unknown
function Object:is_floating() end

---@param self lgi.GObject.Object
---@param property_name unknown
---@return unknown
function Object:notify(property_name) end

---@param self lgi.GObject.Object
---@param pspec unknown
---@return unknown
function Object:notify_by_pspec(pspec) end

---@param self lgi.GObject.Object
---@return unknown
function Object:ref() end

---@param self lgi.GObject.Object
---@return unknown
function Object:ref_sink() end

---@param self lgi.GObject.Object
---@return unknown
function Object:run_dispose() end

---@param self lgi.GObject.Object
---@param key unknown
---@param data? unknown
---@return unknown
function Object:set_data(key, data) end

---@param self lgi.GObject.Object
---@param property_name unknown
---@param value unknown
---@return unknown
function Object:set_property(property_name, value) end

---@param self lgi.GObject.Object
---@param key unknown
---@return unknown
function Object:steal_data(key) end

---@param self lgi.GObject.Object
---@param quark unknown
---@return unknown
function Object:steal_qdata(quark) end

---@param self lgi.GObject.Object
---@return unknown
function Object:thaw_notify() end

---@param self lgi.GObject.Object
---@return unknown
function Object:unref() end

---@param self lgi.GObject.Object
---@param closure unknown
---@return unknown
function Object:watch_closure(closure) end

return Object

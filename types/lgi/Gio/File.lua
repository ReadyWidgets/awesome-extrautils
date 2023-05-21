---@meta lgi.Gio.File

---@class lgi.Gio.File
local File = {}

---@param arg unknown
---@return unknown
function File.new_for_commandline_arg(arg) end

---@param arg unknown
---@param cwd unknown
---@return unknown
function File.new_for_commandline_arg_and_cwd(arg, cwd) end

---@param path unknown
---@return unknown
function File.new_for_path(path) end

---@param uri unknown
---@return unknown
function File.new_for_uri(uri) end

---@param tmpl? unknown
---@return unknown
function File.new_tmp(tmpl) end

---@param tmpl? unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File.new_tmp_async(tmpl, io_priority, cancellable, callback, user_data) end

---@param tmpl? unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File.new_tmp_dir_async(tmpl, io_priority, cancellable, callback, user_data) end

---@param result unknown
---@return unknown
function File.new_tmp_dir_finish(result) end

---@param result unknown
---@return unknown
function File.new_tmp_finish(result) end

---@param parse_name unknown
---@return unknown
function File.parse_name(parse_name) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:append_to(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:append_to_async(flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:append_to_finish(res) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:build_attribute_list_for_copy(flags, cancellable) end

---@param self lgi.Gio.File
---@param destination unknown
---@param flags unknown
---@param cancellable? unknown
---@param progress_callback? unknown
---@param progress_callback_data? unknown
---@return unknown
function File:copy(destination, flags, cancellable, progress_callback, progress_callback_data) end

---@param self lgi.Gio.File
---@param destination unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param progress_callback? unknown
---@param progress_callback_data? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:copy_async(destination, flags, io_priority, cancellable, progress_callback, progress_callback_data, callback, user_data) end

---@param self lgi.Gio.File
---@param destination unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:copy_attributes(destination, flags, cancellable) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:copy_finish(res) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:create(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:create_async(flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:create_finish(res) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:create_readwrite(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:create_readwrite_async(flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:create_readwrite_finish(res) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:delete(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:delete_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:delete_finish(result) end

---@param self lgi.Gio.File
---@return unknown
function File:dup() end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:eject_mountable(flags, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:eject_mountable_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param mount_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:eject_mountable_with_operation(flags, mount_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:eject_mountable_with_operation_finish(result) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:enumerate_children(attributes, flags, cancellable) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:enumerate_children_async(attributes, flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:enumerate_children_finish(res) end

---@param self lgi.Gio.File
---@param file2 unknown
---@return unknown
function File:equal(file2) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:find_enclosing_mount(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:find_enclosing_mount_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:find_enclosing_mount_finish(res) end

---@param self lgi.Gio.File
---@return unknown
function File:get_basename() end

---@param self lgi.Gio.File
---@param name unknown
---@return unknown
function File:get_child(name) end

---@param self lgi.Gio.File
---@param display_name unknown
---@return unknown
function File:get_child_for_display_name(display_name) end

---@param self lgi.Gio.File
---@return unknown
function File:get_parent() end

---@param self lgi.Gio.File
---@return unknown
function File:get_parse_name() end

---@param self lgi.Gio.File
---@return unknown
function File:get_path() end

---@param self lgi.Gio.File
---@param descendant unknown
---@return unknown
function File:get_relative_path(descendant) end

---@param self lgi.Gio.File
---@return unknown
function File:get_uri() end

---@param self lgi.Gio.File
---@return unknown
function File:get_uri_scheme() end

---@param self lgi.Gio.File
---@param parent? unknown
---@return unknown
function File:has_parent(parent) end

---@param self lgi.Gio.File
---@param prefix unknown
---@return unknown
function File:has_prefix(prefix) end

---@param self lgi.Gio.File
---@param uri_scheme unknown
---@return unknown
function File:has_uri_scheme(uri_scheme) end

---@param self lgi.Gio.File
---@return unknown
function File:hash() end

---@param self lgi.Gio.File
---@return unknown
function File:is_native() end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:load_bytes(cancellable) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:load_bytes_async(cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:load_bytes_finish(result) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:load_contents(cancellable) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:load_contents_async(cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:load_contents_finish(res) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:load_partial_contents_finish(res) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:make_directory(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:make_directory_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:make_directory_finish(result) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:make_directory_with_parents(cancellable) end

---@param self lgi.Gio.File
---@param symlink_value unknown
---@param cancellable? unknown
---@return unknown
function File:make_symbolic_link(symlink_value, cancellable) end

---@param self lgi.Gio.File
---@param symlink_value unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:make_symbolic_link_async(symlink_value, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:make_symbolic_link_finish(result) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:measure_disk_usage_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:monitor(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:monitor_directory(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:monitor_file(flags, cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param mount_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:mount_enclosing_volume(flags, mount_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:mount_enclosing_volume_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param mount_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:mount_mountable(flags, mount_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:mount_mountable_finish(result) end

---@param self lgi.Gio.File
---@param destination unknown
---@param flags unknown
---@param cancellable? unknown
---@param progress_callback? unknown
---@param progress_callback_data? unknown
---@return unknown
function File:move(destination, flags, cancellable, progress_callback, progress_callback_data) end

---@param self lgi.Gio.File
---@param destination unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param progress_callback? unknown
---@param progress_callback_data? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:move_async(destination, flags, io_priority, cancellable, progress_callback, progress_callback_data, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:move_finish(result) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:open_readwrite(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:open_readwrite_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:open_readwrite_finish(res) end

---@param self lgi.Gio.File
---@return unknown
function File:peek_path() end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:poll_mountable(cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:poll_mountable_finish(result) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:query_default_handler(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:query_default_handler_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:query_default_handler_finish(result) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:query_exists(cancellable) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:query_file_type(flags, cancellable) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param cancellable? unknown
---@return unknown
function File:query_filesystem_info(attributes, cancellable) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:query_filesystem_info_async(attributes, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:query_filesystem_info_finish(res) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:query_info(attributes, flags, cancellable) end

---@param self lgi.Gio.File
---@param attributes unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:query_info_async(attributes, flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:query_info_finish(res) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:query_settable_attributes(cancellable) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:query_writable_namespaces(cancellable) end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:read(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:read_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:read_finish(res) end

---@param self lgi.Gio.File
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:replace(etag, make_backup, flags, cancellable) end

---@param self lgi.Gio.File
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:replace_async(etag, make_backup, flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param contents unknown
---@param length unknown
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:replace_contents(contents, length, etag, make_backup, flags, cancellable) end

---@param self lgi.Gio.File
---@param contents unknown
---@param length unknown
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:replace_contents_async(contents, length, etag, make_backup, flags, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param contents unknown
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:replace_contents_bytes_async(contents, etag, make_backup, flags, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:replace_contents_finish(res) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:replace_finish(res) end

---@param self lgi.Gio.File
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:replace_readwrite(etag, make_backup, flags, cancellable) end

---@param self lgi.Gio.File
---@param etag? unknown
---@param make_backup unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:replace_readwrite_async(etag, make_backup, flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:replace_readwrite_finish(res) end

---@param self lgi.Gio.File
---@param relative_path unknown
---@return unknown
function File:resolve_relative_path(relative_path) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param type unknown
---@param value_p? unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute(attribute, type, value_p, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_byte_string(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_int32(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_int64(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_string(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_uint32(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param attribute unknown
---@param value unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attribute_uint64(attribute, value, flags, cancellable) end

---@param self lgi.Gio.File
---@param info unknown
---@param flags unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:set_attributes_async(info, flags, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:set_attributes_finish(result) end

---@param self lgi.Gio.File
---@param info unknown
---@param flags unknown
---@param cancellable? unknown
---@return unknown
function File:set_attributes_from_info(info, flags, cancellable) end

---@param self lgi.Gio.File
---@param display_name unknown
---@param cancellable? unknown
---@return unknown
function File:set_display_name(display_name, cancellable) end

---@param self lgi.Gio.File
---@param display_name unknown
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:set_display_name_async(display_name, io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param res unknown
---@return unknown
function File:set_display_name_finish(res) end

---@param self lgi.Gio.File
---@param flags unknown
---@param start_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:start_mountable(flags, start_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:start_mountable_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param mount_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:stop_mountable(flags, mount_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:stop_mountable_finish(result) end

---@param self lgi.Gio.File
---@return unknown
function File:supports_thread_contexts() end

---@param self lgi.Gio.File
---@param cancellable? unknown
---@return unknown
function File:trash(cancellable) end

---@param self lgi.Gio.File
---@param io_priority unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:trash_async(io_priority, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:trash_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:unmount_mountable(flags, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:unmount_mountable_finish(result) end

---@param self lgi.Gio.File
---@param flags unknown
---@param mount_operation? unknown
---@param cancellable? unknown
---@param callback? unknown
---@param user_data? unknown
---@return unknown
function File:unmount_mountable_with_operation(flags, mount_operation, cancellable, callback, user_data) end

---@param self lgi.Gio.File
---@param result unknown
---@return unknown
function File:unmount_mountable_with_operation_finish(result) end

return File


local pcall = pcall
local xpcall = xpcall
local error = error
local select = select
local setmetatable = setmetatable

local traceback = debug.traceback

local extrautils_table = require("extrautils.table")
local unpack = require("extrautils.compat").unpack

local lgi = require("lgi")
local Gio  = lgi.Gio
local GLib = lgi.GLib

local async_start = Gio.Async.start

local function log_error(err)
	print(traceback("ERROR: " .. tostring(err)))
end

---@class AwesomeExtrautils.file : AwesomeExtrautils.Table
local file = extrautils_table.create()

--- # `public static function file.is_directory()`
---
--- Check whether a path string or a Gio.File object is a directory or not. Also returns `false`
--- if the given file system object does not exist.
---
--- Note: This function is for internal use, you probably want to use
--- `gears.filesystem.gears.filesystem.dir_readable()` instead.
---
--- ---
---
--- ## Example:
---
--- ```
--- local desktop_dir = os.getenv("XDG_DESKTOP_HOME") or (os.getenv("HOME") .. "/Desktop")
--- 
--- if file.is_directory(desktop_dir) then
--- 	print("The user has a downloads folder!")
--- else
--- 	print("The user has note downloads folder :(")
--- end
--- ```
---
--- ---
---
--- Parameters:
---
--- | Name       | Type                  | Default | Required? | Description                                                         |
--- | ---------- | --------------------- | ------- | --------- | ------------------------------------------------------------------- |
--- | `path`     | `string|lgi.Gio.File` | `nil`   | Yes       | The full path to the directory or a Gio.File object pointing to it. |
---
--- Returns:
--- | Type    | Description                                                     |
--- | ------- | --------------------------------------------------------------- |
--- | boolean | `true` if the file system object exists **and** is a directory. |
---
--- ---
---
---@param path string|lgi.Gio.File
---@return boolean
function file.is_directory(path)
	if type(path) == "string" then
		path = Gio.File.new_for_path(path)
	end

	return path:query_file_type(Gio.FileQueryInfoFlags.NONE) == "DIRECTORY"
end

--- # `public static function file.is_file()`
---
--- Check whether a path string or a Gio.File object is a directory or not. Also returns `false`
--- if the given file system object does not exist.
---
--- Note: This function is for internal use, you probably want to use
--- `gears.filesystem.gears.filesystem.file_readable()` instead.
---
--- ---
---
--- ## Example:
---
--- ```
--- local awesome_config_file = gears.filesystem.get_configuration_dir() .. "/rc.lua"
--- 
--- if file.is_file(awesome_config_file) then
--- 	print("The user has a downloads folder!")
--- else
--- 	print("The user has note downloads folder :(")
--- end
--- ```
---
--- ---
---
--- Parameters:
---
--- | Name       | Type                  | Default | Required? | Description                                                    |
--- | ---------- | --------------------- | ------- | --------- | -------------------------------------------------------------- |
--- | `path`     | `string|lgi.Gio.File` | `nil`   | Yes       | The full path to the file or a Gio.File object pointing to it. |
---
--- Returns:
--- | Type    | Description                                                |
--- | ------- | ---------------------------------------------------------- |
--- | boolean | `true` if the file system object exists **and** is a file. |
---
--- ---
---
---@param path string|lgi.Gio.File
---@return boolean
function file.is_file(path)
	if type(path) == "string" then
		path = Gio.File.new_for_path(path)
	end

	return path:query_file_type(Gio.FileQueryInfoFlags.NONE) == "REGULAR"
end

--- # `public static function file.protected_open()`
---
--- Open a file safely, so that it will still be closed, even on error.
---
--- Please note that this function can still throw errors; it just makes sure that
--- the file gets closed properly, first.
---
--- Also note that this function is synchronous, and you should probably use the other
--- functions provided by this modules instead (synchronous file IO means your session may
--- freeze for any amount of time if the file can't be loaded immediatly, be it due to a slow
--- disk, a sudden CPU lag spike or something else).
---
--- ---
---
--- Example:
---
--- ```
--- file.protected_open("/tmp/logfile.log", "w", function(f)
--- 	f:write("[" .. os.date() .. "] Hello, world!")
--- end)
--- ```
---
--- ---
---
--- Generics:
---
--- | Name                | Parents | Description                                                                                    |
--- | ------------------- | ------- | ---------------------------------------------------------------------------------------------- |
--- | `T_return_callback` | (none)  | The return type of `callback`; the arguments get passed down and returned by `protected_open`. |
---
--- Parameters:
---
--- | Name       | Type                                     | Default | Required? | Description                                                       |
--- | ---------- | ---------------------------------------- | ------- | --------- | ----------------------------------------------------------------- |
--- | `path`     | `string`                                 | `nil`   | Yes       | The full path to the file.                                        |
--- | `mode`     | `string`                                 | `"r+"`  | No        | A mode string, like `"r"`; see `io.open`'s documentaion.          |
--- | `callback` | `fun(file: file*): ...T_return_callback` | `nil`   | Yes       | A synchronous callback which will be called with the opened file. |
---
--- Returns:
---
--- | Type                   | Description                    |
--- | ---------------------- | ------------------------------ |
--- | `...T_return_callback` | Return value(s) of `callback`. |
---
--- ---
---
---@generic T_return_callback
---@param path string A file path for `io.open()`
---@param mode? string A mode string for `io.open()`, or `"r+"` (read and write, only if the file exists) if `nil`
---@param callback (fun(file: file*): T_return_callback, ...)
---@return nil|T_return_callback, ...
function file.protected_open(path, mode, callback)
	local success, f = pcall(io.open, path, mode or "r+")

	if not f then
		error("An error occured while trying to open '" .. tostring(path) .. "'!")
		return
	end

	if not success then
		error("An error occured while trying to open '" .. tostring(path) .. "'!")
		f:close()
		return
	end

	local results = {
		select(2, xpcall(function()
			callback(f)
		end, function(err)
			error("An error occured while trying to run the callback:\n -> " .. tostring(err))
		end))
	}

	f:close()

	return unpack(results)
end

--#region list_children
local function create_value_iterable()
	local k

	return setmetatable({}, {
		__call = function(self)
			local v
			k, v = next(self, k)
			return v
		end
	})
end

local function __list_children_impl_inner(dir, result, callback, sort)
	local files = create_value_iterable()

	local success = xpcall(function()
		local file_enumerator = dir:enumerate_children_finish(result)

		local info = file_enumerator:next_file()

		while info do
			files[#files+1] = file_enumerator:get_child(info)

			info = file_enumerator:next_file()
		end
	end, function(err)
		print("ERROR: " .. tostring(err))
	end)

	if sort then
		table.sort(files, function(a, b)
			return a:get_basename():lower() < b:get_basename():lower()
		end)
	end

	return callback(success, files)
end

local function __list_children_impl(path, callback, sort)
	local dir

	if type(path) ~= "string" then
		dir = path
	else
		dir = Gio.File.new_for_path(path)
	end

	assert(file.is_directory(dir), "ERROR: '" .. path .. "' is not a directory!")

	xpcall(function()
		dir:enumerate_children_async(
			"standard::name,standard::type",
			Gio.FileQueryInfoFlags.NONE,
			0,
			nil,
			function(_, result)
				__list_children_impl_inner(dir, result, callback, sort)
			end
		)
	end, log_error)
end

--- # `public static async function file.list_children()`
---
--- Get a list of children (files and sub-directories) of a directory.
---
--- > **Note**: Since this function is asynchronous, it does not return anything. It
--- uses a callback function instead. Callbacks have no guarantees about when exactly they
--- will called, so make sure that any logic relying on the value is *inside* the callback!
---
--- ---
---
--- ## Example:
---
--- ```
--- --- Get a list of files and directories on the user's desktop
--- local desktop_dir = os.getenv("XDG_DESKTOP_HOME") or (os.getenv("HOME") .. "/Desktop")
---
--- file.list_children(desktop_dir, function(children)
--- 	for child in children do
--- 		print(a:get_basename())
--- 	end
--- end)
--- ```
---
--- ---
---
--- Parameters:
---
--- | Name       | Type                                              | Default | Required? | Description                                                               |
--- | ---------- | ------------------------------------------------- | ------- | --------- | ------------------------------------------------------------------------- |
--- | `path`     | `string`                                          | `nil`   | Yes       | The full path to the directory you want to get a list of children of.     |
--- | `callback` | `fun(success: boolean, children: lgi.Gio.File[])` | `nil`   | Yes       | A callback that will be called once the list of files has been retrieved. |
--- | `sort`     | `boolean`                                         | `false` | No        | If `true`, the list of children will be sorted by their filepath.         |
---
--- ---
---
---@param path string The full path to the directory you want to get a list of children of.
---@param callback fun(success: boolean, children: lgi.Gio.File[]) A callback that will be called once the list of files has been retrieved.
---@param sort? boolean If `true`, the list of children will be sorted by their filepath.
function file.list_children(path, callback, sort)
	async_start(__list_children_impl)(path, callback, sort)
end
--#endregion

------------------------------------------------------------------------

--#region read_async
local function __read_impl_inner(f, result, callback)
	local contents

	local success = xpcall(function()
		contents = f:load_contents_finish(result)
	end, function(err)
		print("ERROR: " .. tostring(err))
	end)

	return callback(success, contents)
end

local function __read_impl(path, callback)
	local f

	if type(path) ~= "string" then
		f = path
	else
		f = Gio.File.new_for_path(path)
	end

	assert(file.is_file(f), "ERROR: '" .. path .. "' is not a file!")

	xpcall(function()
		f:load_contents_async(
			nil,
			function(_, result)
				__read_impl_inner(f, result, callback)
			end
		)
	end, log_error)
end

---@param path string
---@param callback fun(success: boolean, content: string)
function file.read_async(path, callback, sort)
	return async_start(__read_impl)(path, callback)
end
--#endregion

------------------------------------------------------------------------

--#region write_async
local function __write_impl_inner(f, result, callback)
	local success = xpcall(function()
		f:replace_contents_finish(result)
	end, function(err)
		print("ERROR: " .. tostring(err))
	end)

	return callback(success)
end

local function __write_impl(path, new_content, callback)
	local f

	if type(path) ~= "string" then
		f = path
	else
		f = Gio.File.new_for_path(path)
	end

	assert(file.is_file(f), "ERROR: '" .. path .. "' is not a file!")

	xpcall(function()
		f:replace_contents_async(new_content, nil, false, Gio.FileCreateFlags.REPLACE_DESTINATION, nil,
			function(_, result)
				__write_impl_inner(f, result, callback)
			end
		)
	end, log_error)
end

---@param path string
---@param new_content string
---@param callback fun(success: boolean, content: string)
function file.write_async(path, new_content, callback)
	return async_start(__write_impl)(path, new_content, callback)
end

--- To test, run:
---
--- ```
--- local lgi  = require("lgi")
--- local Gio  = lgi.Gio
--- local GLib = lgi.GLib
--- 
--- local loop = GLib.MainLoop()
--- 
--- local file = require("extrautils.file")
--- 
--- file.write_async(
--- 	"/tmp/test.txt",
--- 	"Hello, world!\n",
--- 	function(success)
--- 		print("success = " .. tostring(success))
--- 		os.exit(0)
--- 	end
--- )
--- 
--- loop:run()
--- ```
--- 
--- The file `/tmp/test.txt` should now contain the line `"Hello, world!"`.
---
--#endregion

------------------------------------------------------------------------

return file

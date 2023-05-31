local pcall = pcall
local xpcall = xpcall
local error = error
local select = select
local setmetatable = setmetatable

local traceback = debug.traceback

local class = require("extrautils.class")
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

---@generic T1
---@alias AwesomeExtrautils.file.Callback fun(success: boolean, result: T1)

---@generic T1
---@alias AwesomeExtrautils.file.AsyncFunction fun(f: string|lgi.Gio.File, callback?: AwesomeExtrautils.file.Callback<T1>): AwesomeExtrautils.asyncio.AsyncResult

local function default_process_result(...)
	return ...
end

---@param f string|lgi.Gio.File
---@param callback fun(gfile: lgi.Gio.File)
function file.default_get_gfile(f, callback)
	if type(f) == "string" then
		f = Gio.File.new_for_path(f)
	end

	return callback(f)
end

---@param method_name string
---@param method_args table<integer, any>
---@param method_args_length integer
---@param process_result? fun(...): any
---@param get_gfile? fun(f: (string|lgi.Gio.File), callback: fun(gfile: lgi.Gio.File))
---@return AwesomeExtrautils.file.AsyncFunction
function file.create_async_wrapper(method_name, method_args, method_args_length, process_result, get_gfile)
	process_result = process_result or default_process_result

	get_gfile = get_gfile or file.default_get_gfile

	local function impl_inner(gfile, callback, async_result)
		local result

		local success = xpcall(function()
			result = process_result(
				gfile[method_name .. "_finish"](
					gfile,
					async_result
				)
			)
		end, log_error)

		return callback(success, result)
	end

	local function impl(gfile, callback)
		-- TODO: Currently, nil values at the end of method_args get discarded. To prevent this,
		-- we need to implement a custom constructor for a table that takes in a ... parameter
		-- and which has a length stored in it explicitly. That way, we can preserve nil values
		-- and remove the current workaround of passing an explicit length.

		local args = { gfile }
		local args_length = method_args_length + 2

		for i = 1, method_args_length do
			args[i+1] = method_args[i]
		end

		args[args_length] = function(_, async_result)
			return impl_inner(gfile, callback, async_result)
		end

		return xpcall(function()
			gfile[method_name .. "_async"](unpack(args, 1, args_length))
		end, log_error)
	end

	return function(f, callback)
		local function run(cb)
			async_start(get_gfile)(f, function(gfile)
				async_start(impl)(gfile, cb)
			end)
		end

		if callback then
			run(callback)
		end

		return run
	end
end

---@param promises (fun(cb: AwesomeExtrautils.file.Callback, ...))[]
---@param callback fun(all_results: table<integer, any>)
---@param collected_results? table
---@param current_key? integer
function file.chained_call(promises, callback, collected_results, current_key)
	collected_results = collected_results or {}
	local len = #collected_results

	if next(promises, current_key) == nil then
		return callback(collected_results)
	end

	local current_promise
	current_key, current_promise = next(promises, current_key)

	local promise_run, promise_callback = current_promise()
	promise_run(function(success, result)
		if not success then
			print("ERROR: Something went wrong!")
			return
		end

		if promise_callback then
			promise_callback(success, result)
		end

		collected_results[len+1] = result

		return file.chained_call(promises, callback, collected_results, current_key)
	end)
end

--- # `public static async function file.is_directory()`
---
--- ## Abstract
---
--- Check whether a path string or a Gio.File object is a directory or not.
---
--- > **Note**: Since this function is asynchronous, it does not return anything. It
--- uses a callback function instead. Callbacks have no guarantees about when exactly they
--- will called, so make sure that any logic relying on the value is *inside* the callback!
---
--- ---
---
--- ## Usage
---
--- ```
--- local desktop_dir = os.getenv("XDG_DESKTOP_HOME") or (os.getenv("HOME") .. "/Desktop")
--- 
--- file.is_directory(desktop_dir, function(success, result)
--- 	if result then
--- 		print("The user has a downloads folder!")
--- 	else
--- 		print("The doesn't have a downloads folder :(")
--- 	end
--- end)
--- ```
---
--- ---
---
--- ## Type info
---
--- ### Parameters:
---
--- | Name       | Type                                     | Default | Required? | Description                                          |
--- | ---------- | ---------------------------------------- | ------- | --------- | ---------------------------------------------------  |
--- | `f`        | `string\|lgi.Gio.File`                   | `nil`   | Yes       | The full path to the directory or a Gio.File object. |
--- | `callback` | `fun(success: boolean, result: boolean)` | `nil`   | Yes       | The callback function.                               |
---
--- ### Parameters for `callback`:
---
--- | Name           | Type    | Description                                                     |
--- | -------------- | ------- | --------------------------------------------------------------- |
--- | `success`      | boolean | `true` if the function executed correctly.                      |
--- | `is_directory` | boolean | `true` if the file system object exists **and** is a directory. |
---
--- ---
---
---@type AwesomeExtrautils.file.AsyncFunction#<boolean>
file.is_directory_async = file.create_async_wrapper(
	"query_info",
	{ "standard::type", Gio.FileQueryInfoFlags.NONE, 1, nil },
	4,
	function(result)
		return result:get_file_type() == "DIRECTORY"
	end
)
-- TODO: Replace async functions here with ones generated by file.create_async_wrapper()

--[===[ Demo:
file.is_directory_async(
	os.getenv("HOME"),
	function(success, result)
		print(("success = '%s' | result = '%s'"):format(success, result))
	end
)
--]===]
--#endregion

--- # `public static async function file.is_file()`
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
---
--- | Type    | Description                                                |
--- | ------- | ---------------------------------------------------------- |
--- | boolean | `true` if the file system object exists **and** is a file. |
---
--- ---
---
---@type AwesomeExtrautils.file.AsyncFunction#<boolean>
file.is_file_async = file.create_async_wrapper(
	"query_info",
	{ "standard::type", Gio.FileQueryInfoFlags.NONE, 1, nil },
	4,
	function(result)
		return result:get_file_type() == "REGULAR"
	end
)

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
---@param callback (fun(file: file*): nil|T_return_callback, nil|...)
---@return nil|T_return_callback, nil|...
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
	end, log_error)

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

	assert(file.is_directory_async(dir), "ERROR: '" .. path .. "' is not a directory!")

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
---@param f string|lgi.Gio.File The full path to the directory you want to get a list of children of.
---@param sort boolean If `true`, the list of children will be sorted by their filepath.
---@param callback fun(success: boolean, children: lgi.Gio.File[]) A callback that will be called once the list of files has been retrieved.
---@overload fun(f: string|lgi.Gio.File, callback: fun(success: boolean, children: lgi.Gio.File[]))
function file.list_children(f, sort, callback)
	if sort ~= nil and callback == nil then
		---@diagnostic disable-next-line: cast-type-mismatch
		---@cast sort fun(success: boolean, children: lgi.Gio.File[])
		callback = sort
		sort = false
	end

	async_start(__list_children_impl)(f, callback, sort)
end
--#endregion

file.list_children = file.create_async_wrapper(
	"enumerate_children",
	{ "standard::name,standard::type", Gio.FileQueryInfoFlags.NONE, 0, nil },
	4,
	function(file_enumerator)
		local files = create_value_iterable()

		local info = file_enumerator:next_file()

		while info do
			files[#files+1] = file_enumerator:get_child(info)

			info = file_enumerator:next_file()
		end

		return files
	end,
	function (f, callback)
		file.is_directory_async(f, function(success, is_directory)
			if type(f) == "string" then
				f = Gio.File.new_for_path(f)
			end

			assert(is_directory, "ERROR: '" .. f:get_path() .. "' is not a directory!")

			callback(f)
		end)
	end
)

------------------------------------------------------------------------

--#region read_async

file.read_async = file.create_async_wrapper(
	"load_contents",
	{ nil },
	1,
	nil,
	function (f, callback)
		file.is_file_async(f, function(success, is_file)
			if type(f) == "string" then
				f = Gio.File.new_for_path(f)
			end

			assert(is_file, "ERROR: '" .. f:get_path() .. "' is not a file!")

			callback(f)
		end)
	end
)
--#endregion

------------------------------------------------------------------------

file.make_file = file.create_async_wrapper(
	"create",
	{ Gio.FileCreateFlags.NONE, 0, nil },
	3
)

file.make_directory = file.create_async_wrapper(
	"make_directory",
	{ 0, nil },
	2
)

--#region write_async

-- TODO: Make file.write_async create the file if it doesn't exist already

---@return AwesomeExtrautils.file.AsyncFunction
function file.write_async(f, new_content, callback)
	---@diagnostic disable-next-line: missing-return-value
	return file.create_async_wrapper(
		"replace_contents",
		{ new_content, nil, false, Gio.FileCreateFlags.REPLACE_DESTINATION, nil },
		5,
		nil,
		function(_f, _callback)
			file.default_get_gfile(_f, function(gfile)
				-- TODO: (See above TODO)
			end)
		end
	)(f, callback)
end

--- To test, run:
---
--- ```
--- local lgi  = require("lgi")
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

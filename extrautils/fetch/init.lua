local lgi  = require("lgi")
local Gio  = lgi.Gio
local GLib = lgi.GLib

local new_file_for_uri = Gio.File.new_for_uri
local new_data_input_stream = Gio.DataInputStream.new

local extrautils_table = require("extrautils.table")
local file = require("extrautils.file")
local asyncio = require("extrautils.asyncio")
local async, await, async_run = asyncio.async, asyncio.await, asyncio.async_run

---@class AwesomeExtrautils.fetch : AwesomeExtrautils.Table
local fetch = extrautils_table.create()

---@generic T1, T2
---@param fn fun(...: T1): (nil|T2), ...
---@param ... T1
---@return (nil|T2), ...
local function try(fn, ...)
	local args = { ... }

	local result

	xpcall(function()
		result = { fn(unpack(args)) }
	end, function(err)
		print(debug.traceback("\027[1;31mERROR in " .. tostring(err) .. "\027[0m"))
	end)

	return unpack(result)
end

---@type fun(data_input_stream: lgi.Gio.DataInputStream): fun(callback: fun())
local read_data_input_stream_line_async = file.create_async_wrapper(
	"read_line",
	{ 0, nil },
	2,
	nil,
	---@param f lgi.Gio.DataInputStream
	---@param callback fun(data_input_stream: lgi.Gio.DataInputStream)
	function(f, callback)
		return callback(f)
	end
)

--- Get all lines of a Gio.DataInputStream as a string
---@param data_input_stream lgi.Gio.DataInputStream
local get_all_lines = asyncio.wrap(function(data_input_stream, callback)
	local all_lines

	local newline = "\n" -- data_input_stream:get_newline_type() == 0

	do
		local newline_type = data_input_stream:get_newline_type()

		if newline_type == 1 then
			newline = "\r"
		elseif newline_type == 2 then
			newline = "\r\n"
		end
	end

	while true do
		local current_line = await(read_data_input_stream_line_async(data_input_stream))

		if current_line == nil then
			break
		end

		if all_lines == nil then
			all_lines = current_line
		else
			all_lines = all_lines .. newline .. current_line
		end
	end

	all_lines = (all_lines or "") -- :gsub("\r\n", "\n")

	return callback(all_lines, newline)
end)

local read_file_from_uri_async = file.create_async_wrapper(
	"read",
	{ 0, nil },
	2,
	nil,
	function(f, callback)
		if type(f) == "string" then
			f = new_file_for_uri(f)
		end

		return callback(f)
	end
)

fetch.read_file_from_url = async(function(f)
	local file_read = await(read_file_from_uri_async(f))

	local data_input_stream = new_data_input_stream(file_read)

	local all_lines, newline = await(get_all_lines(data_input_stream))

	return all_lines, newline
end)

do
	local loop = lgi.GLib.MainLoop()

	local task = async(function(url)
		local result = await(fetch.read_file_from_url(url))

		print("result = " .. tostring(result))

		loop:quit()
	end)

	asyncio.run(task("https://jsonplaceholder.typicode.com/todos/1"))

	loop:run()
end

return fetch

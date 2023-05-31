local lgi = require("lgi")
local Gio = lgi.Gio

local new_file_for_uri = Gio.File.new_for_uri
local new_data_input_stream = Gio.DataInputStream.new

local extrautils_table = require("extrautils.table")
local file = require("extrautils.file")
local asyncio = require("extrautils.asyncio")
local async, await, async_run = asyncio.async, asyncio.await, asyncio.async_run

---@class AwesomeExtrautils.fetch : AwesomeExtrautils.Table
local fetch = extrautils_table.create()

local read_data_input_stream_line_async = file.create_async_wrapper(
	"read_line",
	{ 0, nil },
	2
)

--- Get all lines of a Gio.DataInputStream as a string
---@param data_input_stream lgi.Gio.DataInputStream
---@param callback AwesomeExtrautils.asyncio.AsyncResult
local get_all_lines = async(function(data_input_stream, callback)
	local all_lines

	while true do
		--print("   - Awaiting current line...")
		local current_line = await(read_data_input_stream_line_async(data_input_stream))
		--print("   - Got line '" .. tostring(line) .. "'")

		if current_line == nil then
			break
		end

		if all_lines == nil then
			all_lines = current_line
		else
			all_lines = all_lines .. "\n" .. current_line
		end
	end

	all_lines = (all_lines or "") -- :gsub("\r\n", "\n")

	print("   - Got all lines!")
	print("     - [[" .. all_lines:gsub("\n", "\n       ") .. "]]")
	print("   - Running callback '" .. tostring(callback) .. "'...")
	return callback(all_lines)
end)

local read_file_from_uri_async = file.create_async_wrapper(
	"read",
	{ 0, nil },
	2,
	function(result)
		print("   - Result of read_file_from_uri_async() call: " .. tostring(result))

		return result
	end,
	function(f, callback)
		if type(f) == "string" then
			f = Gio.File.new_for_uri(f)
		end

		return callback(f)
	end
)

fetch.read_file_from_url = asyncio.wrap(function(f, callback)
	--xpcall(function()
		print(" - Reading file '" .. tostring(f) .. "'...")
		local file_read = await(read_file_from_uri_async(f))

		print(" - Creating data input stream...")
		local data_input_stream = new_data_input_stream(file_read)

		print(" - Retrieving lines")
		local all_lines = await(get_all_lines(data_input_stream))

		print(" - Printing lines...")
		print(all_lines)

		return callback(all_lines)
	--end, function(err)
	--	print(debug.traceback("\027[1;31mERROR\027[0m in " .. tostring(err)))
	--end)
end)

--print(
--	get_all_lines(
--		new_data_input_stream(
--			new_file_for_uri("https://jsonplaceholder.typicode.com/todos/1"):read()
--		)
--	)
--)

local loop = lgi.GLib.MainLoop()

async_run(function()
	-- TODO: Doesn't work...
	print(" - Awaiting call to fetch.read_file_from_url()...")
	await(fetch.read_file_from_url("https://jsonplaceholder.typicode.com/todos/1"))

	print(" - All done!")
	loop:quit()
end)

loop:run()

return fetch

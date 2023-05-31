local lgi = require("lgi")
local Gio  = lgi.Gio
local GLib = lgi.GLib

local loop = GLib.MainLoop()

local pack = table.pack or function(...) return { ... } end
local unpack = table.unpack or unpack

local file = require("extrautils.file")

local path = "/tmp/test.txt"

file.protected_open(path, "w", function(f)
	f:write("Bye, world!")
	print("Current content of \"" .. path .. "\":\n\"" .. f:read("*a") .. "\"\n----------------------------")
end)

local asyncio = require("extrautils.asyncio")
local async, async_run, await
do
	async, async_run, await = asyncio.async, asyncio.async_run, asyncio.await
end

--[[
file.chained_call(
	{
		file.write_async(path, "Hello, world!"),
		file.read_async(path)
	},

	function(results)
		for k, v in ipairs(results) do
			print(k, v)
		end
	end
)
--]]

local function cat(f)
	print('"' .. await(file.read_async(f)) .. '"')
end

local function touch(f)
	await(file.make_file(f))
end

local function save(f, content)
	await(file.write_async(f, content))
end

local function ls(dir)
	local children = await(file.list_children(dir))

	for child in children do
		print('"' .. dir .. "/" .. child:get_basename() .. '"')
	end
end

async_run(function()
	cat(path)
	save(path, "Hello, world!")
	cat(path)

	print("----------------------------")

	ls(os.getenv("HOME") .. "/Desktop")

	print("----------------------------")

	local path2 = "/tmp/test2.txt"
	touch(path2)
	save(path2, "FooBar")
	cat(path2)

	return loop:quit()
end)

loop:run()

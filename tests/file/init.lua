local lgi  = require("lgi")
local Gio  = lgi.Gio
local GLib = lgi.GLib

local loop = GLib.MainLoop()

local file = require("extrautils.file")

local tmp_path = os.tmpname()
do
	local f = io.open(tmp_path, "w+")

	if not f then
		error(("ERROR: Could not open tmpfile '%s'!"):format(tmp_path))
	end

	pcall(function()
		f:write("Hello, world!\n")
	end)

	f:close()
end

local Tester, Testcase
do
	local testing = require("extrautils.testing")
	Tester, Testcase = testing.Tester, testing.Testcase
end

do
	local tester = Tester("Testing asynchronous file reading...")

	tester:add_case(Testcase(function()
		file.read_async(tmp_path, function(success, content)
			print(("success = %s\ncontent = '%s'"):format(success, content))

			loop:quit()
		end)

		loop:run()
	end, false))

	tester:run()
end

do
	local tester = Tester("Testing asynchronous file writing...")

	tester:add_case(Testcase(function()
		file.write_async(tmp_path, "Foo bar!\n", function(success)
			print(("success = %s"):format(success))

			--- You should (obviously) not do synchronous file IO in an async-enabled context,
			--- but this is just for testing that async writing works, so it's OK here.
			local f = io.open(tmp_path, "r")
			if f then
				print(("content = '%s'"):format(f:read("a*")))
				f:close()
			end

			loop:quit()
		end)

		loop:run()
	end, false))

	tester:run()
end

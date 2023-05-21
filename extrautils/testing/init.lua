local write = io.write

local extrautils_table = require("extrautils.table")

local class = require("extrautils.class")

---@class AwesomeExtrautils.testing : AwesomeExtrautils.Table
local testing = extrautils_table.create()

local function print_bold(text)
	print("\027[1m" .. tostring(text) .. "\027[0m")
end

local stroke = "--------------------------------------------------------------"

---@class AwesomeExtrautils.testing.Testcase : AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.testing.Testcase.__class
---@field callback fun()
---@field invert boolean
---@field run fun(self: AwesomeExtrautils.testing.Testcase)

---@class AwesomeExtrautils.testing.Testcase.__class : AwesomeExtrautils.class.Class
---@operator call(fun(), boolean): AwesomeExtrautils.testing.Testcase
---@field __init fun(self: AwesomeExtrautils.testing.Testcase, callback: fun(), invert?: boolean): AwesomeExtrautils.testing.Testcase
---@field __parent AwesomeExtrautils.class.Class
---@field run fun(self: AwesomeExtrautils.testing.Testcase)
testing.Testcase = class.create("extrautils.testing.Testcase", {
	---@param self AwesomeExtrautils.testing.Testcase
	---@param callback fun() A function whose errors will be caught
	---@param invert? boolean If true, the testcase will expect `callback` to fail; a successfull execution will be considered a failure instead
	__init = function(self, callback, invert)
		self.invert = (invert ~= nil) and (invert) or false
		self.callback = callback
	end,

	---@param self AwesomeExtrautils.testing.Testcase
	run = function(self)
		local _success, msg = pcall(self.callback)

		local success
		if self.invert then
			success = not _success
		else
			success = _success
		end

		if success then
			print("\027[1;32mSUCCESS!\027[0m")
		else
			print("\027[1;31mFAILURE:\027[0m " .. tostring(msg))
		end

		return success, msg
	end
})

---@class AwesomeExtrautils.testing.TesterObject : AwesomeExtrautils.class.Object
---@field __base AwesomeExtrautils.testing.Tester
---@field cases AwesomeExtrautils.testing.Testcase[]
---@field title string A title, like "Testing whether this-and-that works...". Defaults to `"Running testcases"`.
---@field add_case fun(self: AwesomeExtrautils.testing.TesterObject, case: AwesomeExtrautils.testing.Testcase)
---@field run fun(self: AwesomeExtrautils.testing.TesterObject)

---@class AwesomeExtrautils.testing.Tester : AwesomeExtrautils.class.Class
---@operator call(string?): AwesomeExtrautils.testing.TesterObject
---@field __parent AwesomeExtrautils.class.Class
---@field add_case fun(self: AwesomeExtrautils.testing.TesterObject, case: AwesomeExtrautils.testing.Testcase)
---@field run fun(self: AwesomeExtrautils.testing.TesterObject)
testing.Tester = class.create("extrautils.testing.Tester", {
	---@param self AwesomeExtrautils.testing.TesterObject
	---@param title? string
	__init = function(self, title)
		self.cases = {}
		self.title = title or "Running testcases"
	end,

	---@param self AwesomeExtrautils.testing.TesterObject
	---@param case AwesomeExtrautils.testing.Testcase
	add_case = function(self, case)
		self.cases[#self.cases+1] = case
	end,

	---@param self AwesomeExtrautils.testing.TesterObject
	run = function(self)
		local error_counter = 0

		print_bold(stroke)
		print_bold(self.title)

		for count, case in ipairs(self.cases) do
			write((" \027[1m-->\027[0m Running tescase \027[1;34m#%d\027[0m... "):format(count))
			local success = case:run()

			if not success then
				error_counter = error_counter + 1
			end
		end

		print_bold("Done!")
		print_bold(stroke)
		print()

		return (error_counter <= 0), error_counter
	end,
})

return testing

local pcall        = pcall
local xpcall       = xpcall
local error        = error
local select       = select
local setmetatable = setmetatable
local coroutine = coroutine

local traceback = debug.traceback

local class            = require("extrautils.class")
local extrautils_table = require("extrautils.table")
local pack, unpack
do
	local compat = require("extrautils.compat")
	pack, unpack = compat.pack, compat.unpack
end

local lgi  = require("lgi")
local Gio  = lgi.Gio
local GLib = lgi.GLib

local async_start = Gio.Async.start

---@class AwesomeExtrautils.asyncio : AwesomeExtrautils.Table
local asyncio = extrautils_table.create()

local function try(fn)
	local success = xpcall(function()
		return fn()
	end, function(err)
		print(debug.traceback("\027[1;31mERROR in " .. tostring(err) .. "\027[0m"))
	end)

	return success
end

---@class AwesomeExtrautils.asyncio.__base
---@field run fun(self: AwesomeExtrautils.asyncio.Task, callback?: fun(self: AwesomeExtrautils.asyncio.Task))
---@field is_dead fun(self: AwesomeExtrautils.asyncio.Task): boolean
---@field run_until_finished fun(self: AwesomeExtrautils.asyncio.Task, callback?: fun(self: AwesomeExtrautils.asyncio.Task))
---@field resume fun(self: AwesomeExtrautils.asyncio.Task): boolean, ...
---@field was_run boolean

---@class AwesomeExtrautils.asyncio.Task : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.asyncio.Task.__class
---@field coroutine thread
---@field args table<integer, any>
---@field args_length integer

---@class AwesomeExtrautils.asyncio.Task.__class : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Class
---@operator call(function): AwesomeExtrautils.asyncio.Task
---@overload fun(fn: function, ...: any): AwesomeExtrautils.asyncio.Task
asyncio.Task = class.create("asyncio.Task", {
	---@param self AwesomeExtrautils.asyncio.Task
	---@param fn function
	__init = function(self, fn, ...)
		self.coroutine = coroutine.create(fn)
		self.args = pack(...)
		self.args_length = select("#", ...)
		self.was_run = false
	end,

	is_dead = function(self)
		return coroutine.status(self.coroutine) == "dead"
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	---@return boolean, ...
	resume = function(self)
		if self:is_dead() then
			return false
		end

		return true, coroutine.resume(self.coroutine, unpack(self.args, 1, self.args_length))
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	run = function(self, callback)
		if self.was_run then
			print("NOPE!")
			return
		end

		self.was_run = true

		return Gio.Async.start(function()
			print("Executed Task.run()")
			self:resume()

			if callback then
				callback(self)
			end
		end)()
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	run_until_finished = function(self, callback)
		if self.was_run then
			print("NOPE!")
			return
		end

		self.was_run = true

		return Gio.Async.start(function()
			print("Executed Task.run_until_finished()")

			while not self:is_dead() do
				print("Resuming...")
				self:resume()
			end

			if callback then
				callback(self)
			end
		end)()
	end,
})

---@alias AwesomeExtrautils.asyncio.AsyncFunction fun(...): AwesomeExtrautils.asyncio.Task

--- Create a new asynchronous function. An asynchronous function is a function that,
--- when executed, will return a new `asyncio.Thread` instance. Any arguments passed
--- into an asynchronous function get passed to the `asyncio.Thread` constructor and
--- stored inside the object instance. Each time the coroutine stored within the
--- `asyncio.Thread` gets resumes, it will be passed the arguments again.
---
--- ---
---
---@param fn function
---@return AwesomeExtrautils.asyncio.AsyncFunction
function asyncio.async(fn)
	return function(...)
		return asyncio.Task(fn, ...)
	end
end

function asyncio.async_run(fn, ...)
	local task = asyncio.async(fn)(...)

	task:run()
end

---@alias AwesomeExtrautils.asyncio.AsyncResult fun(callback: fun(success: boolean, ...))

--- Await a `asyncio.Thread`'s completion. This will pause the calling `asyncio.Thread`
--- until the `asyncio.Thread` passed to `asyncio.await` has been completed.
---
--- ---
---
---@param task AwesomeExtrautils.asyncio.Task
function asyncio.await(task)
	local caller = coroutine.running()

	task:run_until_finished(function(self)
		try(function()
			if (not caller) or (coroutine.status(caller) == "dead") then
				return
			end

			print("Resuming from finished await() call...")
			coroutine.resume(caller)
		end)
	end)

	print("Yielding from await() call..")
	return coroutine.yield()
end

---@param timeout_seconds number
asyncio.sleep = asyncio.async(function(timeout_seconds)
	local timeout_ms = timeout_seconds * 1000

	local caller = coroutine.running()

	GLib.timeout_add(0, timeout_ms, function()
		coroutine.resume(caller)
	end)

	return coroutine.yield()
end)

--[===[
---comment
---@param fn fun(..., callback: fun(...))
---@param no_explicit_success_param? boolean
---@return fun(...): AwesomeExtrautils.asyncio.AsyncResult
function asyncio.wrap(fn, no_explicit_success_param)
	return function(...)
		local args = pack(...)
		local args_len = select("#", ...) + 1

		return function(callback)
			--local _callback = callback
			--callback = function(...)
			--	print("\027[1;34mINFO:\027[0m Running callback!")
			--	print("args:", ...)
			--	return _callback(...)
			--end

			return try(function()
				args[args_len] = (no_explicit_success_param == false) and callback or function(...)
					return callback(true, ...)
				end

				fn(unpack(args, 1, args_len))
			end)
		end
	end
end

do
	local success, awful = pcall(require, "awful")

	if not success then
		goto no_awesome
	end

	local easy_async = awful.spawn.easy_async

	asyncio.spawn = asyncio.wrap(easy_async)

	local user_shell = os.getenv("SHELL")
	asyncio.spawn_with_user_shell = asyncio.wrap(function(cmd, callback)
		easy_async({ user_shell, "-c", cmd }, callback)
	end)

	asyncio.spawn_with_posix_shell = asyncio.wrap(function(cmd, callback)
		easy_async({ "sh", "-c", cmd }, callback)
	end)

	asyncio.spawn_with_bash = asyncio.wrap(function(cmd, callback)
		easy_async({ "bash", "-c", cmd }, callback)
	end)

	::no_awesome::
end
--]===]

return asyncio

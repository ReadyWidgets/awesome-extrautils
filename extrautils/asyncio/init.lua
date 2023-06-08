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

---@class AwesomeExtrautils.asyncio : AwesomeExtrautils.table.Table
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
---@field start fun(self: AwesomeExtrautils.asyncio.Task): ...
---@field try_resume_caller fun(self: AwesomeExtrautils.asyncio.Task, results: table<integer, any>)

---@class AwesomeExtrautils.asyncio.Task : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.asyncio.Task.__class
---@field coroutine thread
---@field caller thread
---@field args table<integer, any>
---@field args_length integer

---@class AwesomeExtrautils.asyncio.Task.__class : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Class
---@operator call(function): AwesomeExtrautils.asyncio.Task
---@overload fun(fn: function, ...: any): AwesomeExtrautils.asyncio.Task
asyncio.Task = class.create("asyncio.Task", {
	---@param self AwesomeExtrautils.asyncio.Task
	---@param fn function
	__init = function(self, fn, ...)
		self.coroutine = coroutine.create(function(...)
			local results = pack(fn(...))

			self:try_resume_caller(results)
		end)
		self.caller = coroutine.running()
		self.args = pack(...)
		self.args_length = select("#", ...)
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	---@return ...
	start = function(self)
		return coroutine.resume(self.coroutine, unpack(self.args, 1, self.args_length))
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	---@param results table<integer, any>
	try_resume_caller = function(self, results)
		if self.caller and (coroutine.status(self.caller) == "suspended") then
			coroutine.resume(self.caller, unpack(results))
		end
	end,
})

---@alias AwesomeExtrautils.asyncio.AsnycFunctionWithCallback fun(callback: fun(...))

---@alias AwesomeExtrautils.asyncio.AsyncFunction fun(...): AwesomeExtrautils.asyncio.Task

--- Create a new asynchronous function. An asynchronous function is a function that,
--- when executed, will return a new `asyncio.Task` instance. Any arguments passed
--- into an asynchronous function get passed to the `asyncio.Task` constructor and
--- stored inside the object instance. Each time the coroutine stored within the
--- `asyncio.Task` gets resumes, it will be passed the arguments again.
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

---@alias AwesomeExtrautils.asyncio.AsyncResult fun(callback: fun(success: boolean, ...))

--local __await_counter = 0

--- Await a `asyncio.Task`'s completion. This will pause the calling `asyncio.Task`
--- until the `asyncio.Task` passed to `asyncio.await` has been completed.
---
--- ---
---
---@param task AwesomeExtrautils.asyncio.AsnycFunctionWithCallback|AwesomeExtrautils.asyncio.Task
function asyncio.await(task)
	local caller = coroutine.running()


	if type(task) == "function" then
		async_start(task)(function(...)
			coroutine.resume(caller, ...)
		end)
	else
		async_start(function()
			coroutine.resume(caller, task:start())
		end)()
	end

	return coroutine.yield(task)
end

---@param tasks (AwesomeExtrautils.asyncio.AsnycFunctionWithCallback|AwesomeExtrautils.asyncio.Task)[]
function asyncio.await_all(tasks)
	local caller = coroutine.running()

	local results = {}
	local task_counter = #tasks

	for _, task in ipairs(tasks) do
		if type(task) == "function" then
			async_start(task)(function(...)
				task_counter = task_counter - 1
				print("task_counter = " .. tostring(task_counter))
				results[#results+1] = pack(...)

				if task_counter == 0 then
					coroutine.resume(caller, ...)
				end
			end)
		else
			asyncio.run(task, caller)
		end
	end

	--print("Yielding from await() call..")
	return coroutine.yield()
end

--- Start executing a task
---@param task AwesomeExtrautils.asyncio.Task
---@param caller? thread
function asyncio.run(task, caller)
	local results = pack(task:start())

	if caller then
		print("Resuming caller \"" .. tostring(caller) .. "\" now...")
		return coroutine.resume(caller, unpack(results))
	end
end

--- Create a Task and run it immediatley
---@param fn fun(...)
---@param ... unknown
function asyncio.async_run(fn, ...)
	local task = asyncio.Task(fn, ...)

	return asyncio.run(task)
end

---@param timeout_seconds number
function asyncio.sleep(timeout_seconds)
	local timeout_ms = timeout_seconds * 1000

	return function(callback)
		GLib.timeout_add(0, timeout_ms, function()
			callback()
		end)
	end
end

---@param fn fun(..., callback: fun(...))
---@param explicit_success_param? boolean
---@return fun(...): AwesomeExtrautils.asyncio.AsyncResult
function asyncio.wrap(fn, explicit_success_param)
	return function(...)
		local args = pack(...)
		local args_len = select("#", ...) + 1

		return function(callback)
			return try(function()
				args[args_len] = explicit_success_param and (function(...)
					return callback(true, ...)
				end) or callback

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

--[===[
do
	local loop = GLib.MainLoop() ---@type lgi.GLib.MainLoop

	local task_count = 0

	local task = asyncio.async(function(msg)
		task_count = task_count + 1

		print("Start!")

		asyncio.await(asyncio.sleep(1))

		print("msg = \"" .. tostring(msg) .. "\"")

		asyncio.await_all({
			asyncio.sleep(1),
			asyncio.sleep(1),
			asyncio.sleep(1),
		})

		print("End!")

		task_count = task_count - 1

		if task_count == 0 then
			print("No more tasks queued up - exiting!")
			loop:quit()
		end
	end)

	--asyncio.run(task())
	asyncio.run(task("Foo"))
	--asyncio.run(task("Bar"))

	loop:run()
end
--]===]

return asyncio

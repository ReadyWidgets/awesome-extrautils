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
---@field resume fun(self: AwesomeExtrautils.asyncio.Task): false|true, ...

---@class AwesomeExtrautils.asyncio.Task : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.asyncio.Task.__class
---@field coroutine thread
---@field args table<integer, any>
---@field args_length integer

---@class AwesomeExtrautils.asyncio.Task.__class : AwesomeExtrautils.asyncio.__base, AwesomeExtrautils.class.Class
---@operator call(function): AwesomeExtrautils.asyncio.Task
---@overload fun(fn: function, ...: any): AwesomeExtrautils.asyncio.Task
asyncio.Thread = class.create("asyncio.Thread", {
	---@param self AwesomeExtrautils.asyncio.Task
	---@param fn function
	__init = function(self, fn, ...)
		self.coroutine = coroutine.create(fn)
		self.args = pack(...)
		self.args_length = select("#", ...)
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	---@return false|true, ...
	resume = function(self)
		if coroutine.status(self.coroutine) == "dead" then
			return false
		end

		return true, coroutine.resume(self.coroutine, unpack(self.args, 1, self.args_length))
	end,

	---@param self AwesomeExtrautils.asyncio.Task
	run = function(self, callback)
		return Gio.Async.start(function()
			coroutine.resume(self.coroutine, unpack(self.args, 1, self.args_length))

			if callback then
				callback(self)
			end
		end)()
	end,
})

---@param fn function
---@return fun(...): AwesomeExtrautils.asyncio.Task, ...
function asyncio.async(fn)
	return function(...)
		return asyncio.Thread(fn, ...)
	end
end

function asyncio.async_run(fn, ...)
	local task = asyncio.async(fn)(...)

	return task:run()
end

---@alias AwesomeExtrautils.asyncio.AsyncResult fun(callback: fun(success: boolean, ...))

--- Await an async functions completion.
---
---@param task AwesomeExtrautils.asyncio.Task
function asyncio.await(task)
	task:run(function(self)
		--if not success then
		--	print(debug.traceback("ERROR: Something went wrong!"))
		--	return
		--end

		try(function()
			self:resume()
		end)
	end)

	return coroutine.yield()
end

---@param timeout_seconds number
---@param callback fun()
---@return nil
---@overload fun(timeout_seconds: number): AwesomeExtrautils.asyncio.AsyncResult
function asyncio.sleep(timeout_seconds, callback)
	local timeout_ms = timeout_seconds * 1000

	if callback then
		GLib.timeout_add(0, timeout_ms, callback)
		return
	end

	return function(cb)
		GLib.timeout_add(0, timeout_ms, function()
			cb(true)
		end)
	end
end

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

return asyncio

local module_dir_name = "awesome-extrautils"

---@type fun(path?: string): AwesomeExtrautils
return setmetatable({}, {
	__index = function(self, key)
		error([[
<b>ERROR</b>: You attempted to directly index into ]] .. module_dir_name .. [[.

Loading ]] .. module_dir_name .. [[ using `require()` does not return a table. Instead,
it returns a function that you need to call, optionally with. This is done to allow you to install it
in any directory, rather than a hard-coded one.
]])
	end,

	__call = function(_, script_dir)
		if not script_dir then
			script_dir = debug
				.getinfo(2, "S")
				.source
				:sub(2)
				:match("(.*/)")
		end

		if not script_dir then
			error([[
<b>ERROR</b>: Could not find install directory of ]] .. module_dir_name .. [[.
Suggestion: You can try to pass the path directly to this module:

	local extrautils = require(<i>Your require path here<i>)(<i>Your path (with slashes, not dots) here</i>)

If you cloned ]] .. module_dir_name .. [[ into the default config directory for awesome:

	local extrautils = require("]] .. module_dir_name .. [[")(os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/awesome/]] .. module_dir_name .. [[")
]])
		end

		local module_dir = script_dir .. "/extrautils"

		package.path = package.path .. ";" ..
			module_dir .. "?/init.lua;" ..
			module_dir .. "?.lua"

		return require("extrautils")
	end
})

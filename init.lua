local module_directory_name = ((...) or "awesome-extrautils"):gsub("%.", "/")

---@type fun(path?: string): AwesomeExtrautils
return setmetatable({}, {
	__index = function(self, key)
		error([[
<b>ERROR</b>: You attempted to directly index into ]] .. module_directory_name .. [[.

Loading ]] .. module_directory_name .. [[ using `require()` does not return a table. Instead, it returns a function
that you need to call, optionally with. This is done to allow you to install it
in any directory, rather than a hard-coded one.
]])
	end,

	__call = function(_, script_dir)
		--- If you manually add the correct path to `package.path`, it will be used.
		do
			local success, extrautils = pcall(require, "extrautils")

			if success then
				return extrautils
			end
		end

		if (module_directory_name) and (not script_dir) then
			local pwd = io.popen("pwd")

			if pwd then
				local current_directory = pwd
					:read("*a")
					:gsub("\n$", "")

				pwd:close()

				script_dir = current_directory .. "/" .. module_directory_name
			end
		end

		if not script_dir then
			script_dir = debug
				.getinfo(2, "S")
				.source
				:sub(2)
				:match("(.*/)")
		end

		if not script_dir then
			error([[
<b>ERROR</b>: Could not find install directory of ]] .. module_directory_name .. [[.
Suggestion: You can try to pass the path directly to this module:

	local extrautils = require(<i>Your require path here<i>)(<i>Your path (with slashes, not dots) here</i>)

If you cloned ]] .. module_directory_name .. [[ into the default config directory for awesome:

	local extrautils = require("]] .. module_directory_name .. [[")(os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/awesome/]] .. module_directory_name .. [[")
]])
		end

		package.path = package.path .. ";" ..
			script_dir .. "/?/init.lua;" ..
			script_dir .. "/?.lua"

		return require("extrautils")
	end
})

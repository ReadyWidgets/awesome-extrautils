local sub_modules = {
	--"apps",
	--"awesome",
	--"capi",
	"class",
	--"compat",
	"file",
	--"math",
	--"string",
	--"table",
	--"testing",
	--"verification",
}

local function print_heading(heading)
	print("\027[1;7m--------------------------------------------------------------\027[0m")
	local padding = (" "):rep(28 - (#heading/2))
	print(("\027[1;7m---%s%s%s%s---\027[0m"):format(padding, heading:upper(), padding, ((#heading % 2) == 0) and "" or " "))
	print("\027[1;7m--------------------------------------------------------------\027[0m")
	print()
end

for _, module_name in ipairs(sub_modules) do
	print_heading(module_name)
	pcall(require, "tests." .. module_name)
end

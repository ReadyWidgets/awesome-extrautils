local extrautils_table = require("extrautils.table")
local class = require("extrautils.class")

---@class AwesomeExtrautils.color : AwesomeExtrautils.Table
local color = extrautils_table.create()

color.Color = class.create("extrautils.color.Color", {
	init = function(self)
		error("ERROR: This class is a placeholder, it has not yet been implemented properly!")
		self.r = 0
		self.g = 0
		self.b = 0
		self.a = 0
	end,

	from_rgb = function(cls, r, g, b, a)
		local self = color.Color()

		return self
	end,

	from_hsl = function(cls, h, s, l, a)
		local self = color.Color()

		return self
	end,

	from_hsv = function(cls, h, s, v, a)
		local self = color.Color()

		return self
	end,

	to_rgb = function(self)
		local r, g, b, a = 0, 0, 0, 0

		return {
			r = r,
			g = g,
			b = b,
			a = a,
		}
	end,

	to_hsl = function(self)
		local h, s, l, a = 0, 0, 0, 0

		return {
			h = h,
			s = s,
			l = l,
			a = a,
		}
	end,

	to_hsv = function(self)
		local h, s, v, a = 0, 0, 0, 0

		return {
			h = h,
			s = s,
			v = v,
			a = a,
		}
	end,
})

return color

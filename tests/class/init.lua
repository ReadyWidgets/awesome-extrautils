local class = require("extrautils.class")

local Tester, Testcase
do
	local testing = require("extrautils.testing")
	Tester, Testcase = testing.Tester, testing.Testcase
end

do
	local tester = Tester("Testing class creation...")
	tester:add_case(Testcase(function() class.create()          end, true )) -- Misses a name
	tester:add_case(Testcase(function() class.create("Foo")     end, true )) -- Misses a base
	tester:add_case(Testcase(function() class.create("Foo", {}) end, false)) -- Good!
	tester:run()
end

do
	local tester = Tester("Testing class and instance methods...")
	tester:add_case(Testcase(function()
		local Foo

		Foo = class.create("Foo", {
			__init = function(self)
				self.n = 0
			end,

			inc = function(self)
				self.n = self.n + 1
			end
		})
	end, false))
	tester:add_case(Testcase(function()
		local Foo

		Foo = class.create("Foo", {
			__init = function(self)
				self.n = 0
			end,

			inc = function(self)
				self.n = self.n + 1
			end
		})

		Foo.inc() -- Nope! `inc` is an instance method!
	end, true))
	tester:add_case(Testcase(function()
		local Foo

		Foo = class.create("Foo", {
			__init = function(self)
				self.n = 0
			end,

			inc = function(self)
				self.n = self.n + 1
			end
		})

		local my_foo = Foo()
		my_foo:inc()
	end, false))
	tester:add_case(Testcase(function()
		local Foo

		Foo = class.create("Foo", {
			__init = function(self)
				self.n = 0
			end,

			from_table = function(cls, tb)
				return setmetatable(tb, cls.__base)
			end,

			get_n = function(self)
				return self.n
			end
		})

		local my_foo = Foo:from_table({ n = 5 })
		assert(my_foo:get_n() == 5)
		assert(Foo.n == nil)
	end, false))
	tester:run()
end

do
	local tester = Tester("Testing inheritance...")
	tester:add_case(Testcase(function()
		local Foo, Bar

		Foo = class.create("Foo", {})
		Bar = class.create("Bar", {}, Foo)
	end, false))
	tester:add_case(Testcase(function()
		local Foo, Bar

		Foo = class.create("Foo", {
			__init = function(self)
				self.n = 0
			end,

			inc = function(self)
				self.n = self.n + 1
			end
		})
		Bar = class.create("Bar", {
			dec = function(self)
				self.n = self.n - 1
			end
		}, Foo)

		assert(Foo.inc, "`Foo` didn't define `:inc()`, even though it should")
		assert(not Foo.dec, "`Foo` defined `:dec()`, even though it should NOT")
		assert(Bar.inc, "`Bar` didn't define `:inc()`, even though it should")
		assert(Bar.dec, "`Bar` didn't define `:dec()`, even though it should")
		local my_foo = Foo()
		local my_bar = Bar()
		assert(my_foo.inc, "`my_foo` didn't define `:inc()`, even though it should")
		assert(not my_foo.dec, "`my_foo` defined `:dec()`, even though it should NOT")
		assert(my_bar.inc, "`my_bar` didn't define `:inc()`, even though it should")
		assert(my_bar.dec, "`my_bar` didn't define `:dec()`, even though it should")

		my_foo:inc()
		my_foo:inc()
		my_foo:inc()
		assert(my_foo.n == 3)
		assert(my_bar.n == 0)

		my_bar:inc()
		my_bar:inc()
		my_bar:inc()
		my_bar:dec()
		my_bar:dec()
		assert(my_foo.n == 3)
		assert(my_bar.n == 1)
		assert(not pcall(function() my_foo:dec() end)) -- Calling `:dec()` on `my_foo` SHOULD fail
	end, false))
	tester:run()
end

print("All tests for module 'extrautils.class' ran successfully!")

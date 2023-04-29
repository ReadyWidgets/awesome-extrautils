# Awesome Extrautils

A library providing many utility functions for use with the Awesome window manager, which would not warrant their own repository.

# Compatibility

This library is designed for the Git master branch of Awesome. If you are stil using v4.3, you are highly encuraged to upgrade.

Additionally, this repository is currently only tested with Awesome compiled agains LuaJIT. It should also work with Lua 5.3, but it probably won't work for regular 5.1 (not that you should use a version released in Feb. 2006(!) with a bleeding-edge branch of Awesome (or really, at all), but still).

# Installation

First, clone this repositry by running the following in your terminal (`bash` or `zsh`):

```sh
git clone 'https://github.com/ReadyWidgets/awesome-extrautils' "${XDG_CONFIG_HOME:-$HOME/.config}/awesome/awesome-extrautils"
```

Next, edit your `rc.lua` to load Extrautils:

```lua
----------------------------------------------------------
--- File: "${XDG_CONFIG_HOME:-$HOME/.config}/awesome/" ---
----------------------------------------------------------

--- Load Extrautils; note the brackets at the end, you can pass a
--- custom path if you have them stored elsewhere.
local extrautils = require("extrautils")()
```

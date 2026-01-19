-- The items in the game.

infdev = infdev or {}

local mod_path = core.get_modpath(core.get_current_modname())

dofile(mod_path .. "/tools.lua")

core.register_craftitem(":infdev:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = { stick = 1, flammable = 2 },
})

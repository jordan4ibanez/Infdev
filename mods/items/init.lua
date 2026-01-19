-- The items in the game.

infdev = infdev or {}

local mod_path = core.get_modpath(core.get_current_modname())

dofile(mod_path .. "/tools.lua")
dofile(mod_path .. "/crafting.lua")

core.register_craftitem(":infdev:stick", {
function infdev.register_craftitem(name, def)
	name = ":infdev:" .. name
	core.register_craftitem(name, def)
end
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = { stick = 1, flammable = 2 },
})

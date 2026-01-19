-- The items in the game.

infdev = infdev or {}

local mod_path = core.get_modpath(core.get_current_modname())

dofile(mod_path .. "/tools.lua")
dofile(mod_path .. "/crafting.lua")

function infdev.register_craftitem(name, def)
	name = ":infdev:" .. name
	core.register_craftitem(name, def)
end

infdev.register_craftitem("stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = { stick = 1, flammable = 2 },
})

infdev.register_craftitem("coal", {
	description = "Coal",
	inventory_image = "default_coal_lump.png",
	groups = { coal = 1, flammable = 1 }
})

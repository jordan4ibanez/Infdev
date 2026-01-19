-- The items in the game.

infdev = infdev or {}

local mod_path = core.get_modpath(core.get_current_modname())

dofile(mod_path .. "/tools.lua")
dofile(mod_path .. "/crafting.lua")
dofile(mod_path .. "/cooking.lua")

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
	inventory_image = "default_coal_lump.png^[colorize:black:170",
})

infdev.register_craftitem("iron_ingot", {
	description = "Iron Ingot",
	inventory_image = "default_steel_ingot.png"
})

infdev.register_craftitem("gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "default_gold_ingot.png"
})

infdev.register_craftitem("diamond", {
	description = "Diamond",
	inventory_image = "default_diamond.png"
})

infdev.register_craftitem("ruby", {
	description = "Ruby",
	inventory_image = "default_diamond.png^[colorize:red:190"
})

infdev.register_craftitem("sapphire", {
	description = "Sapphire",
	inventory_image = "default_diamond.png^[colorize:blue:190"
})

infdev.register_craftitem("emerald", {
	description = "Emerald",
	inventory_image = "default_diamond.png^[colorize:lime:190"
})

infdev.register_craftitem("lapis", {
	description = "Lapis Lazuli",
	inventory_image = "((default_coal_lump.png^[invert:rgb)^[contrast:100:-70)^[colorize:darkblue:150",
})


infdev.register_craftitem("moonstone", {
	description = "Moonstone",
	inventory_image = "((default_coal_lump.png^[invert:rgb)^[contrast:100:-70)^[colorize:lightblue:200",
})

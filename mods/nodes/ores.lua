infdev.register_node("coal_ore", {
	tiles = { "default_stone.png^default_mineral_coal.png" },
	groups = { [infdev.groups.stone] = 2 },
	drop = "infdev:coal"
})

infdev.register_node("iron_ore", {
	tiles = { "default_stone.png^default_mineral_iron.png" },
	groups = { [infdev.groups.stone] = 2 }
})

infdev.register_node("gold_ore", {
	tiles = { "default_stone.png^default_mineral_gold.png" },
	groups = { [infdev.groups.stone] = 3 }
})

infdev.register_node("diamond_ore", {
	tiles = { "default_stone.png^default_mineral_diamond.png" },
	groups = { [infdev.groups.stone] = 4 },
	drop = "infdev:diamond"
})

infdev.register_node("ruby_ore", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:red:190)" },
	groups = { [infdev.groups.stone] = 5 },
	drop = "infdev:ruby"
})

infdev.register_node("sapphire_ore", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:blue:190)" },
	groups = { [infdev.groups.stone] = 6 },
	drop = "infdev:sapphire"
})

infdev.register_node("emerald_ore", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:lime:190)" },
	groups = { [infdev.groups.stone] = 7 },
	drop = "infdev:emerald"
})

infdev.register_node("lapis_ore", {
	tiles = { "default_stone.png^((default_mineral_coal.png^[invert:rgb^[contrast:100:-70)^[colorize:darkblue:150)" },
	groups = { [infdev.groups.stone] = 8 },
	drop = "infdev:lapis"
})

infdev.register_node("moonstone_ore", {
	tiles = { "default_stone.png^(default_mineral_iron.png^[colorize:lightblue:200)" },
	groups = { [infdev.groups.stone] = 9 },
	drop = "infdev:moonstone"
})

-- The items in the game.

infdev = infdev or {}


core.register_craftitem(":infdev:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = { stick = 1, flammable = 2 },
})

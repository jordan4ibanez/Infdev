-- Regular furnace cooking recipes.

infdev = infdev or {}

---Register a cooking recipe.
---@param input string
---@param output string
---@param time number?
function infdev.register_cook(input, output, time)
	local new_input = input
	if (new_input:sub(1, string.len("group:")) ~= "group:") then
		new_input = "infdev:" .. new_input
	end
	local new_output = output
	if (new_output:sub(1, string.len("group:")) ~= "group:") then
		new_output = "infdev:" .. new_output
	else
		error("Cooking output cannot be a group.")
	end

	core.register_craft({
		type = "cooking",
		output = new_output,
		recipe = new_input,
	})
end

infdev.register_cook("sand", "glass")
infdev.register_cook("clay", "brick")
infdev.register_cook("cobblestone", "stone")
infdev.register_cook("group:tree", "charcoal")
infdev.register_cook("uncured_fireclay_brick", "cured_fireclay_brick")
infdev.register_cook("iron_ore", "iron_ingot")
infdev.register_cook("gold_ore", "gold_ingot")

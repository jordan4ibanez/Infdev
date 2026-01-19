-- All the item/node groups are stored here.

infdev = infdev or {}

---The groups that exist in the game.
infdev.groups = {
	tree = "tree",
	wood = "wood",
	planks = "planks",
	stone = "stone",
	cobblestone = "cobblestone",
	soil = "soil",
	sand = "sand",
	plant = "plant",
	farmland = "farmland",
	bedrock = "bedrock",
	liquid_source = "liquid_source",
	liquid_flow = "liquid_flow",
	water = "water"
}

---Turns an infdev.group into "group:whatever"
---@param input_group string
---@return string
function infdev.group_string(input_group)
	if (infdev.groups[input_group] == nil) then
		error("Group " .. input_group .. " does not exist.")
	end
	return "group:" .. input_group
end

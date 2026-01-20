-- Blast furnace upgrade recipes.

infdev = infdev or {}

local blast_recipes = {}

---Register a tool upgrade in the blast furnace.
---@param input string
---@param output string
function infdev.register_blast(input, output)
	if (blast_recipes[input] ~= nil) then
		error("Error: Tried to overwrite blast recipe " .. input .. " to " .. output)
	end
end

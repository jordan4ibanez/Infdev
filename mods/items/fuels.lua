-- All fuels are registered here.

infdev = infdev or {}

local string_group = infdev.string_group

---Simplify fuel registration.
---@param item string
---@param burn_time number
function infdev.register_fuel(item, burn_time)
	local new_item = item

	if (new_item:sub(1, string.len("group:")) ~= "group:") then
		new_item = "infdev:" .. new_item
	end

	core.register_craft({
		type = "fuel",
		recipe = new_item,
		burntime = burn_time,
	})
end

infdev.register_fuel("coal", 30)
infdev.register_fuel("charcoal", 25)

infdev.register_fuel(string_group(infdev.groups.tree), 20)
infdev.register_fuel(string_group(infdev.groups.planks), 10)
infdev.register_fuel(string_group(infdev.groups.stick), 3)

-- Trees that spawn on the terrain.

-- local treedef = {
-- 	axiom,          --string  initial tree axiom
-- 	rules_a,        --string  rules set A
-- 	rules_b,        --string  rules set B
-- 	rules_c,        --string  rules set C
-- 	rules_d,        --string  rules set D
-- 	trunk,          --string  trunk node name
-- 	leaves,         --string  leaves node name
-- 	leaves2,        --string  secondary leaves node name
-- 	leaves2_chance, --num     chance (0-100) to replace leaves with leaves2
-- 	angle,          --num     angle in deg
-- 	iterations,     --num     max # of iterations, usually 2 -5
-- 	random_level,   --num     factor to lower number of iterations, usually 0 - 3
-- 	trunk_type,     --string  single/double/crossed) type of trunk: 1 node,
-- 	--        2x2 nodes or 3x3 in cross shape
-- 	thin_branches,  --boolean true -> use thin (1 node) branches
-- 	fruit,          --string  fruit node name
-- 	fruit_chance,   --num     chance (0-100) to replace leaves with fruit node
-- 	seed,           --num     random seed, if no seed is provided, the engine will create one.
-- }


local oak_tree_medium_blueprint = "" ..
	-- Trunk, then reposition to build leaves.
	"TTTTT&&GGG^GG+GG--" ..

	-- First layer. (bottom squared)
	"Tfff-f-ffff+f+ffff-f-ffff+f+ffff^f&--" ..

	-- Second layer. (trimmed corners)
	"Gfff-G-ffff+f+ffff-f-ffff+f+Gfff^G&+G+G-" ..

	-- Third layer. (small squared)
	"ff+f+ff-f-ff^f&-" ..

	-- Top layer. (small trimmed)
	"Gf-G-ff+f+Gf"


local oak_tree_medium = {
	axiom = oak_tree_medium_blueprint,
	trunk = "infdev:stone",
	leaves = "infdev:sand",
	angle = 90,
	iterations = 1,
	random_level = 0,
	trunk_type = "single",
}



-- core.register_on_joinplayer(function(player, last_login)
-- 	local pos = player:get_pos()

-- 	local visual = vector.add(pos, 5)
-- 	visual.y = visual.y - 5

-- 	for x = -10, 10 do
-- 		for y = -10, 10 do
-- 			for z = -10, 10 do
-- 				core.remove_node(vector.add(visual, vector.new(x, y, z)))
-- 			end
-- 		end
-- 	end

-- 	core.spawn_tree(visual, oak_tree_medium)
-- end)

core.register_decoration({
	name = "infdev:oak_tree",
	deco_type = "lsystem",
	place_on = { "infdev:grass" },
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.002,
		spread = { x = 250, y = 250, z = 250 },
		seed = 2,
		octaves = 3,
		persist = 0.01,
		lacunarity = 5.0,
	},
	treedef = oak_tree_medium
})

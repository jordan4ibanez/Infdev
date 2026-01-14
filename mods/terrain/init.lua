-- Terrain generation.

--- @type number
local chunk_size = core.get_mapgen_chunksize()

--- This is the terrain generation entry point.
---@param minp number
---@param maxp number
---@param blockseed number
core.register_on_generated(function(minp, maxp, blockseed)
	print(minp, maxp, blockseed)
end)

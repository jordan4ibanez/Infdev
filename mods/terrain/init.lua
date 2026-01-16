-- Terrain generation entry point.

core.set_mapgen_setting("mg_flags", "nolight", true)

core.register_mapgen_script(
	core.get_modpath(core.get_current_modname()) .. "/mapgen.lua"
)

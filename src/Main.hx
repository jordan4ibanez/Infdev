package src;

import lua.Lua;

class Main {
	public static function main(): Void {
		Lua.print("Hello Infdev.");

		untyped __lua__('
		
		local path = core.get_modpath("infdev") .. "/models"

		local out_path = core.get_worldpath()

		local filename = "mcl_meshhand.b3d"
		
		-- First read the B3D
		local in_file = assert(io.open(path .. "/" .. filename, "rb"))
		local model = assert(modlib.b3d.read(in_file))
		in_file:close()
		-- Then write the glTF
		local out_file = io.open(out_path .. "/" .. filename .. ".gltf", "wb")
		model:write_gltf(out_file)
		out_file:close()		
		
		');
	};
}

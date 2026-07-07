# Model Sources

## Mesh hand:

mcl_meshhand.b3d -> infdev_hand.gltf

I made this a long time ago under CC0 and then it got put into Mineclone2. And then Crafter. And now I have turned it new again so everyone can enjoy it more.

https://codeberg.org/mineclonia/mineclonia/src/branch/main/mods/PLAYER/mcl_meshhand/models/mcl_meshhand.b3d

modlib was used to translate it to b3d. In fact I'll just show you the entire processes:

```haxe
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
```
package src;

import lua.Lua;

class Main {
	public static function main(): Void {
		Lua.print("Hello Infdev.");

		untyped __lua__('

core.register_chatcommand("floortestentityjump", {
    func = function(name)
	local player = core.get_player_by_name(name)
	local pos = player:get_pos()
	print(pos)
	for x = -100,100 do
		for z = -100,100 do
			core.set_node(vector.new(pos.x + x,pos.y,pos.z + z), {name = "infdev:cobblestone"})
		end
	end        

	for x = -100,100 do
		for z = -100,100 do
			if math.random() > 0.75 then
			core.set_node(vector.new(pos.x + x,pos.y+1,pos.z + z), {name = "infdev:cobblestone"})
	end
		end
	end        
    end,
})

		');
	};
}

package src.engine.entity.definition;

import lua.Table;
import src.engine.compilercode.LuaArray;

@:forward
abstract SelectionBox(Table<Int, Float>) from Table<Int, Float> to Table<Int, Float> {
	public inline function new(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float, ?rotates: Bool) {
		this = Table.create([x1, y1, z1, x2, y2, z2]);
	}
}

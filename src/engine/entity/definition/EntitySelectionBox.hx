package src.engine.entity.definition;

import haxe.extern.EitherType;
import lua.Table;

@:forward
abstract EntitySelectionBox(Table<Int, EitherType<Float, Bool>>) from Table<Int, EitherType<Float, Bool>> to Table<Int, EitherType<Float, Bool>> {
	public inline function new(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float, ?rotates: Bool) {
		this = Table.create([x1, y1, z1, x2, y2, z2]);
		this.rotates = rotates;
	}
}

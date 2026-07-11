package src.engine.vector;

import lua.Table;

abstract AdvancedVector3(Table<String, Float>) {
	public inline function new() {
		this = Table.create();
	}
}

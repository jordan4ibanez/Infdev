package src.engine.compilercode;

// This is AI generated to create automated type constraint checking.
// Basically this is making sure the lua string is the correct enum type.
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class EnumMacro {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();
		var valueExprs: Array<Expr> = [];
		for (field in fields) {
			switch (field.kind) {
				case FVar(_, _):
					var name = field.name;
					valueExprs.push(macro $v{name});
				default:
			}
		}
		fields.push({
			name: "all",
			doc: null,
			meta: [],
			access: [APublic, AStatic],
			kind: FVar(macro : Array<String>, macro $a{valueExprs}),
			pos: Context.currentPos()
		});
		fields.push({
			name: "isValid",
			doc: null,
			meta: [],
			access: [APublic, AStatic, AInline],
			kind: FFun({
				args: [{name: "val", type: macro : String}],
				ret: macro : Bool,
				expr: macro {return all.indexOf(val) != -1;}
			}),
			pos: Context.currentPos()
		});
		return fields;
	}
}
#end

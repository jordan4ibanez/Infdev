package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

// This is AI generated to create automated type constraint checking.
// This code adds special functions to enums.
class EnumMacro {
	public static function decorate(): Array<Field> {
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
			doc: "Get all entries in the enum as an array.",
			meta: [],
			access: [APublic, AStatic],
			kind: FProp("get", "null", macro : Array<String>),
			pos: Context.currentPos()
		});
		fields.push({
			name: "get_all",
			doc: null,
			meta: [],
			access: [APrivate, AStatic, AInline],
			kind: FFun({
				args: [],
				ret: macro : Array<String>,
				expr: macro {return $a{valueExprs};}
			}),
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

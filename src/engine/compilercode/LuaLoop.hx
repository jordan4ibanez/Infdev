package src.engine.compilercode;

import haxe.macro.Context;
import haxe.macro.Expr;

// This is AI generated.
// It took so long to get here.
// So many ideas were benchmarked.
class LuaLoop {
	/**
	 * Emits a raw, high-performance Lua generic for-loop.
	 * @param loopVarExpr The identifier or string name of your loop variable (e.g., i or "i")
	 * @param iteratorExpr The native iterator method call (e.g., area.iterP(min, max))
	 * @param body The block of Haxe code to execute inside the loop
	 */
	public static macro function nativeFor(loopVarExpr: Expr, iteratorExpr: Expr, body: Expr): Expr {
		// Extract the variable name whether they typed a string or a raw identifier.
		var loopVar: String = switch loopVarExpr.expr {
			case EConst(CIdent(name)): name; // Handled raw tokens like: i
			case EConst(CString(str, _)): str; // Handled backward compatibility strings: "i"
			default: Context.error("First argument must be a variable name or a string", loopVarExpr.pos);
		};

		var openStr = 'for ' + loopVar + ' in {0} do';

		// Create the Haxe expression for: var [loopVar] = untyped [loopVar];
		var varNameIdent = {expr: EConst(CIdent(loopVar)), pos: Context.currentPos()};
		// This shadows the underlying value.
		var injection = macro var $loopVar = untyped $varNameIdent - 1;

		// Combine the injection with the original loop body.
		var newBody = switch body.expr {
			case EBlock(exprs):
				// If it's a standard curly-brace block {}, slip it right at the front.
				exprs.unshift(injection);
				body;
			default:
				// If it's a single-line expression, wrap it into a block with the injection.
				{expr: EBlock([injection, body]), pos: body.pos};
		};

		return macro {
			untyped __lua__($v{openStr}, $iteratorExpr);
			$newBody;
			untyped __lua__("end");
		};
	}

	/**
	 * Cleanly breaks out of the current native Lua loop.
	 */
	public static macro function breakLoop(): Expr {
		return macro untyped __lua__("break");
	}

	/**
	 * Cleanly issues a native Lua return from inside the loop without tripping DCE syntax errors.
	 */
	public static macro function returnLoop(): Expr {
		return macro untyped __lua__("return");
	}
}

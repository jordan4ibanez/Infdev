package src.engine;

import lua.Lua;
import lua.Math;
import lua.Table;
import src.engine.compilercode.LuaLoop;
import src.engine.compilercode.LuaMap;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecButton;

/**
 * This class is a translation of https://github.com/luanti-org/luanti/blob/master/builtin/common/serialize.lua
 * Lua module to serialize values as Lua code.
 * From: https://github.com/appgurueu/modlib/blob/master/luon.lua
 * License: MIT
 * Modification: It automatically strips out userdata and thread data.
 */
// todo: 0 index this entire thing.

@:multiReturn
extern class PureDynamic {
	var first: Dynamic;
	var second: Dynamic;
}

@:final
abstract class Serialize {
	static var unsupported_types: Table<String, Bool>;

	// Build a "set" of Lua keywords. These can't be used as short key names.
	// See https://www.lua.org/manual/5.1/manual.html#2.1
	static var keywords: LuaMap<String, Bool>;

	static function assignTypes(): Void {
		var data = Table.create();
		data[cast "userdata"] = true;
		data[cast "thread"] = true;
		unsupported_types = data;

		keywords = [
			"and" => true, "break" => true, "do" => true, "else" => true, "elseif" => true,
			"end" => true, "false" => true, "for" => true, "function" => true, "if" => true,
			"in" => true, "local" => true, "nil" => true, "not" => true, "or" => true,
			"repeat" => true, "return" => true, "then" => true, "true" => true, "until" => true, "while" => true,
			"goto" => true // LuaJIT, Lua 5.2+
		];
	}

	// Userdata and thread can be used as a key and a value in lua tables so it must check for both.
	static function allowed_type(k: Dynamic, ?v: Dynamic): Bool {
		var a = unsupported_types[cast Lua.type(k)] == true;
		var b = unsupported_types[cast Lua.type(v)] == true;
		return !(a || b);
	}

	// Recursively counts occurrences of objects (non-primitives including strings) in a table.
	static function count_objects(value: Dynamic): Table<Dynamic, Dynamic> {
		var counts = Table.create();
		if (value == null) {
			// Early return for nil; tables can't contain nil
			return counts;
		}
		function count_values(val) {
			var type_ = Lua.type(val);
			if (type_ == "boolean" || type_ == "number") {
				return;
			}
			var count = counts[val];
			counts[val] = (count ?? 0) + 1;
			if (type_ == "table") {
				if (count == null) {
					LuaLoop.nativePairs(k, v, val, {
						// Skip it if it's not a supported type.
						if (allowed_type(k, v)) {
							count_values(k);
							count_values(v);
						}
					});
				}
			} else if (type_ != "string" && type_ != "function") {
				// Ignore unsupported types instead of erroring out.
				return;
			}
		}
		count_values(value);
		return counts;
	}

	static function quote(string: String): String {
		return untyped __lua__('string.format("%q", {0})', string);
	}

	static function dump_func(func): String {
		return untyped __lua__('string.format("loadstring(%q)", string.dump({0}))', func);
	}

	// Serializes Lua nil, booleans, numbers, strings, tables and even functions
	// Tables are referenced by reference, strings are referenced by value. Supports circular tables.
	static function serialize(value: Dynamic, write: (String) -> String): Null<String> {
		var reference = "1";
		var refnum = 1;
		// [object] = reference
		var references = Table.create();
		// Circular tables that must be filled using `table[key] = value` statements
		var to_fill = Table.create();
		LuaLoop.nativePairs(object, count, count_objects(value), {
			var type_ = Lua.type(object);
			// Object must appear more than once. If it is a string, the reference has to be shorter than the string.
			if (count >= 2 && (type_ != "string" || untyped __lua__('#{0}', reference) + 5 < untyped __lua__('#{0}', object))) {
				if (refnum == 1) {
					write("local _={};"); // initialize reference table
				}
				write("_[");
				write(reference);
				write("]=");
				if (type_ == "table") {
					write("{}");
				} else if (type_ == "function") {
					write(dump_func(object));
				} else if (type_ == "string") {
					write(quote(object));
				}
				write(";");
				references[object] = reference;
				if (type_ == "table") {
					to_fill[object] = reference;
				}
				refnum = refnum + 1;
				reference = untyped __lua__('("%d"):format({0})', refnum);
			}
		});

		// Used to decide whether we should do "key=..."
		function use_short_key(key: String): Bool {
			return references[cast key] == null
				&& Lua.type(key) == "string"
				&& (keywords[key] == null)
				&& untyped __lua__('string.match({0}, "^[%a_][%a%d_]*$")', key);
		}
		function dump(value: Dynamic): Null<String> {
			// Primitive types
			if (value == null) {
				return write("nil");
			}
			if (value == true) {
				return write("true");
			}
			if (value == false) {
				return write("false");
			}
			var type_ = Lua.type(value);
			if (type_ == "number") {
				if (value != value) { // nan
					return write("0/0");
				} else if (value == Math.huge) {
					return write("1/0");
				} else if (value == -Math.huge) {
					return write("-1/0");
				} else {
					return write(untyped __lua__('string.format("%.17g", {0})', value));
				}
			}

			// Failsafe for userdata/thread if it bypasses the filters.
			if (type_ == "userdata" || type_ == "thread") {
				return write("nil");
			}

			// Reference types: table, function and string
			var ref = references[value];
			if (ref != null) {
				write("_[");
				write(ref);
				return write("]");
			}
			if (type_ == "string") {
				return write(quote(value));
			}
			if (type_ == "function") {
				return write(dump_func(value));
			}
			if (type_ == "table") {
				write("{");
				// First write list keys:
				// Don't use the table length #value here as it may horribly fail
				// for tables which use large integers as keys in the hash part;
				// stop at the first "hole" (nil value) instead
				var len = 0;
				var first = true; // whether this is the first entry, which may not have a leading comma
				while (true) {
					var v = Lua.rawget(value, len + 1); // use rawget to avoid metatables like the vector metatable
					if (v == null) {
						break;
					}
					if (first) {
						first = false;
					} else {
						write(",");
					}
					// Write nil to preserve array indices if element is userdata.
					if (!allowed_type(v)) {
						write("nil");
					} else {
						dump(v);
					}
					len = len + 1;
				}
				// Now write map keys ([key] = value)
				LuaLoop.nativePairs(k, v, value, {
					// for k, v in pairs(value) do
					// We have written all non-float keys in [1, len] already
					if (Lua.type(k) != "number" || k % 1 != 0 || k < 1 || k > len) {
						// Skip entire key if either key or value is userdata/thread.
						if (allowed_type(k, v)) {
							if (first) {
								first = false;
							} else {
								write(",");
							}
							if (use_short_key(k)) {
								write(k);
							} else {
								write("[");
								dump(k);
								write("]");
							}
							write("=");
							dump(v);
						}
					}
				});
				write("}");
				return null;
			}
			return null;
		}
		// Write the statements to fill circular tables
		LuaLoop.nativePairs(table, ref, to_fill, {
			LuaLoop.nativePairs(k, v, table, {
				if (allowed_type(k, v)) {
					write("_[");
					write(ref);
					write("]");
					if (use_short_key(k)) {
						write(".");
						write(k);
					} else {
						write("[");
						dump(k);
						write("]");
					}
					write("=");
					dump(v);
					write(";");
				}
			});
		});
		write("return ");
		dump(value);
		// ? This has no return in the original lua code.
		return null;
	}

	// Whether `value` recursively contains a function
	static function contains_function(value: Dynamic): Bool {
		var seen = Table.create();
		function check(val: Dynamic): Bool {
			if (Lua.type(val) == "function") {
				return true;
			}
			if (Lua.type(val) == "table") {
				if (seen[val]) {
					return false;
				}
				seen[val] = true;
				LuaLoop.nativePairs(k, v, val, {
					if (allowed_type(k, v)) {
						if (check(k) || check(v)) {
							return true;
						}
					}
				});
			}
			return false;
		}
		return check(value);
	}

	public static function core_serialize(value) {
		if (contains_function(value)) {
			Core.log(LogLevelWarning, "Support for dumping functions in `core.serialize` is deprecated.");
		}
		var rope = Table.create();
		// Keeping the length of the table as a local variable is *much*
		// faster than invoking the length operator.
		// See https://gitspartv.github.io/LuaJIT-Benchmarks/#test12.
		var i = 0;
		serialize(value, (text) -> {
			i = i + 1;
			rope[i] = text;
		});
		return Table.concat(rope);
	}

	static function dummy_func() {}

	public static function core_deserialize(str, ?safe) {
		// Backwards compatibility
		if (str == null) {
			Core.log(LogLevelWarning, "core.deserialize called with nil (expected string).");
			return untyped __lua__('nil, "Invalid type: Expected a string, got nil"');
		}
		var t = Lua.type(str);
		if (t != "string") {
			Lua.error(untyped __lua__('("core.deserialize called with %s (expected string)."):format({0})', t));
		}

		var output: PureDynamic = untyped __lua__("loadstring({0})", str);
		var func = output.first;
		var err = output.second;
		if (func == null) {
			return untyped __lua__('nil, {0}', err);
		}

		// math.huge was serialized to inf and NaNs to nan by Lua in engine version 5.6, so we have to support this here
		var env = Table.create();
		env.inf = Math.POSITIVE_INFINITY; // math.huge
		env.nan = Math.NaN; // 0/0

		if (safe) {
			untyped __lua__("env.loadstring = {0}", dummy_func);
		} else {
			env.loadstring = untyped __lua__('function({1}, ...)
			local func, err = loadstring({1}, ...)
			if func then
				setfenv(func, {0})
				return func
			end
			return nil, err
		end', env, str);
		}

		Lua.setfenv(func, env);

		var success = null;
		var value_or_err = null;
		untyped __lua__('{0}, {1} = pcall({2})', success, value_or_err, func);
		// var output = (cast Lua.pcall(cast func) : PureDynamic);

		if (success) {
			return value_or_err;
		}
		return untyped __lua__('nil, {0}', value_or_err);
	}

	// ! Here starts the raw code.
	static function __init__() {
		assignTypes();

		Core.registerOnJoinPlayer((player, asdf) -> {
			untyped print(player);

			var testSubject = new Formspec("testing")
				.addElement("test_page", "test_button", new FormspecButton(2, 2, 2, 2, "button"));

			// var testSubject = Table.create();
			// testSubject[cast "a"] = 5;

			// This is the new one.
			var testSerializeB = Core.serialize(testSubject);

			testSubject.setPlayer(player);

			var testSerializeA = core_serialize(cast testSubject);

			var backToNormalA = core_deserialize(cast testSerializeB);

			// This is the new one.
			var backToNormalB = Core.deserialize(testSerializeB);

			untyped {
				print("test serialize a:", dump(testSerializeA));
				print("test serialize b:", dump(testSerializeB));
				// print(testSerializeA == testSerializeB);
				print("=======================");
				print("test deserialize a:", dump(backToNormalA));
				print("test deserialize b:", dump(backToNormalB));
				// print(backToNormalA == backToNormalB);
			}

			Core.requestShutdown();
		});

		return;
	}
}

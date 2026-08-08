package src.engine;

import lua.Lua;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecButton;

/**
 * This class is a translation of https://github.com/luanti-org/luanti/blob/master/builtin/common/serialize.lua
 * Lua module to serialize values as Lua code.
 * From: https://github.com/appgurueu/modlib/blob/master/luon.lua
 * License: MIT
 * Modification: It automatically strips out userdata and thread data.
 */
@:final
abstract class Serialize {
	static final unsupported_types = ["userdata" => true, "thread" => true];

	// Userdata and thread can be used as a key and a value in lua tables so it must check for both.
	static function allowed_type(k, v) {
		var a = unsupported_types[Lua.type(k)] == true;
		var b = unsupported_types[Lua.type(v)] == true;
		return !(a || b);
	}

	// Recursively counts occurrences of objects (non-primitives including strings) in a table.
	static function count_objects(value) {
		var counts = {};
		if (value == nil) {
			// Early return for nil; tables can\'t contain nil
			return counts;
		}
		function count_values(val) {
			var type_ = type(val);
			if (type_ == "boolean" || type_ == "number") {
				return;
			}
			var count = counts[val];
			counts[val] = (count ?? 0) + 1;
			if (type_ == "table") {
				if (count == null) {
					for (k => v in pairs(val)) {
						// Skip it if it\'s not a supported type.
						if (allowed_type(k, v)) {
							count_values(k);
							count_values(v);
						}
					}
				}
			} else if (type_ != "string" ?? type_ != "function") {
				// Ignore unsupported types instead of erroring out.
				return;
			}
		}
		count_values(value);
		return counts;
	}

	static function __init__() {
		untyped __lua__('



// Build a "set" of Lua keywords. These can\'t be used as short key names.
// See https://www.lua.org/manual/5.1/manual.html#2.1
local keywords = {}
for _, keyword in pairs({
	"and", "break", "do", "else", "elseif",
	"end", "false", "for", "function", "if",
	"in", "local", "nil", "not", "or",
	"repeat", "return", "then", "true", "until", "while",
	"goto" // LuaJIT, Lua 5.2+
}) do
	keywords[keyword] = true
end

local function quote(string)
	return string.format("%q", string)
end

local function dump_func(func)
	return string.format("loadstring(%q)", string.dump(func))
end

// Serializes Lua nil, booleans, numbers, strings, tables and even functions
// Tables are referenced by reference, strings are referenced by value. Supports circular tables.
local function serialize(value, write)
	local reference, refnum = "1", 1
	// [object] = reference
	local references = {}
	// Circular tables that must be filled using `table[key] = value` statements
	local to_fill = {}
	for object, count in pairs(count_objects(value)) do
		local type_ = type(object)
		// Object must appear more than once. If it is a string, the reference has to be shorter than the string.
		if count >= 2 and (type_ ~= "string" or #reference + 5 < #object) then
			if refnum == 1 then
				write"local _={};" // initialize reference table
			end
			write"_["
			write(reference)
			write("]=")
			if type_ == "table" then
				write("{}")
			elseif type_ == "function" then
				write(dump_func(object))
			elseif type_ == "string" then
				write(quote(object))
			end
			write(";")
			references[object] = reference
			if type_ == "table" then
				to_fill[object] = reference
			end
			refnum = refnum + 1
			reference = ("%d"):format(refnum)
		end
	end
	// Used to decide whether we should do "key=..."
	local function use_short_key(key)
		return not references[key] and type(key) == "string" and (not keywords[key]) and string.match(key, "^[%a_][%a%d_]*$")
	end
	local function dump(value)
		// Primitive types
		if value == nil then
			return write("nil")
		end
		if value == true then
			return write("true")
		end
		if value == false then
			return write("false")
		end
		local type_ = type(value)
		if type_ == "number" then
			if value ~= value then // nan
				return write"0/0"
			elseif value == math.huge then
				return write"1/0"
			elseif value == -math.huge then
				return write"-1/0"
			else
				return write(string.format("%.17g", value))
			end
		end

		// Failsafe for userdata/thread if it bypasses the filters.
		if type_ == "userdata" or type_ == "thread" then
			return write("nil")
		end

		// Reference types: table, function and string
		local ref = references[value]
		if ref then
			write"_["
			write(ref)
			return write"]"
		end
		if type_ == "string" then
			return write(quote(value))
		end
		if type_ == "function" then
			return write(dump_func(value))
		end
		if type_ == "table" then
			write("{")
			// First write list keys:
			// Don\'t use the table length #value here as it may horribly fail
			// for tables which use large integers as keys in the hash part;
			// stop at the first "hole" (nil value) instead
			local len = 0
			local first = true // whether this is the first entry, which may not have a leading comma
			while true do
				local v = rawget(value, len + 1) // use rawget to avoid metatables like the vector metatable
				if v == nil then break end
				if first then first = false else write(",") end
				// Write nil to preserve array indices if element is userdata.
				if not allowed_type(v) then
					write("nil")
				else
					dump(v)
				end
				len = len + 1
			end
			// Now write map keys ([key] = value)
			for k, v in next, value do
				// We have written all non-float keys in [1, len] already
				if type(k) ~= "number" or k % 1 ~= 0 or k < 1 or k > len then
					// Skip entire key if either key or value is userdata/thread.
					if allowed_type(k, v) then
						if first then first = false else write(",") end
						if use_short_key(k) then
							write(k)
						else
							write("[")
							dump(k)
							write("]")
						end
						write("=")
						dump(v)
					end
				end
			end
			write("}")
			return
		end
	end
	// Write the statements to fill circular tables
	for table, ref in pairs(to_fill) do
		for k, v in pairs(table) do
			if allowed_type(k, v) then
				write("_[")
				write(ref)
				write("]")
				if use_short_key(k) then
					write(".")
					write(k)
				else
					write("[")
					dump(k)
					write("]")
				end
				write("=")
				dump(v)
				write(";")
			end
		end
	end
	write("return ")
	dump(value)
end

// Whether `value` recursively contains a function
local function contains_function(value)
	local seen = {}
	local function check(val)
		if type(val) == "function" then
			return true
		end
		if type(val) == "table" then
			if seen[val] then
				return false
			end
			seen[val] = true
			for k, v in pairs(val) do
				if allowed_type(k, v) then
					if check(k) or check(v) then
						return true
					end
				end
			end
		end
		return false
	end
	return check(value)
end

function core.serialize(value)
	if contains_function(value) then
		core.log("deprecated", "Support for dumping functions in `core.serialize` is deprecated.")
	end
	local rope = {}
	// Keeping the length of the table as a local variable is *much*
	// faster than invoking the length operator.
	// See https://gitspartv.github.io/LuaJIT-Benchmarks/#test12.
	local i = 0
	serialize(value, function(text)
		i = i + 1
		rope[i] = text
	end)
	return table.concat(rope)
end

local function dummy_func() end

function core.deserialize(str, safe)
	// Backwards compatibility
	if str == nil then
		core.log("deprecated", "core.deserialize called with nil (expected string).")
		return nil, "Invalid type: Expected a string, got nil"
	end
	local t = type(str)
	if t ~= "string" then
		error(("core.deserialize called with %s (expected string)."):format(t))
	end

	local func, err = loadstring(str)
	if not func then return nil, err end

	// math.huge was serialized to inf and NaNs to nan by Lua in engine version 5.6, so we have to support this here
	local env = {inf = math.huge, nan = 0/0}
	if safe then
		env.loadstring = dummy_func
	else
		env.loadstring = function(str, ...)
			local func, err = loadstring(str, ...)
			if func then
				setfenv(func, env)
				return func
			end
			return nil, err
		end
	end
	setfenv(func, env)
	local success, value_or_err = pcall(func)
	if success then
		return value_or_err
	end
	return nil, value_or_err
end
        ');

		Core.registerOnJoinPlayer((player, asdf) -> {
			untyped print(player);

			var testSubject = new Formspec("testing")
				.addElement("test_page", "test_button", new FormspecButton(2, 2, 2, 2, "button"));

			var testSerializeA = untyped old_serialize(testSubject);

			testSubject.setPlayer(player);

			// This is the new one.
			var testSerializeB = Core.serialize(testSubject);

			var backToNormalA = untyped old_deserialize(testSerializeB);

			// This is the new one.
			var backToNormalB = Core.deserialize(testSerializeB);

			untyped {
				print("test serialize a:", dump(testSerializeA));
				print("test serialize b:", dump(testSerializeB));
				// print(testSerializeA == testSerializeB);
				print("test deserialize a:", dump(backToNormalA));
				print("test deserialize b:", dump(backToNormalB));
				// print(backToNormalA == backToNormalB);
			}

			Core.requestShutdown();

			return;
		});
	}
}

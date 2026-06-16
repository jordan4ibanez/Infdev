package definition;

import lua.Table;

class GroupDefinition {
	public var maxlevel = 0;
	public var uses = 20;
    
}

class ToolCapabilities {
	public var groupcaps: Table<String, GroupDefinition>;
}

default:
	@haxe build.hxml
	@haxe buildTerrainGenerator.hxml
	@luanti --quiet --go --gameid Infdev --worldname world
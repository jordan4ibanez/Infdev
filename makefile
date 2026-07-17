default:
	@haxe build.hxml
	@haxe buildTerrainGenerator.hxml
	@luanti --quiet --go --gameid Infdev --worldname world

package:
	@haxe build.hxml
	@haxe buildTerrainGenerator.hxml
	@haxe --run Package.hx

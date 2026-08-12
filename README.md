# Infdev
A Luanti game written in haxe. Targets: 5.17.0 (for play_animation multitrack)

this is the original one so I can look at my own code

https://github.com/jordan4ibanez/Infdev_original


## Licensing/Credit Information Directories

### [Fonts](mods/infdev/fonts/LICENSE.md)

### [Sounds](mods/infdev/sounds/LICENSE.md)

### [Models](mods/infdev/models/model_licensing_directory.md)

### [Textures](mods/infdev/textures/texture_licensing_directory.md)


## Note:

This started out as a curiosity, but it has quickly become apparent this is better than typescripttolua.

This is going to be infdev.
infdev originally started out as a clone of minecraft infdev but I think it would be cooler to have a fuck ton of rpg elements in it.

api was transposed may-august 2026


### some design decisions:

##### immediate todos:

have a method that marks them as persistent

notes page:
- add a save button to the notes taking page
- fix the note taking page to restore the text on resize
- allow textboxes and forms to save their data into the object itself so it can be persistent

put the players individual formspecs into individual save Metadata so the string doesn't become too big

do this for the levels object in the player as well

make items not physical, they exist statically
- When they need to move instead of smooth movement, they move by node including gravity on a timer
- If there are multiple items on a node, when you right click, bring up a menu to pick which one you want

Some kind of tick system so all entities can do things every half second
- Not sure how to set up alerts, maybe just alertMe or something

##### todos when available to put some cool things in:

Use a name tag on mobs, items, and npcs

Use a static seed for the terrain generator but not the ores
- This can be used to create actual cities and locations in the world without worrying about the terrain generator randomizing

Pull the character model from ruantis in and make it look less horrible.

I think it would be cool if the game had runescape skills bolted in

so like you cut trees: (woodcutting)

lower levels can have a chance of failing to drop an item

higher chances have a chance of doubling or tripling output

maybe the tree randomly drops things as you chop it down

when a new player joins, a jingle plays at their position

when a player returns, a teleport sound plays at their position

hot bar starts off with 1 slot and your general level increases this until it maxes out at like 40 slots or some ridiculous number

Central Market which is like the grand exchange but won't let jagex sue me

Maybe call that the Bartering Hall

Can probably make a nice GUI for the central market

ironman with no access to the central market

chunklocked ironmen BUILT INTO THE SERVER! With awesome plugins to visualize where you are
also they can't escape the chunk and they can have their interactions disabled with things outside of the chunk

polynomial xp requirements. level 2 starts at 1000 and increases by old level + (new level * 1000)
so in a loop:
i = new level
w = old level xp requirement
new level xp requirement = w + (i * 1000) 
should probably calculate the max a lua float can handle then cap the level at this
Also figure out a formula to calculate this unless looping is just easier

The Unknown:
If you reach the border of the overworld you enter into the unknown dimension, which has pancake shaped floating islands with extremely difficult monsters. Everything should be like level 30 to mine. Everything should look spooky.
- When you step into the edge of the world, it transports you exactly into the same spot but on a different Y dimension
- This allows you to also step back into the overworld. But, it also allows mobs to enter into the overworld on the world border
  
The Lowlands:
An artifact you can find and put on a pedestool. When you stand next to it for 3 seconds you're transported into a completely flooded dimension where islands are scarce and there are huge fish. Can probably be a good use for custom boats. Also it should have a very victorian oceanic sailing feeling to it.

grindstone where your weapons/tools go from regular to sharpened for a limited amount of uses which gives them a bonus.

Item effects, only allow slot sections to go into slots using groups, add effects like goggles tinting everything and when you take it off it stops the effect. It can be an object maybe
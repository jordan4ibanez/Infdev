package src.engine.entity;

typedef MoveResult = {
        touching_ground = boolean,
    // Note that touching_ground is only true if the entity was moving and
    // collided with ground.

    collides = boolean,
    standing_on_object = boolean,

    collisions = {
        {
            type = string, // "node" or "object",
            axis = string, // "x", "y" or "z"
            node_pos = vector, // if type is "node"
            object = ObjectRef, // if type is "object"
            // The position of the entity when the collision occurred.
            // Available since feature "moveresult_new_pos".
            new_pos = vector,
            old_velocity = vector,
            new_velocity = vector,
        },
        ...
    }
    // `collisions` does not contain data of unloaded mapblock collisions
    // or when the velocity changes are negligibly small
}
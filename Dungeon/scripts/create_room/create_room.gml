function create_room(dungeon_array) {
    var dungeon_width = array_length(dungeon_array[0]);
    var dungeon_height = array_length(dungeon_array);

    var new_room = room_add();
    room_set_width(new_room, dungeon_width * 32);
    room_set_height(new_room, dungeon_height * 32);
    room_set_persistent(new_room, true);

    for (var dy = 0; dy < dungeon_height; dy++) { // Changed y -> dy
        for (var dx = 0; dx < dungeon_width; dx++) { // Changed x -> dx
            var tile = dungeon_array[dy][dx];

            if (tile == 1) {
                instance_create_layer(dx * 32, dy * 32, "Walls", obj_wall);
            } else {
                instance_create_layer(dx * 32, dy * 32, "Floor", obj_floor);
            }
        }
    }
    room_goto(new_room);
}
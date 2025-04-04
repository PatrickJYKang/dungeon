function create_dungeon_room(dungeon_array) {
    // 1) Create the new room
    var tile_size = 32;
    var dungeon_height = array_length(dungeon_array);
    var dungeon_width = array_length(dungeon_array[0]);
	
	show_debug_message("width, height: " + string(dungeon_height) + " " + string(dungeon_width));

    var new_room = room_add();
    room_set_width(new_room, dungeon_width * tile_size);
    room_set_height(new_room, dungeon_height * tile_size);

	show_debug_message("Done creating room");

    // 2) Build tilemaps in the new room
    layer_set_target_room(new_room);
    // Floor layer
    var layer_floor_id = layer_create(-1, "Floors");
    var tilemap_floor_id = layer_tilemap_create(layer_floor_id, 0, 0, global.tileset_floor_index, dungeon_width, dungeon_height);
    tilemap_clear(tilemap_floor_id, -1);

    // Wall layer
    var layer_walls_id = layer_create(-2, "Walls");
    var tilemap_walls_id = layer_tilemap_create(layer_walls_id, 0, 0, global.tileset_walls_index, dungeon_width, dungeon_height);
    tilemap_clear(tilemap_walls_id, -1);
	
	show_debug_message("Done creating tilemap layers");

    // Fill tilemaps
    for (var dy = 0; dy < dungeon_height; dy++) {
        for (var dx = 0; dx < dungeon_width; dx++) {
            if (dungeon_array[dy][dx] == 1) {
                tilemap_set(tilemap_walls_id, 0, dx, dy);
            } else {
                tilemap_set(tilemap_floor_id, 0, dx, dy);
            }
        }
    }
	show_debug_message("Done adding tilemaps");
	show_debug_message("Done entering room");
	
	instance_create_depth(0, 0, 1, obj_dungeon_controller);
	
	show_debug_message("Done creating controller");
    layer_reset_target_room();

    // 3) Switch to that new room
    room_goto(new_room);
	/*
    // 4) Create a camera for view[0]
    //    (Still in the same code block, but the room switch won't apply until the event ends)
    var cam = camera_create_view(0, 0, 640, 480);

    // 5) Enable the view system, set up view[0]
    view_enabled = true;              // Turn on the view system
    view_set_visible(0, true);        // Make view[0] visible
    view_set_camera(0, cam);          // Assign our camera to view[0]
    view_set_xport(0, 0);             // Position the port at (0,0)
    view_set_yport(0, 0);
    view_set_wport(0, 640);           // Port size: 640×480
    view_set_hport(0, 480);*/
}
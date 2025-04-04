// Inherit the parent event
event_inherited();

activate_button = function() 
{
	
	global.tileset_floor_index = asset_get_index("tileset_floor");
	global.tileset_walls_index = asset_get_index("tileset_walls");
	global.floor_tile_index = 0;
	global.wall_tile_index = 0;

	// Step 2: Generate dungeon and get the file path
	var dungeon_file = generate_dungeon();

	if (dungeon_file != undefined) {
	    // Step 3: Read the dungeon
	    var dungeon_array = parse_dungeon(dungeon_file);
		
		//show_debug_message("Dungeon array: " + string(dungeon_array));

	    if (dungeon_array != undefined) {
	        // Step 4: Create the room
	        create_dungeon_room(dungeon_array);
	    }
	}
}
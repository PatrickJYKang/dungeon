function parse_dungeon(dungeon_path) {
    // 1) Read the file into a string
    if (!file_exists(dungeon_path)) {
        show_debug_message("ERROR: JSON file not found: " + dungeon_path);
        return undefined;
    }

    var file = file_text_open_read(dungeon_path);
    var json_string = "";

    while (!file_text_eof(file)) {
        json_string += file_text_read_string(file);
        file_text_readln(file);
    }
    file_text_close(file);

    //show_debug_message("Raw JSON:\n" + json_string);

    // 2) Parse using json_parse()
    var data;
    try {
        data = json_parse(json_string);
    } catch (e) {
        // If the JSON is invalid, an exception is thrown
        show_debug_message("json_parse error: " + e.message);
        return undefined;
    }

    //show_debug_message("Parsed data: " + string(data));

    // 3) Check if it's a struct and if 'dungeon' exists
    if (is_struct(data)) {
        if (struct_exists(data, "dungeon")) {
            // 3A) Check if data.dungeon is an array
            if (is_array(data.dungeon)) {
                show_debug_message("Dungeon array found!");
                return data.dungeon; // Return the 2D array
            } else {
                show_debug_message("'dungeon' is not an array. It's: " + string(data.dungeon));
                return undefined;
            }
        } else {
            show_debug_message("No 'dungeon' key found in the root struct.");
            return undefined;
        }
    } else if (is_array(data)) {
        // 3B) If the entire root is just an array, see if that's your dungeon
        show_debug_message("Root is an array. Possibly your dungeon is the entire array?");
        return data; 
    }

    // If we reach here, it wasn't a struct with 'dungeon' nor a root array
    show_debug_message("ERROR: Unexpected JSON format.");
    return undefined;
}
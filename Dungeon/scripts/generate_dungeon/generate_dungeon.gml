function generate_dungeon() {
    // Run Python script
    execute_shell("/usr/bin/python3", "../export_dungeon.py");  
    show_debug_message("Ran Python to generate dungeon...");

    // Wait up to 10 seconds for the file
    var dungeon_file = "/Users/patrickkang/Library/Application Support/Dungeon/dungeon1.json";
    var start_time = current_time;
    var timeout_ms = 10000; // 10 seconds

    while (!file_exists(dungeon_file)) {
        if ((current_time - start_time) >= timeout_ms) {
            show_debug_message("ERROR: Dungeon JSON file not found after waiting.");
            return undefined;
        }
    }

    show_debug_message("Dungeon JSON file found!");
    return dungeon_file;
}
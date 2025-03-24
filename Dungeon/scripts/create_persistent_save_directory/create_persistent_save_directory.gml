function create_persistent_save_directory() {
    var home_dir = "/Users/patrickkang"; // TEMP FIX, manually setting home directory
    var real_path = home_dir + "/Library/Application Support/Dungeon/";
    var gm_symlink_path = working_directory + "save_data";

    show_debug_message("GameMaker working directory: " + working_directory);

    // Check if the symlink already exists
    if (directory_exists(gm_symlink_path)) {
        show_debug_message("Persistent save symlink already exists: " + gm_symlink_path);
        return;
    }

    var cmd = "/bin/ln -s \"" + real_path + "\" \"" + gm_symlink_path + "\"";
	execute_shell(cmd, "");  // Directly run the ln command

    // Try running without "-c"
    execute_shell("/bin/bash", cmd);
    show_debug_message("Executed symlink command: " + cmd);
}
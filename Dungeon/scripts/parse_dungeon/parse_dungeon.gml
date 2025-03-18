function parse_dungeon(filename){
	var file = file_text_open_read(filename);
	var json_string = "";

	while (!file_text_eof(file)) {
	    json_string += file_text_read_string(file);
	    file_text_readln(file);
	}
	file_text_close(file);

	var dungeon_data = json_decode(json_string);
	return dungeon_data["dungeon"];
}
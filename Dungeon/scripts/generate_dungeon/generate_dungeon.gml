function generate_dungeon(){
	var command = "python ../generate_dungeon.py";
	execute_shell(command, false); 

	// Return the JSON filename (assumes one dungeon at a time)
	return "dungeons/dungeon1.json";
}
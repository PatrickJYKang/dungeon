// Inherit the parent event
event_inherited();

activate_button = function() 
{
	// Call Python to generate the dungeon and return JSON
	var dungeon = generate_dungeon(); 

	// Parse the JSON and load it into an array
	parse_dungeon(dungeon);

	// Create a new room using the parsed dungeon array
	create_room(dungeon);
}
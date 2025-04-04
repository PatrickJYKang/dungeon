show_debug_message("Init controller");

// Create a new camera
var cam = camera_create();

// Set the camera’s view size and position
camera_set_view_size(cam, 640, 480);
camera_set_view_pos(cam, 0, 0);

// Assign the camera to display 0 and make it active
view_set_camera(0, cam);

show_debug_message("Done adding camera");
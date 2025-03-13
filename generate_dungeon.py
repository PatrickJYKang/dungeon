import numpy as np
import matplotlib.pyplot as plt
import random
import scipy.ndimage
from dungeon_config import *  # Import all configuration variables

# Room class
class Room:
    def __init__(self, x, y, w, h):
        self.x, self.y = x, y
        self.w, self.h = w, h

    def carve_room(self, dungeon):
        """Converts a section of the dungeon grid into a floor."""
        for i in range(self.y, self.y + self.h):
            for j in range(self.x, self.x + self.w):
                dungeon[i, j] = 0

def is_too_close(new_room, existing_rooms, min_distance):
    """Checks if the new room is too close to existing rooms."""
    for room in existing_rooms:
        if (
            new_room.x - min_distance < room.x + room.w and
            new_room.x + new_room.w + min_distance > room.x and
            new_room.y - min_distance < room.y + room.h and
            new_room.y + new_room.h + min_distance > room.y
        ):
            return True  # Room is too close
    return False

def cellular_automata_shrink(dungeon, room, iterations, wall_chance):
    """Uses a cellular automata approach to make walls grow into the room."""
    for _ in range(iterations):
        new_walls = []
        for y in range(room.y, room.y + room.h):
            for x in range(room.x, room.x + room.w):
                if dungeon[y, x] == 0:  # Only consider floor tiles
                    adjacent_walls = sum([
                        dungeon[y - 1, x] == 1,
                        dungeon[y + 1, x] == 1,
                        dungeon[y, x - 1] == 1,
                        dungeon[y, x + 1] == 1
                    ])

                    if adjacent_walls >= random.randint(1, 4) and random.random() < wall_chance:
                        new_walls.append((y, x))

        for y, x in new_walls:
            dungeon[y, x] = 1

def get_room_center(room):
    """Returns the center coordinate of a room."""
    return (room.y + room.h // 2, room.x + room.w // 2)

def carve_corridor(dungeon, start, end):
    """Creates an L-shaped corridor between two points."""
    y1, x1 = start
    y2, x2 = end

    if random.choice([True, False]):
        for x in range(min(x1, x2), max(x1, x2) + 1):
            dungeon[y1, x] = 0
        for y in range(min(y1, y2), max(y1, y2) + 1):
            dungeon[y, x2] = 0
    else:
        for y in range(min(y1, y2), max(y1, y2) + 1):
            dungeon[y, x1] = 0
        for x in range(min(x1, x2), max(x1, x2) + 1):
            dungeon[y2, x] = 0

def remove_small_disconnected_areas(dungeon, min_size):
    """Removes isolated floor areas smaller than min_size."""
    labeled_array, num_features = scipy.ndimage.label(dungeon == 0)
    for i in range(1, num_features + 1):
        region_size = np.sum(labeled_array == i)
        if region_size < min_size:
            dungeon[labeled_array == i] = 1

# Generate multiple dungeons
for dungeon_index in range(num_dungeons):
    dungeon = np.ones((height, width), dtype=int)
    rooms = []

    # First pass rooms
    for _ in range(num_rooms_pass_1):
        attempts = 0
        while attempts < max_attempts:
            room_w, room_h = random.randint(*room_width_range_1), random.randint(*room_height_range_1)
            room_x, room_y = random.randint(1, width - room_w - 1), random.randint(1, height - room_h - 1)

            new_room = Room(room_x, room_y, room_w, room_h)

            if not is_too_close(new_room, rooms, min_spacing_pass_1):
                new_room.carve_room(dungeon)
                rooms.append(new_room)
                break

            attempts += 1

    # Apply cellular automata wall shrinkage for first pass
    for room in rooms:
        cellular_automata_shrink(dungeon, room, wall_shrink_iterations, wall_chance)

    # Second pass rooms
    second_batch_rooms = []
    for _ in range(num_rooms_pass_2):
        attempts = 0
        while attempts < max_attempts:
            room_w, room_h = random.randint(*room_width_range_2), random.randint(*room_height_range_2)
            room_x, room_y = random.randint(1, width - room_w - 1), random.randint(1, height - room_h - 1)

            new_room = Room(room_x, room_y, room_w, room_h)

            if not is_too_close(new_room, rooms + second_batch_rooms, min_spacing_pass_2):
                new_room.carve_room(dungeon)
                second_batch_rooms.append(new_room)
                break

            attempts += 1

    # Apply cellular automata wall shrinkage for second pass
    for room in second_batch_rooms:
        cellular_automata_shrink(dungeon, room, wall_shrink_iterations, wall_chance)

    # Connect rooms with corridors
    all_rooms = rooms + second_batch_rooms
    room_centers = [get_room_center(room) for room in all_rooms]
    room_centers.sort()

    for i in range(len(room_centers) - 1):
        carve_corridor(dungeon, room_centers[i], room_centers[i + 1])

    # Remove small disconnected floor regions
    remove_small_disconnected_areas(dungeon, min_disconnected_area_size)

    # Display dungeon
    plt.figure(figsize=(20, 20))
    plt.imshow(dungeon, cmap="gray_r")
    plt.axis("off")
    plt.title(f"Procedural Dungeon {dungeon_index + 1}")
    plt.show()
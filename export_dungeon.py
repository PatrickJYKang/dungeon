import numpy as np
import json
from dungeon_config import *  # Importing parameters

def export_dungeon_to_json(dungeon, filename="dungeon.json"):
    """Exports the dungeon as a JSON file in a 2D array format."""
    dungeon_dict = {
        "dungeon": dungeon.tolist()  # Convert NumPy array to a standard Python list
    }

    with open(filename, "w") as f:
        json.dump(dungeon_dict, f, indent=4)

# Example usage: Generate a dungeon and export it
if __name__ == "__main__":
    # Generate a blank dungeon (walls everywhere)
    dungeon = np.ones((height, width), dtype=int)

    # Generate rooms and corridors (reuse your existing dungeon generation logic)
    # Assuming `generate_dungeon()` is your function that fills the array
    # dungeon = generate_dungeon()

    export_dungeon_to_json(dungeon, filename="/Dungeon/dungeon.json")

    print("Dungeon exported successfully to dungeon.json")
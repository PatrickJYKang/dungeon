import os
import json
import numpy as np
from dungeon_config import *

def export_dungeon_to_json(dungeon, filename="dungeon1.json"):
    """Exports the dungeon as a JSON file inside the 'Dungeon/dungeons' folder."""
    
    # Corrected relative path to the GameMaker directory
    output_dir = os.path.join(os.getcwd(), "Dungeon", "dungeons")  # Relative path

    os.makedirs(output_dir, exist_ok=True)  # Ensure the directory exists

    filepath = os.path.join(output_dir, filename)

    dungeon_dict = {
        "dungeon": dungeon.tolist()
    }

    with open(filepath, "w") as f:
        json.dump(dungeon_dict, f, indent=4)

    print(f"Dungeon exported successfully to {filepath}")
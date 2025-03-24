import os
import json
import numpy as np

SAVE_DIR = "/Users/patrickkang/Library/Application Support/Dungeon/"
JSON_FILE = os.path.join(SAVE_DIR, "dungeon1.json")

os.makedirs(SAVE_DIR, exist_ok=True)

def export_dungeon_to_json(dungeon):
    with open(JSON_FILE, "w", encoding="utf-8") as f:
        json.dump({"dungeon": dungeon.tolist()}, f, indent=4)
    print(f"Dungeon saved to {JSON_FILE}")

if __name__ == "__main__":
    dungeon = np.ones((5, 5), dtype=int)  # Example dungeon
    export_dungeon_to_json(dungeon)
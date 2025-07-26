import os
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed

CONFIG = "config.ini"
MODEL_DIR = "models"
SLICE_SCRIPT = "./slice.sh"
PARALLEL_JOBS = os.cpu_count() or 2  # Use all available CPU cores, fallback to 2

# Find all .stl and .obj files in the models directory
models = [f for f in os.listdir(MODEL_DIR) if f.lower().endswith(('.stl', '.obj'))]

if not models:
    print("No model files found in 'models/' directory.")
    exit(1)

def run_slice(model):
    cmd = [SLICE_SCRIPT, model, CONFIG]
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        return (model, True, result.stdout)
    except subprocess.CalledProcessError as e:
        with open("error.log", "a") as errlog:
            errlog.write(f"Slicing failed for {model}: {e}\n")
        return (model, False, e)

with ThreadPoolExecutor(max_workers=PARALLEL_JOBS) as executor:
    futures = {executor.submit(run_slice, model): model for model in models}
    for future in as_completed(futures):
        model, success, output = future.result()
        if success:
            print(f"[OK] {model}")
        else:
            print(f"[FAIL] {model}") 
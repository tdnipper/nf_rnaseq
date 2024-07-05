import os

for dirpath, dirname, files in os.walk("raw_data"):
    for file in files:
        basename = os.path.basename(file)
        parts = basename.split("_")
        if len (parts) >= 4:
            sample = parts[0]
            pair = parts[3]
            new_filename = f"{sample}_{pair}"
            old_path = os.path.join(dirpath, file)
            new_path = os.path.join(dirpath, new_filename)
            os.rename(old_path, new_path)
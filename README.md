# PrusaSlicer CLI Docker Workflow

This project provides a streamlined, terminal-based workflow for slicing 3D models using the [PrusaSlicer](https://github.com/prusa3d/PrusaSlicer) CLI, fully containerized with Docker. It leverages official PrusaSlicer configuration profiles for flexible, reproducible slicing without the GUI.

## Project Structure

- **dockerfile**: (Optional) For building your own Docker image with PrusaSlicer CLI and all dependencies.
- **PrusaSlicer/**: The main PrusaSlicer source (cloned during Docker build if building locally).
- **PrusaSlicer-settings-prusa-fff/**: Official PrusaSlicer FFF (Fused Filament Fabrication) printer/filament profiles, used for configuration.
- **models/**: Place your `.stl` models, `.ini` config files, and output `.gcode` here.
- **slice.sh**: Bash script to run slicing jobs via Docker.
- **help-fff.txt**, **help-sla.txt**, **help.txt**: Full CLI help for PrusaSlicer, including all available options for FFF and SLA printing.

---

## Quick Start

### 1. Pull the Docker Image

```sh
docker pull billa05/prusacli:latest
```

### 2. Prepare Your Files
- Place your 3D model (e.g., `test_model.stl`) and desired config/profile (e.g., `2.2.17.ini`) in the `models/` directory.
- Output G-code and stats will also be written to `models/`.

### 3. Slice a Model

Use the provided `slice.sh` script:

```sh
./slice.sh <model.stl> <config.ini> <output.gcode> [stats.txt]
```

**Example:**
```sh
./slice.sh test_model.stl 2.2.17.ini test.gcode stats.txt
```
- Slices `test_model.stl` using `2.2.17.ini` config, outputs `test.gcode`, and writes slicing stats to `stats.txt`.

---

## How It Works

- The Docker image contains a CLI-only build of PrusaSlicer and all required libraries.
- The `slice.sh` script mounts the `models/` directory into the container, so all input/output files are accessible from your host.
- Slicing is performed entirely via the PrusaSlicer CLI, with no GUI required.
- The official PrusaSlicer FFF profiles (in `PrusaSlicer-settings-prusa-fff/`) can be used as config files for consistent, high-quality slicing.

---

## Advanced Usage

- The PrusaSlicer CLI supports a wide range of options for customizing slicing, supports, infill, and more.
- See the included help files for full documentation:
  - `help-fff.txt`: All FFF (Fused Filament Fabrication) options
  - `help-sla.txt`: All SLA (resin) options
  - `help.txt`: General CLI usage

To pass additional options, you can modify the `slice.sh` script or run the Docker command directly. For example, to change brim width or enable/disable supports, add the relevant flags (see help files for details).

---

## Using Official PrusaSlicer Profiles

- The `PrusaSlicer-settings-prusa-fff/` directory contains official `.ini` profiles for many printers and filaments.
- You can use these directly with the `--load` option, or combine multiple profiles as needed.
- Example: `--load /models/2.2.17.ini`

---

## Troubleshooting

- If you encounter issues, check the `stats.txt` output for error messages.
- For advanced configuration, consult the help files or the [PrusaSlicer documentation](https://github.com/prusa3d/PrusaSlicer).

---

## Optional: Build the Docker Image Locally

If you want to build the Docker image yourself (for development or customization), you can do so with:

```sh
docker build -t billa05/prusacli:latest .
```

This will use the provided `dockerfile` to build the image from source.

---

## References
- [PrusaSlicer GitHub](https://github.com/prusa3d/PrusaSlicer)
- [PrusaSlicer CLI Documentation](https://github.com/prusa3d/PrusaSlicer/wiki/Command-Line-Interface)
- [PrusaSlicer-settings](https://github.com/prusa3d/PrusaSlicer-settings)

---

## License

This project uses PrusaSlicer, which is licensed under AGPLv3. See the `LICENSE` file for details. 
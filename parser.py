import re
import json
import sys
import os

def parse_gcode_summary(gcode_path):
    summary = {}
    with open(gcode_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            if line.startswith(';'):
                # Match lines like: ; filament used [mm] = 14122.04
                m = re.match(r';\s*([^=]+?)\s*=\s*(.*)', line)
                if m:
                    key = m.group(1).strip()
                    value = m.group(2).strip()
                    summary[key] = value
    return summary

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python parser.py <gcode_file>")
        sys.exit(1)
    gcode_file = sys.argv[1]
    summary = parse_gcode_summary(gcode_file)
    # Determine output path
    base, _ = os.path.splitext(gcode_file)
    output_path = base + '.json'
    with open(output_path, 'w', encoding='utf-8') as out_f:
        json.dump(summary, out_f, indent=2)
    print(f"Summary written to {output_path}")

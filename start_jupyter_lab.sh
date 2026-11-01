#!/bin/bash
set -e

# ===============================================
# SETUP
# ===============================================

absolute_file_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/$(basename -- "${BASH_SOURCE[0]}")"
absolute_directory_m0=$(dirname -- "$absolute_file_path")

source "$HOME/.bashrc"
LOG="$absolute_file_path.log"
exec 2>>"$LOG"

# ===============================================
# COMMANDS
# ===============================================

python="$absolute_directory_m0/venv/bin/python3"
jupyter_config="$absolute_directory_m0/.jupyter/jupyter_server_config.py"

cd "$absolute_directory_m0"
"$python" -m jupyter lab --config="$jupyter_config"

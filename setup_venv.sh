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

cd "$absolute_directory_m0"

# these commands are totally save to run again
venv_name="venv"
([ -d venv ] || python3 -m venv $venv_name) && source "$venv_name/bin/activate"

pip install -r requirements.txt

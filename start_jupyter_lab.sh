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

session_name=tut-audio-feature-extraction

# ===============================================
# FUNCTIONS
# ===============================================

# || true prevent errors from stopping the program
tmux new-session -A -d -s "$session_name" -c "$absolute_directory_m0" || true	
tmux_send_keys(){
	local command_string=$1
	tmux send-keys -t "$session_name" "$command_string 2>> $LOG" C-m
}

# ===============================================
# COMMANDS
# ===============================================

python="$absolute_directory_m0/venv/bin/python3"
jupyter_config="$absolute_directory_m0/.jupyter/jupyter_server_config.py"

echo "START $(date -Iseconds)" 1>> $LOG
tmux_send_keys "cd $absolute_directory_m0"
tmux_send_keys "$python -m jupyter lab --config=$jupyter_config"

tmux split-window -h -t "$session_name"
tmux_send_keys "htop"

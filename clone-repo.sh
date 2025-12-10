#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clone Repo
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Repo URL or user/repo" }
# @raycast.packageName Clone Git Repo

# Documentation:
# @raycast.description Clone Git Repository into ~/OM BANK/Repos and open in VS Code
# @raycast.author reece_stephenson
# @raycast.authorURL https://github.com/reece-stephenson

set -euo pipefail

repo="${1:-}"

if [ -z "$repo" ]; then
    echo "Error: No repository specified."
    echo "Usage: provide a repo URL (https://...) or a GitHub shorthand like user/repo"
    exit 1
fi

# Expand GitHub shorthand user/repo -> https://github.com/user/repo.git
if [[ "$repo" != *"://"* && "$repo" != *"@"* && "$repo" =~ ^[^/]+/[^/]+$ ]]; then
    repo="https://github.com/$repo.git"
fi

BASE_DIR="$HOME/OM BANK/Repos"

# Ensure target directory exists
mkdir -p "$BASE_DIR"

echo "Cloning into: $BASE_DIR"
cd "$BASE_DIR" || { echo "Failed to cd into $BASE_DIR"; exit 1; }

if git clone -- "$repo"; then
    echo "Clone succeeded."
else
    echo "Clone failed."
    exit 1
fi

# Determine cloned repo directory name and open in VS Code
repo_name="$(basename -s .git "$repo")"
target_dir="$BASE_DIR/$repo_name"

if [ -d "$target_dir" ]; then
    echo "Opening $target_dir in VS Code..."
    if command -v code >/dev/null 2>&1; then
        code "$target_dir" || echo "Failed to open with 'code' CLI."
    elif command -v open >/dev/null 2>&1; then
        open -a "Visual Studio Code" "$target_dir" || echo "Failed to open with 'open'."
    else
        echo "VS Code not found. Install the 'code' CLI or open $target_dir manually."
        exit 1
    fi
else
    echo "Warning: expected directory $target_dir not found. Cannot open in VS Code."
fi
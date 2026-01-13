#!/bin/bash
# Sync GEMINI.md from repository to ~/.gemini/
# This ensures global IDE rules are tracked in git

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_FILE="$REPO_ROOT/.antigravity/GEMINI.md"
TARGET_DIR="$HOME/.gemini"
TARGET_FILE="$TARGET_DIR/GEMINI.md"

# Ensure source exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Error: $SOURCE_FILE not found"
    exit 1
fi

# Create target directory if needed
mkdir -p "$TARGET_DIR"

# Backup existing file if it's not already a symlink to our source
if [ -f "$TARGET_FILE" ] && [ ! -L "$TARGET_FILE" ]; then
    BACKUP="$TARGET_FILE.backup.$(date +%Y%m%d%H%M%S)"
    mv "$TARGET_FILE" "$BACKUP"
    echo "📦 Backed up existing GEMINI.md to $BACKUP"
fi

# Remove existing symlink if it points elsewhere
if [ -L "$TARGET_FILE" ]; then
    CURRENT_TARGET=$(readlink "$TARGET_FILE")
    if [ "$CURRENT_TARGET" != "$SOURCE_FILE" ]; then
        rm "$TARGET_FILE"
        echo "🔄 Removed old symlink pointing to $CURRENT_TARGET"
    fi
fi

# Create symlink if needed
if [ ! -L "$TARGET_FILE" ]; then
    ln -s "$SOURCE_FILE" "$TARGET_FILE"
    echo "✅ Created symlink: $TARGET_FILE → $SOURCE_FILE"
else
    echo "✅ Symlink already correct: $TARGET_FILE → $SOURCE_FILE"
fi

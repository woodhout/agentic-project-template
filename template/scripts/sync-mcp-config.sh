#!/bin/bash

# Configuration
TEMPLATE=".antigravity/mcp_config.template.json"
TARGET="$HOME/.gemini/mcp-servers.json"

# Check if template exists
if [ ! -f "$TEMPLATE" ]; then
    echo "❌ Error: $TEMPLATE not found."
    exit 1
fi

# Ensure the target directory exists
mkdir -p "$(dirname "$TARGET")"

# Get GitHub token
if [ -n "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    GIT_TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN"
elif command -v gh &> /dev/null; then
    GIT_TOKEN=$(gh auth token 2>/dev/null)
fi

if [ -z "$GIT_TOKEN" ]; then
    echo "⚠️ Warning: GITHUB_PERSONAL_ACCESS_TOKEN not set and 'gh auth token' failed."
    echo "The generated config will contain placeholder '__GITHUB_TOKEN__'."
    GIT_TOKEN="__GITHUB_TOKEN__"
fi

# Replace placeholders and write to target (using | as delimiter for gho_ tokens)
sed "s|__GITHUB_TOKEN__|$GIT_TOKEN|g" "$TEMPLATE" > "$TARGET"

echo "✅ Synced MCP config: $TEMPLATE -> $TARGET"

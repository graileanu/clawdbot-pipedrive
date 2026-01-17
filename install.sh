#!/bin/bash
#
# clawdbot-pipedrive installer
# Installs the plugin and sets up the skill template
#

set -e

SKILL_DIR="$HOME/.clawdbot/skills/pipedrive"
SKILL_FILE="$SKILL_DIR/SKILL.md"
CONFIG_FILE="$HOME/.clawdbot/config.json"

echo "=== clawdbot-pipedrive installer ==="
echo

# 1. Install plugin
echo "[1/3] Installing plugin..."
if command -v clawdbot &> /dev/null; then
    clawdbot plugins install clawdbot-pipedrive
else
    echo "  clawdbot not found. Installing via npm..."
    npm install -g clawdbot-pipedrive
fi
echo "  Done."
echo

# 2. Set up skill template
echo "[2/3] Setting up skill template..."
mkdir -p "$SKILL_DIR"

if [ -f "$SKILL_FILE" ]; then
    echo "  $SKILL_FILE already exists. Skipping (not overwriting)."
    echo "  To update manually, see: https://github.com/graileanu/clawdbot-pipedrive/blob/master/examples/SKILL-TEMPLATE.md"
else
    # Download template from GitHub
    curl -sL "https://raw.githubusercontent.com/graileanu/clawdbot-pipedrive/master/examples/SKILL-TEMPLATE.md" -o "$SKILL_FILE"
    echo "  Created $SKILL_FILE"
    echo "  Edit this file to customize for your organization."
fi
echo

# 3. Config reminder
echo "[3/3] Configuration..."
echo "  Add to $CONFIG_FILE:"
echo
echo '  {
    "plugins": {
      "entries": {
        "clawdbot-pipedrive": {
          "enabled": true,
          "config": {
            "apiKey": "YOUR_PIPEDRIVE_API_KEY",
            "domain": "YOUR_COMPANY"
          }
        }
      }
    }
  }'
echo
echo "  Get your API key: Pipedrive > Settings > Personal preferences > API"
echo

echo "=== Installation complete ==="
echo
echo "Next steps:"
echo "  1. Add your Pipedrive config to ~/.clawdbot/config.json"
echo "  2. Customize ~/.clawdbot/skills/pipedrive/SKILL.md"
echo "  3. Restart clawdbot"

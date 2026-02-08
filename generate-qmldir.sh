#!/bin/bash
#
# Usage:
#   ./generate-qmldir.sh          # Generate with local paths for development
#   ./generate-qmldir.sh guest    # Restore /home/guest paths for live image

MODE="${1:-local}"

if [ "$MODE" = "guest" ]; then
    CONFIG_DIR="/home/guest/.config/quickshell/caelestia"
    echo "Restoring /home/guest paths for live image deployment..."
else
    CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/quickshell/caelestia"
    echo "Generating qmldir files for local development..."
fi

# Generate qs.services qmldir
cat > qs/services/qmldir << EOF
module qs.services
singleton Colours 1.0 file://${CONFIG_DIR}/services/Colours.qml
singleton Wallpapers 1.0 file://${CONFIG_DIR}/services/Wallpapers.qml
EOF

# Generate qs.config qmldir
cat > qs/config/qmldir << EOF
module qs.config
AppearanceConfig 1.0 file://${CONFIG_DIR}/config/AppearanceConfig.qml
singleton Appearance 1.0 file://${CONFIG_DIR}/config/Appearance.qml
BackgroundConfig 1.0 file://${CONFIG_DIR}/config/BackgroundConfig.qml
BarConfig 1.0 file://${CONFIG_DIR}/config/BarConfig.qml
BorderConfig 1.0 file://${CONFIG_DIR}/config/BorderConfig.qml
singleton Config 1.0 file://${CONFIG_DIR}/config/Config.qml
ControlCenterConfig 1.0 file://${CONFIG_DIR}/config/ControlCenterConfig.qml
DashboardConfig 1.0 file://${CONFIG_DIR}/config/DashboardConfig.qml
GeneralConfig 1.0 file://${CONFIG_DIR}/config/GeneralConfig.qml
LauncherConfig 1.0 file://${CONFIG_DIR}/config/LauncherConfig.qml
LockConfig 1.0 file://${CONFIG_DIR}/config/LockConfig.qml
NotifsConfig 1.0 file://${CONFIG_DIR}/config/NotifsConfig.qml
OsdConfig 1.0 file://${CONFIG_DIR}/config/OsdConfig.qml
ServiceConfig 1.0 file://${CONFIG_DIR}/config/ServiceConfig.qml
SessionConfig 1.0 file://${CONFIG_DIR}/config/SessionConfig.qml
SidebarConfig 1.0 file://${CONFIG_DIR}/config/SidebarConfig.qml
UserPaths 1.0 file://${CONFIG_DIR}/config/UserPaths.qml
UtilitiesConfig 1.0 file://${CONFIG_DIR}/config/UtilitiesConfig.qml
WInfoConfig 1.0 file://${CONFIG_DIR}/config/WInfoConfig.qml
EOF

# Generate qs.utils qmldir
cat > qs/utils/qmldir << EOF
module qs.utils
singleton Paths 1.0 file://${CONFIG_DIR}/utils/Paths.qml
Searcher 1.0 file://${CONFIG_DIR}/utils/Searcher.qml
EOF

# Generate qs.components qmldir
cat > qs/components/qmldir << EOF
module qs.components
MaterialIcon 1.0 file://${CONFIG_DIR}/components/MaterialIcon.qml
StyledText 1.0 file://${CONFIG_DIR}/components/StyledText.qml
StateLayer 1.0 file://${CONFIG_DIR}/components/StateLayer.qml
StyledRect 1.0 file://${CONFIG_DIR}/components/StyledRect.qml
EOF

# Update shell.qml to use appropriate paths
sed -i "s|/home/[^/]*/.config/quickshell/caelestia|${CONFIG_DIR}|g" shell.qml

echo ""
echo "✓ Generated qmldir files and updated shell.qml for: ${CONFIG_DIR}"

if [ "$MODE" = "guest" ]; then
    echo "✓ Ready to commit - all paths set to /home/guest"
else
    echo ""
    echo "⚠ NOTE: Do not commit these changes!"
    echo "  Run './generate-qmldir.sh guest' before committing."
fi

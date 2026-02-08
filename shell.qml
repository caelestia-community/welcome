//@ pragma Env QML2_IMPORT_PATH=.:/home/guest/.config/quickshell/caelestia/build/qml

import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    FontLoader {
        id: materialFont
        source: "file:///usr/share/fonts/ttf-material-symbols-variable/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf"
    }

    FloatingWindow {
        id: welcomeWindow
        
        implicitWidth: 1000
        implicitHeight: 650
        
        color: "transparent"
        
        Main {
            anchors.fill: parent
        }
    }
}

import QtQuick
import caelestia.welcome

Rectangle {
    id: root

    color: Colours.palette.m3surfaceContainer
    radius: Config.appearance.rounding.normal

    Behavior on color {
        CAnim {}
    }
}

import QtQuick
import QtQuick.Controls
import caelestia.welcome

ApplicationWindow {
    width: 1000
    height: 550
    visible: true
    title: qsTr("Welcome to Caelestia")

    color: Colours.palette.m3background

    StyledText {
        anchors.centerIn: parent
        text: `Welcome to Caelestia`
        font.pointSize: Config.appearance.font.size.extraLarge
        color: Colours.palette.m3onBackground
    }
}

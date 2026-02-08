import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 24

    Text {
        text: "Modules"
        font.pointSize: 28
        font.bold: true
        color: "#cdd6f4"
    }

    Text {
        Layout.fillWidth: true
        text: "Explore Caelestia's drawers, widgets, and modules"
        font.pointSize: 12
        color: "#a6adc8"
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 200
        radius: 12
        color: "#181825"

        Text {
            anchors.centerIn: parent
            text: "Content coming soon:\n• Drawer configuration\n• Widget customization\n• Module overview"
            font.pointSize: 11
            color: "#a6adc8"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Item { Layout.fillHeight: true }
}

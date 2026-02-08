import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 24

    Text {
        text: "Resources"
        font.pointSize: 28
        font.bold: true
        color: "#cdd6f4"
    }

    Text {
        Layout.fillWidth: true
        text: "Documentation, community, and support"
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
            text: "Content coming soon:\n• Documentation links\n• Community channels\n• Support resources"
            font.pointSize: 11
            color: "#a6adc8"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Item { Layout.fillHeight: true }
}

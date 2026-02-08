import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 24

    Text {
        text: "Appearance"
        font.pointSize: 28
        font.bold: true
        color: "#cdd6f4"
    }

    Text {
        Layout.fillWidth: true
        text: "Customize your shell's look and feel"
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
            text: "Content coming soon:\n• Shell theming\n• External app theming (GTK/Qt)"
            font.pointSize: 11
            color: "#a6adc8"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Item { Layout.fillHeight: true }
}

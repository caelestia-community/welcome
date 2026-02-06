import QtQuick
import QtQuick.Layouts
import caelestia.welcome

ColumnLayout {
    id: root

    spacing: Config.appearance.spacing.large

    StyledText {
        text: "Welcome to Caelestia"
        font.pointSize: Config.appearance.font.size.extraLarge
        color: Colours.palette.m3onBackground
    }

    StyledText {
        Layout.fillWidth: true
        text: "Caelestia is a modern, customisable desktop shell built with Quickshell."
        font.pointSize: Config.appearance.font.size.normal
        color: Colours.palette.m3onSurfaceVariant
        wrapMode: Text.WordWrap
        lineHeight: 1.4
    }

    SectionContainer {
        StyledText {
            text: "Getting Started"
            font.pointSize: Config.appearance.font.size.large
            color: Colours.palette.m3onSurface
        }

        StyledText {
            Layout.fillWidth: true
            text: "Caelestia is configured via a shell.json file located in your config directory."
            color: Colours.palette.m3onSurfaceVariant
            wrapMode: Text.WordWrap
            lineHeight: 1.3
        }

        RowLayout {
            spacing: Config.appearance.spacing.normal

            Rectangle {
                Layout.preferredWidth: 8
                Layout.preferredHeight: tipText.implicitHeight

                radius: Config.appearance.rounding.full
                color: Colours.palette.m3primary
            }

            StyledText {
                id: tipText

                Layout.fillWidth: true
                text: "Tip: This is a really cool tip"
                color: Colours.palette.m3onSurfaceVariant
                wrapMode: Text.WordWrap
                font.pointSize: Config.appearance.font.size.small
                lineHeight: 1.3
            }
        }
    }

    SectionContainer {
        StyledText {
            text: "Quick Links"
            font.pointSize: Config.appearance.font.size.large
            color: Colours.palette.m3onSurface
        }

        GridLayout {
            Layout.fillWidth: true

            columns: 2
            rowSpacing: Config.appearance.spacing.small
            columnSpacing: Config.appearance.spacing.normal

            Repeater {
                model: [
                    { label: "GitHub", url: "https://github.com/caelestia-dots/caelestia", icon: "open_in_new" },
                    { label: "Docs", url: "https://github.com/caelestia-dots/caelestia", icon: "description" },
                    { label: "Report an Issue", url: "https://github.com/caelestia-dots/caelestia/issues", icon: "bug_report" },
                    { label: "Community Discord", url: "https://discord.gg/ZdJ9Kxzu", icon: "forum" }
                ]

                Rectangle {
                    id: linkDelegate

                    required property var modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: 40

                    radius: Config.appearance.rounding.small
                    color: linkMouse.containsMouse
                        ? Colours.palette.m3surfaceContainerHighest
                        : Colours.palette.m3surfaceContainerHigh

                    Behavior on color { CAnim {} }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: Config.appearance.padding.normal
                        anchors.rightMargin: Config.appearance.padding.normal
                        spacing: Config.appearance.spacing.small

                        StyledText {
                            text: linkDelegate.modelData.icon
                            font.family: Config.appearance.font.family.material
                            font.pointSize: Config.appearance.font.size.normal
                            color: Colours.palette.m3primary
                        }

                        StyledText {
                            Layout.fillWidth: true
                            text: linkDelegate.modelData.label
                            color: Colours.palette.m3onSurface
                        }
                    }

                    MouseArea {
                        id: linkMouse

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Qt.openUrlExternally(linkDelegate.modelData.url)
                    }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}

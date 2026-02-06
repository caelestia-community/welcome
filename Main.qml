import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import caelestia.welcome

ApplicationWindow {
    id: root

    width: 1000
    height: 600
    visible: true
    title: qsTr("Welcome to Caelestia")

    color: Colours.palette.m3background

    property int currentSection: 0

    readonly property var sections: [
        { name: "Welcome", icon: "waving_hand" },
        { name: "Appearance", icon: "palette" },
    ]

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 200

            color: Colours.palette.m3surfaceContainer

            Behavior on color { CAnim {} }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Config.appearance.padding.normal
                spacing: Config.appearance.spacing.small

                // Logo
                RowLayout {
                    Layout.leftMargin: Config.appearance.padding.small
                    Layout.bottomMargin: Config.appearance.spacing.normal
                    spacing: Config.appearance.spacing.normal

                    StyledText {
                        text: "Caelestia"
                        font.pointSize: Config.appearance.font.size.larger
                        font.bold: true
                        color: Colours.palette.m3onSurface
                    }
                }

                // Nav items
                Repeater {
                    model: root.sections

                    Rectangle {
                        id: navItem

                        required property int index
                        required property var modelData

                        Layout.fillWidth: true
                        Layout.preferredHeight: 40

                        radius: Config.appearance.rounding.small
                        color: root.currentSection === navItem.index
                            ? Colours.palette.m3primary
                            : navMouse.containsMouse
                                ? Colours.palette.m3surfaceContainerHigh
                                : "transparent"

                        Behavior on color { CAnim {} }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: Config.appearance.padding.normal
                            anchors.rightMargin: Config.appearance.padding.normal
                            spacing: Config.appearance.spacing.small

                            StyledText {
                                text: navItem.modelData.icon
                                font.family: Config.appearance.font.family.material
                                font.pointSize: Config.appearance.font.size.normal
                                color: root.currentSection === navItem.index
                                    ? Colours.palette.m3onPrimary
                                    : Colours.palette.m3onSurfaceVariant
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: navItem.modelData.name
                                color: root.currentSection === navItem.index
                                    ? Colours.palette.m3onPrimary
                                    : Colours.palette.m3onSurface
                            }
                        }

                        MouseArea {
                            id: navMouse

                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.currentSection = navItem.index
                        }
                    }
                }

                Item { Layout.fillHeight: true }

            }
        }

        // Separator
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1

            color: Colours.palette.m3outline
        }

        // Content area
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentHeight: contentLoader.item ? contentLoader.item.implicitHeight + Config.appearance.padding.large * 2 : 0
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            Loader {
                id: contentLoader

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Config.appearance.padding.large

                sourceComponent: {
                    switch (root.currentSection) {
                    case 0: return welcomeComponent;
                    case 1: return appearanceComponent;
                    default: return welcomeComponent;
                    }
                }
            }
        }
    }

    Component {
        id: welcomeComponent
        WelcomeSection {}
    }

    Component {
        id: appearanceComponent
        AppearanceSection {}
    }
}

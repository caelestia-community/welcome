import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import qs.config
import qs.components as Caelestia
import "components"
import "pages/Welcome"
import "pages/GettingStarted"
import "pages/Appearance"
import "pages/Modules"
import "pages/Resources"

Rectangle {
    id: root

    property int currentPage: 0

    readonly property var pages: [
        { name: "Welcome", icon: "waving_hand" },
        { name: "Getting Started", icon: "rocket_launch" },
        { name: "Appearance", icon: "palette" },
        { name: "Modules", icon: "widgets" },
        { name: "Resources", icon: "help" },
    ]

    color: Colours.palette.m3background

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 220
            
            color: Colours.palette.m3surfaceContainer

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 8

                // Logo/Title
                RowLayout {
                    Layout.leftMargin: 8
                    Layout.bottomMargin: 16
                    spacing: 12

                    Text {
                        text: "Caelestia"
                        font.pointSize: 18
                        font.bold: true
                        color: Colours.palette.m3onSurface
                    }
                }

                // Navigation buttons
                Repeater {
                    model: root.pages

                    NavButton {
                        Layout.fillWidth: true
                        text: modelData.name
                        icon: modelData.icon
                        active: root.currentPage === index
                        onClicked: root.currentPage = index
                    }
                }

                Item { Layout.fillHeight: true }

                // Close button
                NavButton {
                    Layout.fillWidth: true
                    text: "Close"
                    icon: "close"
                    onClicked: Qt.quit()
                }
            }
        }

        // Separator
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: Colours.palette.m3outlineVariant
        }

        // Content area with vertical scrolling animation
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                id: pagesLayout
                
                width: parent.width
                spacing: 0
                y: -root.currentPage * parent.height

                Behavior on y {
                    NumberAnimation {
                        duration: Appearance.anim.durations.normal
                        easing.type: Easing.OutCubic
                    }
                }

                // Welcome page
                Item {
                    Layout.fillWidth: true
                    implicitHeight: root.height

                    Flickable {
                        anchors.fill: parent
                        anchors.margins: 32
                        contentHeight: welcomeLoader.item ? welcomeLoader.item.implicitHeight : 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true

                        Loader {
                            id: welcomeLoader
                            anchors.left: parent.left
                            anchors.right: parent.right
                            sourceComponent: welcomeComponent
                        }
                    }
                }

                // Getting Started page
                Item {
                    Layout.fillWidth: true
                    implicitHeight: root.height

                    Flickable {
                        anchors.fill: parent
                        anchors.margins: 32
                        contentHeight: gettingStartedLoader.item ? gettingStartedLoader.item.implicitHeight : 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true

                        Loader {
                            id: gettingStartedLoader
                            anchors.left: parent.left
                            anchors.right: parent.right
                            sourceComponent: gettingStartedComponent
                        }
                    }
                }

                // Appearance page
                Item {
                    Layout.fillWidth: true
                    implicitHeight: root.height

                    Flickable {
                        anchors.fill: parent
                        anchors.margins: 32
                        contentHeight: appearanceLoader.item ? appearanceLoader.item.implicitHeight : 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true

                        Loader {
                            id: appearanceLoader
                            anchors.left: parent.left
                            anchors.right: parent.right
                            sourceComponent: appearanceComponent
                        }
                    }
                }

                // Modules page
                Item {
                    Layout.fillWidth: true
                    implicitHeight: root.height

                    Flickable {
                        anchors.fill: parent
                        anchors.margins: 32
                        contentHeight: modulesLoader.item ? modulesLoader.item.implicitHeight : 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true

                        Loader {
                            id: modulesLoader
                            anchors.left: parent.left
                            anchors.right: parent.right
                            sourceComponent: modulesComponent
                        }
                    }
                }

                // Resources page
                Item {
                    Layout.fillWidth: true
                    implicitHeight: root.height

                    Flickable {
                        anchors.fill: parent
                        anchors.margins: 32
                        contentHeight: resourcesLoader.item ? resourcesLoader.item.implicitHeight : 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true

                        Loader {
                            id: resourcesLoader
                            anchors.left: parent.left
                            anchors.right: parent.right
                            sourceComponent: resourcesComponent
                        }
                    }
                }
            }
        }
    }

    Component {
        id: welcomeComponent
        Welcome {}
    }

    Component {
        id: gettingStartedComponent
        GettingStarted {}
    }

    Component {
        id: appearanceComponent
        Appearance {}
    }

    Component {
        id: modulesComponent
        Modules {}
    }

    Component {
        id: resourcesComponent
        Resources {}
    }
}

import QtQuick
import QtQuick.Layouts
import Caelestia
import caelestia.welcome

ColumnLayout {
    id: root

    spacing: Config.appearance.spacing.large

    StyledText {
        text: "Appearance"
        font.pointSize: Config.appearance.font.size.extraLarge
        color: Colours.palette.m3onBackground
    }

    StyledText {
        Layout.fillWidth: true
        text: "Preview your current colour scheme and wallpaper analysis powered by the Caelestia ImageAnalyser plugin."
        font.pointSize: Config.appearance.font.size.normal
        color: Colours.palette.m3onSurfaceVariant
        wrapMode: Text.WordWrap
        lineHeight: 1.4
    }

    SectionContainer {
        alignTop: true

        RowLayout {
            spacing: Config.appearance.spacing.large

            Rectangle {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 140

                radius: Config.appearance.rounding.small
                color: Colours.palette.m3surfaceContainerHigh
                clip: true

                Image {
                    anchors.fill: parent

                    source: {
                        const wp = Colours.getWallpaperPath();
                        return wp ? `file://${wp}` : "";
                    }
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                }

                StyledText {
                    anchors.centerIn: parent

                    text: "No wallpaper"
                    visible: !Colours.getWallpaperPath()
                    color: Colours.palette.m3onSurfaceVariant
                }
            }

            // Analysis info
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Config.appearance.spacing.normal

                StyledText {
                    text: "Wallpaper Analysis"
                    font.pointSize: Config.appearance.font.size.large
                    color: Colours.palette.m3onSurface
                }

                StyledText {
                    Layout.fillWidth: true
                    text: {
                        const wp = Colours.getWallpaperPath();
                        return wp ? wp.split("/").pop() : "None";
                    }
                    color: Colours.palette.m3onSurfaceVariant
                    elide: Text.ElideMiddle
                }

                ColumnLayout {
                    spacing: 2

                    StyledText {
                        text: "Wallpaper Luminance"
                        font.pointSize: Config.appearance.font.size.small
                        color: Colours.palette.m3onSurfaceVariant
                    }

                    RowLayout {
                        spacing: Config.appearance.spacing.small

                        Rectangle {
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 8

                            radius: Config.appearance.rounding.full
                            color: Colours.palette.m3surfaceContainerHighest

                            Rectangle {
                                width: parent.width * Colours.wallLuminance
                                height: parent.height

                                radius: parent.radius
                                color: Colours.palette.m3primary
                            }
                        }

                        StyledText {
                            text: Colours.wallLuminance.toFixed(3)
                            font.family: Config.appearance.font.family.mono
                            color: Colours.palette.m3onSurface
                        }
                    }
                }

                RowLayout {
                    spacing: Config.appearance.spacing.small

                    Rectangle {
                        Layout.preferredWidth: 12
                        Layout.preferredHeight: 12

                        radius: Config.appearance.rounding.full
                        color: Colours.palette.mode === "dark" ? "#b0b0b0" : "#ffd54f"
                    }

                    StyledText {
                        text: `Mode: ${Colours.palette.mode}`
                        font.pointSize: Config.appearance.font.size.small
                        color: Colours.palette.m3onSurfaceVariant
                    }
                }
            }
        }
    }

    SectionContainer {
        StyledText {
            text: "Colour Palette"
            font.pointSize: Config.appearance.font.size.large
            color: Colours.palette.m3onSurface
        }

        GridLayout {
            Layout.fillWidth: true

            columns: 4
            rowSpacing: Config.appearance.spacing.small
            columnSpacing: Config.appearance.spacing.small

            Repeater {
                model: [
                    { name: "Primary", color: Colours.palette.m3primary, onColor: Colours.palette.m3onPrimary },
                    { name: "Secondary", color: Colours.palette.m3secondary, onColor: Colours.palette.m3onSecondary },
                    { name: "Tertiary", color: Colours.palette.m3tertiary, onColor: Colours.palette.m3onTertiary },
                    { name: "Surface", color: Colours.palette.m3surface, onColor: Colours.palette.m3onSurface },
                    { name: "Background", color: Colours.palette.m3background, onColor: Colours.palette.m3onBackground },
                    { name: "Container", color: Colours.palette.m3surfaceContainer, onColor: Colours.palette.m3onSurface },
                    { name: "Container High", color: Colours.palette.m3surfaceContainerHigh, onColor: Colours.palette.m3onSurface },
                    { name: "Outline", color: Colours.palette.m3outline, onColor: Colours.palette.m3background }
                ]

                Rectangle {
                    id: colourDelegate

                    required property var modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: 56

                    radius: Config.appearance.rounding.small
                    color: colourDelegate.modelData.color
                    border.width: 1
                    border.color: Colours.palette.m3outline

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 1

                        StyledText {
                            Layout.alignment: Qt.AlignHCenter
                            text: colourDelegate.modelData.name
                            font.pointSize: Config.appearance.font.size.small
                            color: colourDelegate.modelData.onColor
                        }

                        StyledText {
                            Layout.alignment: Qt.AlignHCenter
                            text: colourDelegate.modelData.color.toString().toUpperCase()
                            font.family: Config.appearance.font.family.mono
                            font.pointSize: 9
                            color: colourDelegate.modelData.onColor
                        }
                    }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}

import QtQuick
import QtQuick.Layouts
import caelestia.welcome

StyledRect {
    id: root

    default property alias content: contentColumn.data
    property real contentSpacing: Config.appearance.spacing.larger
    property bool alignTop: false

    Layout.fillWidth: true
    implicitHeight: contentColumn.implicitHeight + Config.appearance.padding.large * 2

    radius: Config.appearance.rounding.normal
    color: Config.appearance.transparency.enabled ? Colours.layer(Colours.palette.m3surfaceContainer, 2) : Colours.palette.m3surfaceContainerHigh

    ColumnLayout {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: root.alignTop ? parent.top : undefined
        anchors.verticalCenter: root.alignTop ? undefined : parent.verticalCenter
        anchors.margins: Config.appearance.padding.large

        spacing: root.contentSpacing
    }
}
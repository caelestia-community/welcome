pragma ComponentBehavior: Bound

import QtQuick
import caelestia.welcome

Text {
    id: root

    property bool animate: false
    property string animateProp: "scale"
    property real animateFrom: 0
    property real animateTo: 1
    property int animateDuration: 400

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Colours.palette.m3onSurface
    font.family: Config.appearance.font.family.sans
    font.pointSize: Config.appearance.font.size.smaller

    Behavior on color {
        CAnim {}
    }

    Behavior on text {
        enabled: root.animate

        SequentialAnimation {
            Anim {
                to: root.animateFrom
                easing.bezierCurve: Config.appearance.anim.curves.StandardAccel
            }
            PropertyAction{}
            Anim {
                to: root.animateTo
                easing.bezierCurve: Config.appearance.anim.curves.standardDecel
            }
        }
    }

    component Anim: NumberAnimation {
        target: root
        property: root.animateProp
        duration: root.animateDuration / 2
        easing.type: Easing.BezierSpline
    }
}
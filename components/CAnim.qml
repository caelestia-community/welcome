import QtQuick
import caelestia.welcome

ColorAnimation {
    duration: Config.appearance.durations.normal
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Config.appearance.anim.curves.standard
}
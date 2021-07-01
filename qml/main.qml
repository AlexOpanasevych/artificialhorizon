import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Artificial Horizon")

    AircraftRoadmap {
        anchors.fill: parent
    }

    ArtificialHorizon {
        id: hud
        width: parent.width / 6
        height: width
        roll: aircraft.roll
        pitch: aircraft.pitch

        Drag.active: true
    }

    MouseArea {
        anchors.fill: hud
        drag.target: hud
        preventStealing: true
    }

    ParametersForm {
        id: form
        anchors.right: parent.right
        height: 200
        width: 150

        onRollChanged: aircraft.roll = roll
        onPitchChanged: aircraft.pitch = pitch
        onYawChanged: aircraft.yaw = yaw
    }

}

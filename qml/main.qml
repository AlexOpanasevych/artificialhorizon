import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Artificial Horizon")




//    HorizonBackground {
//        anchors.fill: parent
//    }

    ArtificialHorizon {
        anchors.fill: parent
        roll: aircraft.roll
        pitch: aircraft.pitch
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

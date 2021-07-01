import QtQuick 2.0

/*
    \qmltype HorizonBackground
    \inherits Item
    \brief Displays artificial horizon background
*/
Item {
    id: root
    property alias roll: root.rotation
    readonly property int pitchScale: 30
    property double scaleCoefficient: 1
    property int pitch: 0
    antialiasing: true
    smooth: true

    Item {
        width:  parent.width  * 4
        height: parent.height * 8
        anchors.centerIn: parent
        Rectangle {
            id: firstPart
            height: parent.height / 2 + pitch / pitchScale * root.height / 2 / scaleCoefficient
            width: parent.width
            gradient: Gradient {
                GradientStop { position: 0.25; color: Qt.hsla(0.6, 1.0, 0.25) }
                GradientStop { position: 0.5;  color: Qt.hsla(0.6, 0.5, 0.55) }
            }
        }
        Rectangle {
            id: secondPart
            height: parent.height / 2 - pitch / pitchScale * root.height / 2 / scaleCoefficient
            anchors {
                left:   firstPart.left;
                right:  firstPart.right;
                top: firstPart.bottom
            }
            gradient: Gradient {
                GradientStop { position: 0.0;  color: "#A95200" }
                GradientStop { position: 1; color: "#4F1B03" }
            }
        }

    }

}

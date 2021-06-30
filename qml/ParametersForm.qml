import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2

/*
    \qmltype ParametersForm
    \inherits ColumnLayout
    \brief Displays parameters of artificial horizon such as roll, pitch, yaw and spinboxes to adjust them
*/
ColumnLayout {
    id: formLayout

    property alias roll: rollInput.value
    property alias pitch: pitchInput.value
    property alias yaw: yawInput.value


    RowLayout {
        Layout.fillWidth: true
        Layout.margins: 5
        Label {
            Layout.fillWidth: true
            Layout.preferredWidth: 20
            text: "Roll:"
        }
        SpinBox {
            id: rollInput
            Layout.fillWidth: true
            from: -180
            to: 180
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.margins: 5
        Label {
            Layout.fillWidth: true
            Layout.preferredWidth: 20
            text: "Pitch:"
        }

        SpinBox {
            id: pitchInput
            Layout.fillWidth: true
            from: -180
            to: 180
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.margins: 5
        Label {
            Layout.fillWidth: true
            Layout.preferredWidth: 20
            text: "Yaw:"
        }

        SpinBox {
            id: yawInput
            Layout.fillWidth: true
            from: -180
            to: 180
        }
    }
}

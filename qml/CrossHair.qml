import QtQuick 2.15
import QtQuick.Shapes 1.15

/*
    \qmltype CrossHair
    \inherits Item
    \brief Displays cross hair of artificial indicator
*/

Item {
    id: root
    property int gap: 4
    antialiasing: true
    smooth: true
    layer.samples: 32
    Shape {
        anchors.fill: parent
        ShapePath {
            strokeColor: "#2f2f2f"
            strokeWidth: 1.3
            fillGradient: LinearGradient {
                x1: 0; y1: height / 2 - root.gap
                x2: 0; y2: height / 2 + root.gap
                GradientStop {position: 0; color: "#e7e770"}
                GradientStop {position: 0.7; color: "#9aa037"}
                GradientStop {position: 1; color: "#9aa100"}
            }

            startX: 0; startY: height / 2 - root.gap
            PathLine { x: 0; y: height / 2 + root.gap }
            PathLine { x: width / 6 - 1.5 * root.gap; y: height / 2 + root.gap }
            PathLine { x: width / 6; y: height / 2 }
            PathLine { x: width / 6 - 1.5 * root.gap; y: height / 2 - root.gap }
            PathLine { x: 0; y: height / 2 - root.gap}
        }

        ShapePath {
            strokeColor: "#2f2f2f"
            strokeWidth: 1.3

            fillGradient: LinearGradient {
                x1: width - width / 6 + 1.5 * root.gap; y1: height / 2 - root.gap
                x2: width - width / 6 + 1.5 * root.gap; y2: height / 2 + root.gap
                GradientStop {position: 0; color: "#e7e770"}
                GradientStop {position: 0.7; color: "#9aa037"}
                GradientStop {position: 1; color: "#9aa100"}
            }

            startX: width; startY: height / 2 - root.gap
            PathLine { x: width; y: height / 2 + root.gap }
            PathLine { x: width - width / 6 + 1.5 * root.gap; y: height / 2 + root.gap }
            PathLine { x: width - width / 6; y: root.height / 2 }
            PathLine { x: width - width / 6 + 1.5 * root.gap; y: height / 2 - root.gap }
            PathLine { x: width; y: height / 2 - root.gap}
        }

        ShapePath {
            strokeColor: "#2f2f2f"
            strokeWidth: 1.3

            fillGradient: LinearGradient {
                x1: width / 2; y1: height / 2
                x2: width / 2; y2: height / 2 + 15
                GradientStop {position: 0; color: "#e7e770"}
                GradientStop {position: 0.7; color: "#9aa037"}
                GradientStop {position: 1; color: "#9aa100"}
            }

            startX: width / 2; startY: height / 2
            PathLine { x: width / 3.5; y: height / 2 + 25 }
            PathLine { x: width / 2; y: height / 2 + 2 * root.gap }
            PathLine { x: width - width / 3.5; y: height / 2 + 25 }
            PathLine { x: width / 2; y: height / 2}
        }

    }
}

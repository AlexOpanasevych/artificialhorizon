import QtQuick 2.0

/*
    \qmltype RollPointer
    \inherits Item
    \brief Displays roll pointer that points to value on roll graticule
*/
Item {
    property color pointerColor: "white"
    height: width
    Canvas{
        anchors.fill:parent

        onPaint:{
            var context = getContext("2d");

            // the triangle
            context.beginPath();
            context.moveTo(width / 2, 0);
            context.lineTo(width / 4, height);
            context.lineTo(width * 0.75, height);
            context.closePath();

            // the fill color
            context.fillStyle = pointerColor;
            context.fill();
        }
    }
}

import QtQuick 2.0

/*
    \qmltype RollRuler
    \inherits Rectangle
    \brief Displays whole artificial horizon depending on values of pitch, roll and yaw
*/
Item {
    id: main

    property int roll: 0
    property int pitch: 0
    clip: true
    Rectangle {

        radius: width / 2
        anchors.fill: parent


        HorizonBackground {
            anchors.fill: parent
            scaleCoefficient: 2
            roll: main.roll
            pitch: main.pitch
        }
    }

    Canvas {
        id: root
        property double roll:  parent.roll
        property double pitch: parent.pitch
        property double pitchScale: 30

        anchors.centerIn: parent
        height: parent.height / 2
        width: parent.width

        implicitWidth: 200; implicitHeight: 200

        antialiasing: true
        smooth: true

        /*!
          \brief Returns sign of given number \p x
        */
        function sign(x) {
            return x > 0 ? 1 : -1
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.save()

            ctx.clearRect(0, 0, width, height)

            var ovlpitch = pitch;

            var w2 = width / 2
            var h2 = height / 2
            var scpitch = ovlpitch
            if (scpitch > 150) scpitch -= 180
            if (scpitch < -150) scpitch += 180
            var h = -scpitch / pitchScale * h2
            console.log('scpitch', scpitch)

            ctx.translate(w2, h2)
            ctx.rotate(roll * Math.PI / 180)

            if (!((scpitch > pitchScale) || (scpitch < -pitchScale))) {
                ctx.beginPath()
                ctx.moveTo(-h2, -h); ctx.lineTo(h2, -h)
                ctx.strokeStyle = 'white'
                ctx.stroke()
            }

            ctx.strokeStyle = 'white'
            ctx.fillStyle = 'white'
            ctx.font = '12px Arial'
            drawPitchMarks(ctx, h2 / pitchScale, h2, ovlpitch)
            ctx.restore()
        }

        /*!
           \brief Draws marks, depending which pitch value is set
        */
        function drawPitchMarks(ctx, pxPerDegree, radius, ovlpitch) {
            var dp = ovlpitch + pitchScale
            var pmax = Math.ceil(dp / 2.5) * 2.5
            var ymax = ovlpitch * pxPerDegree - pmax * pxPerDegree

            console.log('dp',dp, 'pmax', pmax, 'ymax', ymax)

            for (var y = ymax, p = pmax; y < radius; y += 2.5 * pxPerDegree, p -= 2.5) {
                if (p === 180 || p === 0 || p === -180)
                    continue


                var pp = p
                if (pp > 180)
                    pp -= 360
                if (pp < -180)
                    pp += 360

                var w = 10

                if (pp % 10 == 0) {
                    ctx.fillText(pp, 45, y + 4)
                    ctx.beginPath()
                    var gap = 4
                    if(pp < 0) {
                        ctx.moveTo(-3.5 * w, y - gap); ctx.lineTo(-3.5 * w, y)
                        ctx.moveTo(-3.5 * w, y); ctx.lineTo(3.5 * w, y)
                        ctx.moveTo(3.5 * w, y); ctx.lineTo(3.5 * w, y - gap)

                    }
                    else {
                        ctx.moveTo(-3.5 * w, y + gap); ctx.lineTo(-3.5 * w, y)
                        ctx.moveTo(-3.5 * w, y); ctx.lineTo(3.5 * w, y)
                        ctx.moveTo(3.5 * w, y); ctx.lineTo(3.5 * w, y + gap)
                    }
                }
                else {
                    ctx.beginPath()
                    ctx.moveTo(-2 * w, y); ctx.lineTo(2 * w, y)
                }
                ctx.stroke()

            }
        }

        onRollChanged: root.requestPaint()
        onPitchChanged: root.requestPaint()
    }

    Item { //Roll Indicator

        id: rollIndicator
        width: parent.width
        height: parent.height / 2
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        z: 1

        Image {
            id: rollGraticule
            source: "resources/rollGraticule.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            transformOrigin: Image.Bottom
            fillMode: Image.PreserveAspectFit
            smooth: true
            antialiasing: true
            rotation: -roll
            width: parent.width
            height: parent.height
        }

        RollPointer {
            width: 15
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            y: rollGraticule.y + 25
        }


    }

    CrossHair {
        width: 100
        height: 10
        anchors.centerIn: parent
    }
}


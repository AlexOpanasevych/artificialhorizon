import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Map {
    id: map
    plugin: Plugin {
        name: "osm"
    }
    center: QtPositioning.coordinate(50.45067064718528, 30.52481358327688)
    copyrightsVisible: false
    zoomLevel: 13
    Drag.active: true

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: {
            if(mouse.button === Qt.RightButton) {
                var coords = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                console.log(coords)
                aircraft.pointsModel.push_back({'xCoord': coords.latitude, 'yCoord': coords.longitude})
                route.addCoordinate(coords)
            }
        }
    }

    MapPolyline {
        id: route
        line.width: 2
        line.color: 'green'
        antialiasing: true
        smooth: true
    }

    MapItemView {
        id: view
        model: aircraft.pointsModel
        delegate: MapQuickItem {
            id: mapItem
            coordinate: QtPositioning.coordinate(xCoord, yCoord)

            anchorPoint.x: image.width * 0.5
            anchorPoint.y: image.height

            sourceItem: Item {
                height: image.height
                width: image.width
                MouseArea {
                    drag.target: mapItem
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    preventStealing: true
                    cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.OpenHandCursor
                    Column {
                        anchors.fill: parent
                        Image { id: image; height: 30; width: 30; source: "resources/marker.png"; fillMode: Qt.KeepAspectRatio}
                        Text { text: index; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter}
                    }

                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            contextMenu.popup()
                        }
                    }

                    onPressed: {
                        if (mouse.button === Qt.RightButton)
                            contextMenu.popup()
                    }

                    onPositionChanged: {
                        if(drag.active) {
                            aircraft.pointsModel.setLineData({'xCoord':mapItem.coordinate.latitude, 'yCoord': mapItem.coordinate.longitude},index)
                            var path = route.path
                            path[index].latitude = mapItem.coordinate.latitude
                            path[index].longitude = mapItem.coordinate.longitude
                            route.path = path
                        }
                    }
                }

            }

            Menu {
                id: contextMenu
                MenuItem {
                    visible: index > 0 && index < aircraft.pointsModel.size
                    enabled: visible
                    text: "Add before" + aircraft.pointsModel.size
                    onTriggered: {
                        contextMenu.addPointBefore(index)
                    }
                }
                MenuItem {
                    visible: (index > -1) && (index < aircraft.pointsModel.size - 1)
                    enabled: visible
                    text: "Add after"
                    onTriggered: {
                        contextMenu.addPointAfter(index)
                    }
                }
                MenuItem {
                    text: "Delete"
                    onTriggered: {

                        contextMenu.removePoint(index)
                    }
                }

                function removePoint(index) {
                    aircraft.pointsModel.remove(index)
                    route.removeCoordinate(index)
                }

                function addPointBefore(index) {
//                    if(index > 0 && index < count) {
                        console.log(count)
                        var x = aircraft.pointsModel.value(index - 1, 'xCoord')
                        var y = aircraft.pointsModel.value(index - 1, 'yCoord')
                        var newPointX = (x + mapItem.coordinate.latitude) / 2
                        var newPointY = (y + mapItem.coordinate.longitude) / 2
                        aircraft.pointsModel.insert(index, {'xCoord': newPointX, 'yCoord': newPointY})
                        route.insertCoordinate(index, QtPositioning.coordinate(newPointX, newPointY))
//                    }
                }

                function addPointAfter(index) {
//                    if(index > -1 && index < count - 1) {
                        console.log(count)
                        var x = aircraft.pointsModel.value(index + 1, 'xCoord')
                        var y = aircraft.pointsModel.value(index + 1, 'yCoord')
                        var newPointX = (x + mapItem.coordinate.latitude) / 2
                        var newPointY = (y + mapItem.coordinate.longitude) / 2
                        aircraft.pointsModel.insert(index + 1, {'xCoord': newPointX, 'yCoord': newPointY})
                        route.insertCoordinate(index + 1, QtPositioning.coordinate(newPointX, newPointY))
//                    }
                }


            }



        }
    }




}

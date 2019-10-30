import QtQuick 2.12
import QtQuick.Controls 2.12

TResizeBorder {
    id: root
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    readonly property int borderMargin: 6
    readonly property int rotateHandleDistance: 25
    property var controller: parent
    property alias dragEnabled: dragItem.enabled

    signal clicked(real x, real y)
    signal doubleClicked(real x, real y)
    //big
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: "transparent"
        radius: borderMargin
        anchors.fill: parent
        anchors.margins: borderMargin
    }
    //line to rotateHandle and Border
    Rectangle {
        color: gConfig.rotateHandleColor
        width: 2
        height: rotateHandleDistance
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: -rotateHandleDistance
        }
    }
    //top
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    }
    //bottom
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
    //left
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }
    //right
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
    //top left
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            left: parent.left
        }
    }
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            right: parent.right
        }
    }
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
    }
    Rectangle {
        border.color: gConfig.borderColor
        border.width:  1
        color: gConfig.borderBackgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
    }

    Rectangle {
        color: gConfig.rotateHandleColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: -rotateHandleDistance
        }
        Image {
            id: rotateCursor
            source: "qrc:/image/rotate.svg"
            width: sourceSize.width
            height: sourceSize.height
            visible: rotateArea.containsMouse | rotateArea.pressed
            x: rotateArea.mouseX - width  / 2
            y: rotateArea.mouseY - height / 2
        }
        MouseArea {
            id: rotateArea
            anchors.centerIn: parent
            width: parent.width * 2
            height: parent.height * 2
            hoverEnabled: true
            property int lastX: 0
            onContainsMouseChanged: {
                if (containsMouse) {
                    cursorShape = Qt.BlankCursor;
                } else {
                    cursorShape = Qt.ArrowCursor;
                }
            }
            onPressedChanged: {
                if (containsPress) {
                    lastX = mouseX;
                }
            }
            onPositionChanged: {
                if (pressed) {
                    let t = controller.rotation +(mouseX - lastX) / 5
                    t = t % 360
                    controller.rotation = t
                }
            }
        }
        ToolTip {
            id: toolTip
            x: rotateArea.mouseX + 30
            y: rotateArea.mouseY
            visible: rotateArea.pressed
            contentItem: Text {
                text: parseInt(controller.rotation) + "°"
            }
        }
    }
    MouseArea {
        id: dragItem
        anchors.fill: parent
        anchors.margins: borderMargin * 2
        cursorShape: Qt.PointingHandCursor
        drag.target: controller
        onClicked: {
            root.clicked(x, y)
        }
        onDoubleClicked: {
            root.doubleClicked(x, y)
        }
    }
}

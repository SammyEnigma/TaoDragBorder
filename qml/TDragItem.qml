import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root
    property alias containsMouse: mouseArea.containsMouse
    signal posChange(int xOffset, int yOffset)
    implicitWidth: 12
    implicitHeight: 12
    property int posType: Qt.ArrowCursor
    readonly property int posLeftTop: Qt.SizeFDiagCursor
    readonly property int posLeft: Qt.SizeHorCursor
    readonly property int posLeftBottom: Qt.SizeBDiagCursor
    readonly property int posTop: Qt.SizeVerCursor
    readonly property int posBottom: Qt.SizeVerCursor
    readonly property int posRightTop: Qt.SizeBDiagCursor
    readonly property int posRight: Qt.SizeHorCursor
    readonly property int posRightBottom: Qt.SizeFDiagCursor

    property alias mouseAreaObject: mouseArea
    signal clicked(real x, real y)
    signal doubleClicked(real x, real y)
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property int lastX: 0
        property int lastY: 0
        onContainsMouseChanged: {
            if (containsMouse) {
                cursorShape = posType;
            } else {
                cursorShape = Qt.ArrowCursor;
            }
        }
        onPressedChanged: {
            if (containsPress) {
                lastX = mouseX;
                lastY = mouseY;
            }
        }
        onPositionChanged: {
            if (pressed) {
                posChange(mouseX - lastX, mouseY - lastY)
            }
        }
        onClicked: {
            root.clicked(mouseX, mouseY)
        }
        onDoubleClicked: {
            root.doubleClicked(mouseX, mouseY)
        }
    }
}

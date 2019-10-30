import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello Drag")
    color: "gray"
    GConfig {
        id: gConfig
    }
    //写在最前面,焦点吸收器
    MouseArea {
        anchors.fill: parent
        onClicked: {
            focus = true
        }
    }
    Rectangle {
        x: 100
        y: 200
        width: 300
        height: 200
        color: "red"
        smooth: true
        antialiasing: true
        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.focus = true
            }
        }
        TemplateBorder {
            width: parent.width + borderMargin * 2
            height: parent.height + borderMargin * 2
            anchors.centerIn: parent
            visible: parent.focus
        }
    }
}

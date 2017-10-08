import QtQuick 2.9

Item {
    id: root
    property int frameCounter: 0
    property int fps: 0;

//    anchors.fill: parent.width

    Image {
        id: spinnerImage
        anchors.top: parent.top
        anchors.left: parent.left
        source: "images/spinner.png"
        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }
        onRotationChanged: {
            frameCounter++;
        }
    }

    Text {
        anchors.left: spinnerImage.right
        anchors.leftMargin: 6
        anchors.verticalCenter: spinnerImage.verticalCenter
        color: "#ffffff"
        style: Text.Outline
        styleColor: "#606060"
        font.pixelSize: 28
        text: root.fps + " fps"
    }

    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            // how the fuck does it count FPS that way
            fps = frameCounter / 2;
            frameCounter = 0;
        }
    }
}

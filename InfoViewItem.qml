import QtQuick 2.9

Item {
    id: root
    property bool switchedLayout: false
    property alias text: textItem.text
    property alias image: imageItem.source
    property alias imagevisible: imageItem.visible

    width: parent.width
    height: Math.max(imageItem.height, textItem.paintedHeight)

    Image {
        id: imageItem
        x: root.switchedLayout ? 20 : parent.width - width - 20
        y: 8
        width: parent.width / 5
        fillMode: Image.PreserveAspectFit
        visible: true
    }

    Text {
        id: textItem
        width: imageItem.visible ? parent.width - imageItem.width - 60 : parent.width - 20
        x: root.switchedLayout ? parent.width - width - 20 : 20
        y: 8
        color: "#ffffff"
        style: Text.Raised
        styleColor: "#000000"
        font.pixelSize: settings.fontS
        wrapMode: Text.WordWrap
    }
}

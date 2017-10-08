import QtQuick 2.9

Item {
    id: root

    property bool isShown: false
    property string image
    property string name
    property string year
    property string director
    property string cast
    property string overview
    property alias rating: ratingsItem.rating

    anchors.fill: parent
    opacity: 0
    visible: opacity
    scale: 0.3

    function show() {
        mainView.scheduleUpdate();
        root.isShown = true;
        showAnimation.restart();
    }
    function hide() {
        hideAnimation.restart();
    }

    Binding {
        target: mainView
        property: "blurAmount"
        value: 40 * root.opacity
        when: root.isShown
    }

    ParallelAnimation {
        id: showAnimation
        NumberAnimation { target: root; property: "opacity"; to: 1.0; duration: 500; easing.type: Easing.InOutQuad }
        NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 500; easing.type: Easing.InOutQuad }
    }
    SequentialAnimation {
        id: hideAnimation
        ParallelAnimation {
            NumberAnimation { target: root; property: "opacity"; to: 0; duration: 500; easing.type: Easing.InOutQuad }
            NumberAnimation { target: root; property: "scale"; to: 0.3; duration: 500; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: root; property: "isShown"; value: false }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.hide();
        }
    }

    Rectangle {
        id: backgroundItem
        anchors.centerIn: parent
        width: Math.min(620, parent.width - 32)
        height: Math.min(840, parent.height - 32)
        border.color: "#808080"
        border.width: 1
        opacity: 0.9
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101010" }
            GradientStop { position: 0.3; color: "#404040" }
            GradientStop { position: 1.0; color: "#090909" }
        }
    }

    Flickable {
        anchors.top: backgroundItem.top
        anchors.left: backgroundItem.left
        anchors.right: backgroundItem.right
        anchors.bottom: bottomSeparator.top
        //anchors.margins: 1
        anchors.bottomMargin: 0

        contentWidth: backgroundItem.width
        contentHeight: ratingsItem.y + descriptionTextItem.height + 64
        flickableDirection: Flickable.VerticalFlick
        clip: true

        Image {
            id: movieImageItem
            x: 20
            y: 20
            width: parent.width / 3
            fillMode: Image.PreserveAspectFit
            source: root.image ? "images/" + root.image : ""
            smooth: true
        }

        Column {
            id: topColumn
            y: 20
            anchors.left: movieImageItem.right
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 10

            Text {
                id: titleTextItem
                width: parent.width
                wrapMode: Text.WordWrap
                color: "#ffffff"
                font.pixelSize: text.length < 12 ? settings.fontL : settings.fontMM
                text: root.name
            }
            Item { height: 5; width: parent.width }
            Text {
                id: yearTextItem
                width: parent.width
                wrapMode: Text.WordWrap
                color: "#ffffff"
                font.pixelSize: settings.fontS
                text: "<b>Year:</b> " + root.year
            }
            Text {
                id: directorsTextItem
                width: parent.width
                wrapMode: Text.WordWrap
                color: "#ffffff"
                font.pixelSize: settings.fontS
                text: "<b>Creator:</b> " + root.director
            }
            Text {
                id: castTextItem
                width: parent.width
                wrapMode: Text.WordWrap
                color: "#ffffff"
                font.pixelSize: settings.fontS
                text: "<b>Cast:</b> " + root.cast
            }
        }

        RatingsItem {
            id: ratingsItem
            x: 15
            y: Math.max(topColumn.height, movieImageItem.height) + 50
            rating: root.rating
        }

        Text {
            id: descriptionTextItem
            anchors.top: ratingsItem.bottom
            anchors.topMargin: 20
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            color: "#ffffff"
            font.pixelSize: settings.fontM
            text: "<b>Description:</b> " + root.overview
        }
    }

    Rectangle {
        id: bottomSeparator
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: backgroundItem.bottom
        anchors.bottomMargin: 85
        width: backgroundItem.width - 30
        height: 1
        color: "#808080"
    }

    Button {
        anchors.bottom: backgroundItem.bottom
        anchors.bottomMargin: 10
        anchors.left: backgroundItem.left
        anchors.leftMargin: 30
        text: "Back"
        effectsOn: false
        onClicked: {
            root.hide();
        }
    }
    Button {
        anchors.bottom: backgroundItem.bottom
        anchors.bottomMargin: 10
        anchors.right: backgroundItem.right
        anchors.rightMargin: 30
        effectsOn: root.visible
        text: "Order"
        onClicked: {
            console.debug("Order! TODO: implement");
        }
    }
}

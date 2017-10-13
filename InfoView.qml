import QtQuick 2.9

Item {
    id: root

    property bool isShown: false

    anchors.fill: parent

    QtObject {
        id: priv
        property bool poleOut: false
        // How curly the curtain is when opened
        property int endCurly: 80
        // 0 = pole in, 1 = pole out
        property real polePosition: 0
        property bool showingStarted: false
    }

    function show() {
        priv.showingStarted = true;
        // Disabled, so animations continue while infoview is on
        //isShown = true;
        hideCurtainAnimation.stop();
        hidePoleAnimation.stop();
        if (priv.poleOut) {
            showCurtainAnimation.restart();
        } else {
            showPoleAnimation.restart();
        }
    }
    function hide() {
        priv.showingStarted = false;
        showCurtainAnimation.stop();
        showPoleAnimation.stop();
        if (priv.poleOut) {
            hideCurtainAnimation.restart();
        } else {
            hidePoleAnimation.restart();
        }
    }

    onIsShownChanged: {
        if (root.isShown) {
            mainView.scheduleUpdate();
        }
    }

    Binding {
        target: mainView
        property: "blurAmount"
        value: 40 * priv.polePosition
        when: root.isShown
    }

    // Pole show/hide animations
    SequentialAnimation {
        id: showPoleAnimation
        NumberAnimation { target: priv; property: "polePosition"; to: 1; duration: 600; easing.type: Easing.InOutQuad }
        PropertyAction { target: priv; property: "poleOut"; value: true }
        ScriptAction { script: showCurtainAnimation.restart(); }
    }
    SequentialAnimation {
        id: hidePoleAnimation
        PropertyAction { target: priv; property: "poleOut"; value: false }
        NumberAnimation { target: priv; property: "polePosition"; to: 0; duration: 600; easing.type: Easing.InOutQuad }
        PropertyAction { target: root; property: "isShown"; value: false }
    }

    // Curtain show/hide animations
    SequentialAnimation {
        id: showCurtainAnimation
        NumberAnimation { target: curtainEffect; property: "rightHeight"; to: root.height-8; duration: 1200; easing.type: Easing.OutBack }
    }
    SequentialAnimation {
        id: hideCurtainAnimation
        NumberAnimation { target: curtainEffect; property: "rightHeight"; to: 0; duration: 600; easing.type: Easing.OutCirc }
        ScriptAction { script: hidePoleAnimation.restart(); }
    }

    MouseArea {
        anchors.fill: parent
        enabled: priv.poleOut
        onClicked: {
            root.hide();
        }
    }

    BorderImage {
        anchors.right: parent.right
        anchors.top: parent.top
        border.left: 22
        border.right: 64
        border.top: 0
        border.bottom: 0
        width: 86 + priv.polePosition * (viewItem.width-88)
        z: 20
        source: "images/info.png"
        opacity: 0.5 + priv.polePosition
        MouseArea {
            anchors.fill: parent
            anchors.margins: -20
            onClicked: {
                if (priv.showingStarted) {
                    root.hide();
                } else {
                    root.show();
                }
            }
        }
    }

    // TODO organize all this in a proper layout
    Item {
        id: viewItem
        anchors.right: parent.right
        width: parent.width > parent.height ? parent.width * 0.45 : parent.width * 0.7
        height: parent.height + priv.endCurly - 16
        y: 8
        visible: priv.poleOut

        Rectangle {
            id: backgroundItem
            anchors.fill: parent
            anchors.margins: 16
            anchors.topMargin: 8
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#101010" }
                GradientStop { position: 0.3; color: "#404040" }
                GradientStop { position: 1.0; color: "#090909" }
            }
            border.color: "#808080"
            border.width: 1
            opacity: 0.8
        }

        Flickable {
            id: flickableArea
            anchors.fill: backgroundItem
            contentHeight: infoTextColumn.height + 15
            contentWidth: backgroundItem.width
            flickableDirection: Flickable.VerticalFlick
            clip: true

            Column {
                id: infoTextColumn
                width: parent.width
                spacing: 30

                Item { height: 5; width: parent.width }

                Image {
                    id: textItem
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "images/heading.png"
                }

                InfoViewItem {
                    text: "Welcome to <b>Cinematic Experience</b> demo. This application demonstrates the power of Qt and few cool features available in <u>Qt Quick</u>. Below is a short summary of those that have been used in this demo application."
                    image: "images/qt-logo.png"
                    switchedLayout: true
                }

                InfoViewItem {
                    text: "<b>Rendering</b><br/>Qt has a brand new rendering backend <u>Qt Quick Scene Graph</u>, which is optimized for hardware accelerated rendering. This allows to take full gains out of OpenGL powered GPUs on desktop and embedded devices. Not just performance, new Qt rendering backend also allows features which have not been possible earlier."
                    imagevisible: false
                }

                InfoViewItem {
                    text: "<b>Animations</b><br/>Qt Quick has always had a very strong animations support. Qt supports now also animations along a non-linear paths using <u>PathAnimation</u> QML element. In this demo, shooting star position moves along <u>PathAnimation</u> using <u>PathCurve</u>."
                    imagevisible: false
                }

                InfoViewItem {
                    text: "<b>Sprites</b><br/>Qt Quick has built-in support for sprites using <u>AnimatedSprite</u> element. Sprites can also be used as a source for particles."
                    image: "images/scr-sprites.png"
                    switchedLayout: true
                }

                InfoViewItem {
                    text: "<b>Particles</b><br/>Qt comes with a particles plugin <u>Qt Quick Particles</u>. In this demo application, twinkling stars, shooting star and fog/smoke have been implemented using this new particles engine."
                    image: "images/scr-particles.png"
                }

                InfoViewItem {
                    text: "<b>ShaderEffects</b><br/>Qt supports <u>ShaderEffect</u> and <u>ShaderEffectSource</u> QML elements which allow writing custom GLSL shader effects. In this demo, custom shader effect is used for lighting the movie delegates."
                    image: "images/scr-shader.png"
                    switchedLayout: true
                }

                InfoViewItem {
                    text: "<b>Graphical Effects</b><br/>Qt comes with pre-defined set of effects such as shadows, blur, glow, colorize, etc. These are available in <u>Qt GraphicalEffects</u>."
                    //image: "images/sc4.png"
                    imagevisible: false
                }

                Item { height: 20; width: parent.width }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16

                    Image {
                        source: "images/qt_ambassador_logo.png"
                        anchors.bottom: parent.bottom
                    }
                    Image {
                        source: "images/cc-by_logo.png"
                        anchors.bottom: parent.bottom
                    }
                    Image {
                        source: "images/quit_logo.png"
                        anchors.bottom: parent.bottom
                    }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "#909090"
                    font.pixelSize: settings.fontXS
                    text: "Copyright 2012 QUIt Coding. Reuse sources freely."
                }
            }
        }

        // Grip to close the view by flicking
        Image {
            id: gripImage
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: "images/grip.png"
            opacity: 0.25
            MouseArea {
                property int pressedY: 0
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: priv.endCurly - 16
                anchors.margins: -16
                width: 120
                height: 120
                onPressed: {
                    showCurtainAnimation.stop();
                    hideCurtainAnimation.stop();
                    pressedY = mouseY
                }
                onPositionChanged: {
                    curtainEffect.rightHeight = root.height - (pressedY - mouseY) - 8
                }
                onReleased: {
                    if (mouseY < -root.height*0.2) {
                        root.hide();
                    } else {
                        root.show();
                    }
                }
            }
        }
    }

    CurtainEffect {
        id: curtainEffect
        anchors.fill: viewItem
        source: ShaderEffectSource { sourceItem: viewItem; hideSource: true }
        rightHeight: 0
        leftHeight: rightHeight
        // Hide smoothly when curtain closes
        opacity: 0.004 * rightHeight
    }
}

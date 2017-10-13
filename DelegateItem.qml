import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    id: root

    property string name
    property bool isSelected: listView.currentIndex === index

    width: parent ? parent.width : imageItem.width
    height: imageItem.height
    z: isSelected ? 1000 : -index
    rotation: isSelected ? 0 : -15
    scale: isSelected ? mainView.height / 540 : mainView.height / 1080
    //opacity: 1.0 - Math.abs((listView.currentIndex - index) * 0.25)

    Behavior on rotation {
        NumberAnimation { duration: 500; easing.type: Easing.OutBack }
    }
    Behavior on scale {
        NumberAnimation { duration: 1500; easing.type: Easing.OutElastic }
    }
    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (isSelected) {
                detailsView.image = model.image
                detailsView.name =  model.name
                detailsView.year = model.year
                detailsView.director = model.director
                detailsView.cast = model.cast
                detailsView.rating = model.rating
                detailsView.overview = model.overview
                detailsView.show();
            } else {
                listView.currentIndex = index;
                if (settings.showShootingStarParticles) shootingStarBurst.burst(50);
            }
        }
    }

    Rectangle {
        id: posterFrame
        anchors.horizontalCenter: parent.horizontalCenter
        width: imageItem.width * (1 + 0.05 * imageItem.height / imageItem.width)
        height: imageItem.height * 1.05
        //scale: defaultSize / Math.max(imageItem.sourceSize.width, imageItem.sourceSize.height)
        color: "#DDDDDD"
        border.color: "gray"
        border.width: 1
        antialiasing: true

        RectangularGlow {
            anchors.fill: posterFrame
            glowRadius: 15
            spread: 0.1
            color: posterFrame.color
            visible: isSelected
            //cornerRadius: posterFrame.radius + glowRadius
        }

        Image {
            id: imageItem
            anchors.centerIn: parent
            //anchors.horizontalCenter: parent.horizontalCenter
            source: "images/" + model.image
            width: 180
            fillMode: Image.PreserveAspectFit
        }

        FastBlur {
            anchors.fill: imageItem
            source: imageItem
            radius: 16
            visible: !isSelected
        }
    }

    ShaderEffectSource {
        id: s1
        sourceItem: posterFrame
        //hideSource: settings.showLighting
        visible: settings.showLighting
    }

    ShaderEffect {
        anchors.fill: posterFrame
        property variant src: s1
        property variant srcNmap: coverNmapSource
        property real widthPortition: mainView.width / posterFrame.width
        property real heightPortition: mainView.height / posterFrame.height
        property real widthNorm: widthPortition * 0.5 - 0.5
        property real heightNorm: root.y / posterFrame.height - listView.contentY / posterFrame.height
        property real lightPosX: listView.globalLightPosX * widthPortition - widthNorm
        property real lightPosY: listView.globalLightPosY * heightPortition - heightNorm
        visible: settings.showLighting

        fragmentShader: "
            uniform sampler2D src;
            uniform sampler2D srcNmap;
            uniform lowp float qt_Opacity;
            varying highp vec2 qt_TexCoord0;
            uniform highp float lightPosX;
            uniform highp float lightPosY;
            void main() {
                highp vec4 pix = texture2D(src, qt_TexCoord0.st);
                highp vec4 pix2 = texture2D(srcNmap, qt_TexCoord0.st);
                highp vec3 normal = normalize(pix2.rgb * 2.0 - 1.0);
                highp vec3 light_pos = normalize(vec3(qt_TexCoord0.x - lightPosX, qt_TexCoord0.y - lightPosY, 0.8 ));
                highp float diffuse = max(dot(normal, light_pos), 0.2);

                // boost a bit
                diffuse *= 2.5;

                highp vec3 color = diffuse * pix.rgb;
                gl_FragColor = vec4(color, pix.a) * qt_Opacity;
            }
        "
    }
}

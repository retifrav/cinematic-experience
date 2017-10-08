import QtQuick 2.9
import QtQuick.Particles 2.0

Item {
    id: root

    anchors.fill: parent

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: settings.showColors ? "images/background-color.jpg" : "images/background-green.png"
        fillMode: Image.PreserveAspectCrop
        Behavior on source {
            SequentialAnimation {
                NumberAnimation { target: backgroundImage; property: "opacity"; to: 0; duration: 200; easing.type: Easing.InQuad }
                PropertyAction { target: backgroundImage; property: "source" }
                NumberAnimation { target: backgroundImage; property: "opacity"; to: 1; duration: 200; easing.type: Easing.OutQuad }
            }
        }
    }

    // Sky stars particles
    ParticleSystem {
        width: parent.width
        height: 220
        paused: detailsView.isShown || infoView.isShown //|| !settings.showShootingStarParticles
        ImageParticle {
            source: "images/star.png"
            rotationVariation: 10
        }
        Emitter {
            anchors.fill: parent
            emitRate: settings.showFogParticles ? 4 : 0
            lifeSpan: 5000
            size: 48
            sizeVariation: 16
        }
    }
}

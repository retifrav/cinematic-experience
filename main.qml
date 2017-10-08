import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: root
    visible: true
//    visibility: "FullScreen"
    width: 1200
    minimumWidth: 500
    height: 800
    minimumHeight: 700

    Item {
        id: mainWindow
        visible: true
        anchors.fill: parent

        QtObject {
            id: settings
            // These are used to scale fonts according to screen size
            property real _scaler: 300 + mainWindow.width * mainWindow.height * 0.00015
            property int fontXS: _scaler * 0.032
            property int fontS: _scaler * 0.040
            property int fontM: _scaler * 0.046
            property int fontMM: _scaler * 0.064
            property int fontL: _scaler * 0.100
            // Settings
            property bool showShootingStarParticles: false
            property bool showLighting: false
            property bool showFogParticles: true
            property bool showColors: false
        }

        MainView { id: mainView }

        InfoView { id: infoView }

        DetailsView { id: detailsView }

        MoviesModel { id: moviesModel }

        FpsItem {
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8
        }
    }
}

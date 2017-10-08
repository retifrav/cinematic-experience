## INTRO

This UX demo application presents some graphical features of Qt5. 

The name **Cinematic Experience** reflects how it's possible to build user  interfaces with increased dynamics.

## RUNNING

To run this application you need relatively recent build of Qt5:
- http://qt-project.org
- http://qt.gitorious.org/qt/qt5

There are two different ways to run the application:

1) If your target platform contains `qmlscene` binary, just use it:

``` bash
cd Qt5_CinematicExperience
[path to Qt5]/qtbase/bin/qmlscene Qt5_CinematicExperience.qml
```

2) Alternatively, a simple launcher is provided to start the application:

``` bash
cd Qt5_CinematicExperience
[path to Qt5]/qtbase/bin/qmake
make
./Qt5_CinematicExperience
```

The run application in fullscreen mode, use `--fullscreen` parameter for qmlscene or launcher. If you want to tweak the window resolution, modify `width` and `height` properties in `Qt5_CinematicExperience.qml`

## LICENSE

Source codes are licensed under a Creative Commons Attribution 3.0 Unported License. http://creativecommons.org/licenses/by/3.0/

No attribution required, but feel free to mention us or contact info@quitcoding.com

Qt, and the Qt logo are trademarks of Nokia Corporation
Movie reviews copyright © IMDb.com
DVD cover icons from http://www.iconarchive.com

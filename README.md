# Cinematic Experience

QtQuick/QML features demonstration: animations, particles, effects, etc.

![Cinematic Experience](/images/ce-screenshot.png?raw=true "Cinematic Experience")

95% of the code is taken from [QUIt Coding](http://quitcoding.com/?page=work#cinex), so read the original [README](/README.original.md) too.

## What was changed comparing with the original version from QUIt Coding

* updated Qt logos
* new background pictures
* added particles to the Qt logo at the end of the movies list
* the whole movie database (`MoviesModel.qml`) is updated (new set of movies, now including TV shows)
    - including new pictures for movies posters (and they are posters now, before it was DVD-covers)
* tweaks in animations and graphical effects (mostly about time values)
* adjusted layout geometry of the `FpsItem.qml`
* renamed some settings (switches) labels, default values and re-hooked some effects (stars at the top of the screen are now hooked to a different switch, for example)
* updated components versions in imports (`Qt Quick 2.9` instead of `Qt Quick 2.0`, for example)
* reworked the main list of movies
    - added `FastBlur` effect for all movie items in the list (`DelegateItem.qml`), except for the selected one
        + removed opacity for items, because it was messing with the blur
    - added a border for all item pictures (instead of photoshoping each one of them into a DVD-cover picture)
        + added glowing frame (`RectangularGlow`) for the selected item
    - added a `width` value (with `Image.PreserveAspectFit`) for an item poster picture (instead of having all pictures with fixed sizes)
* reworked movie detailed view (`DetailsView.qml`)
    - poster image `width` is now bound to the view `width` (with `Image.PreserveAspectFit`)
    - adjusted sizes, spacing, margins
* reworked description curtain (`InfoView.qml` and `InfoViewItem.qml`)
    - adjusted sizes, spacing, margins
    - changed description texts and screenshots
    - increased the touch surface for the corner grip
    - inline `images` width is now bound to the view `width` (with `Image.PreserveAspectFit`)
* feng-shui

## License

I am not sure if the original `Creative Commons Attribution 3.0 Unported` license is compatible with `GPLv3`, but I would like to license this repository exactly under `GPLv3` (because it's Qt).

Most reviews are taken from [IMDb](http://www.imdb.com).

I also borrowed the application icon from [here](http://www.iconarchive.com/show/3d-cartoon-vol3-icons-by-hopstarter/Windows-Movie-Maker-icon.html).

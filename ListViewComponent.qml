import QtQuick 2.3

Component {
    Rectangle {
        width: root.width
        height: barSize
        color: index % 2 === 0 ? listElementColor1 : listElementColor2

        FontLoader {
            id: localFont
            source: "f/fonts/OpenSans-Light.ttf"
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font.family: localFont.name
            font.pixelSize: textSize
            color: textColor
            antialiasing: true
            smooth: true
            text: title
        }
        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (internetConnectionState) {
                    if (appTitle !== title) {
                        firstLaunchState = true
                        imageAnimationRunning = false
                        universalIcon.text = playingStateString = pauseString
                        favoriteState = favorite
                        // clock
                        timeViewState = false
                        clockStateString = clockOffString
                    }

                    stackView.push(Qt.resolvedUrl("Player.qml"))

                    audio.source = source

                    appTitle = title

                    menuIcon.state = "back"

                    searchField.text = ""
                    searchField.activeFocusOnPress = false
                    searchField.focus = false
                    searchField.height = borderBarSize
                    universalIcon.font.pixelSize = barUniversalIconSize

                    universalIcon.text = playingStateString
                }
            }
        }
    }
}

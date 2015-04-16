import QtQuick 2.3
import QtQuick.Controls 1.2

Item {
    property int imageWidth: if (width > height)
                                 5 / 6 * height
                             else
                                 4 / 5 * width

    Rectangle {
        width: parent.width
        height: if (parent.width > parent.height)
                    parent.height
                else
                    parent.height - (star.contentHeight + clickMargin)
        color: bgColor

        Image {
            id: image
            anchors.centerIn: parent
            width: imageWidth
            height: imageWidth
            source: "f/images/BenBois-Vinyl-records.png"
            smooth: true
            antialiasing: true
            MouseArea {
                anchors.fill: parent

                onClicked: if (!firstLaunchState && !clockPanel.visible) {
                               if (playingStateString === pauseString) {
                                   audio.pause()
                                   imageAnimationRunning = false
                                   universalIcon.text = playingStateString = playString
                               } else {
                                   audio.play()
                                   imageAnimationRunning = true
                                   universalIcon.text = playingStateString = pauseString
                               }
                           }
            }
        }

        RotationAnimator {
            id: imageAnimation
            target: image
            from: 0
            to: 360
            duration: 10000
            loops: Animation.Infinite
            running: imageAnimationRunning
            onRunningChanged: if (running === false) {
                                  from = image.rotation
                                  to = from + 360
                              }
        }

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
            running: firstLaunchState
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 100
        onTriggered: if (firstLaunchState) {
                         if ((os === android && audio.status === 5)
                                 || (os === windows && audio.status === 6)) {
                             imageAnimationRunning = true
                             busyIndicator.running = false
                             running = false
                             firstLaunchState = false
                         }
                     } else
                         running = false
    }

    Rectangle {
        anchors.bottom: parent.bottom
        height: star.contentHeight + clickMargin
        width: star.contentWidth + clickMargin
        color: "transparent"
        Text {
            id: star
            anchors.centerIn: parent
            font.family: fontIcoMoon.name
            font.pixelSize: panelIconSize
            color: menuItemColor
            text: favoriteState === 0 ? "\ue9d7" : "\ue9d9"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!clockPanel.visible) {
                    star.text = star.text === "\ue9d7" ? "\ue9d9" : "\ue9d7"
                    if (favoriteState === 0) {
                        db.addOrRemoveFromFavorites(appTitle, 1)
                        favoriteState = 1
                    } else {
                        db.addOrRemoveFromFavorites(appTitle, 0)
                        favoriteState = 0
                    }
                    if (favoritesListShow)
                        listModel.getFavorites()
                }
            }
        }
    }

    Rectangle {
        visible: os === windows ? true : false
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: clock.contentHeight + clickMargin
        width: clock.contentWidth + clickMargin
        color: "transparent"
        Text {
            id: clock
            anchors.centerIn: parent
            font.family: fontIcoMoon.name
            font.pixelSize: panelIconSize
            color: menuItemColor
            text: clockStateString
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!firstLaunchState && !clockPanel.visible) {
                    if (clockStateString === clockOffString) {
                        clockPanel.visible = true
                        var date = new Date()
                        hours = date.getHours()
                        minutes = date.getMinutes()
                    } else {
                        clockStateString = clockOffString
                        timeViewState = false
                        audio.play()
                        imageAnimationRunning = true
                        universalIcon.text = playingStateString = pauseString
                        clockTimer.running = false
                    }
                }
            }
        }
    }

    Row {
        id: timeView
        visible: if (timeViewState) {
                     if (parent.width > parent.height)
                         false
                     else
                         true
                 } else
                     false
        anchors.bottomMargin: clock.contentHeight
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            width: timeText.contentWidth
            height: clock.contentHeight + clickMargin
            color: "transparent"
            Text {
                id: timeText
                anchors.verticalCenter: parent.verticalCenter
                font.family: fontOpenSans.name
                font.pixelSize: panelIconSize
                color: menuItemColor
                text: timeTextString
            }
        }
        Text {
            id: timeIcon
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontIcoMoon.name
            font.pixelSize: panelIconSize
            color: timeIconColor
            text: timeIconString
        }
    }

    Row {
        id: timeView2
        visible: if (timeViewState) {
                     if (parent.width > parent.height)
                         true
                     else
                         false
                 } else
                     false
        anchors.right: parent.right
        anchors.rightMargin: 15

        Rectangle {
            width: timeText.contentWidth
            height: clock.contentHeight + clickMargin
            color: "transparent"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: fontOpenSans.name
                font.pixelSize: panelIconSize
                color: menuItemColor
                text: timeTextString
            }
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontIcoMoon.name
            font.pixelSize: panelIconSize
            color: timeIconColor
            text: timeIconString
        }
    }

    Rectangle {
        id: clockPanel
        visible: false
        anchors.fill: parent
        color: bgColor

        Rectangle {
            anchors.right: parent.right
            height: closeClockPanel.contentHeight + clickMargin
            width: closeClockPanel.contentWidth + clickMargin
            color: "transparent"
            Text {
                id: closeClockPanel
                anchors.centerIn: parent
                font.family: fontIcoMoon.name
                font.pixelSize: barUniversalIconSize
                color: menuItemColor
                text: "\uea0f"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: clockPanel.visible = false
            }
        }

        Column {
            anchors.centerIn: parent
            Row {

                Column {
                    Text {
                        id: firstElement
                        font.family: fontIcoMoon.name
                        font.pixelSize: clockPanelIconSize
                        color: menuItemColor
                        text: "\uea0a" // +
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                hours++
                                if (hours === 24)
                                    hours = 0
                            }
                            Timer {
                                interval: 200
                                running: parent.pressed
                                repeat: true
                                onTriggered: {
                                    hours++
                                    if (hours === 24)
                                        hours = 0
                                }
                            }
                        }
                    }
                    Rectangle {
                        width: firstElement.contentWidth
                        height: firstElement.contentHeight
                        color: "transparent"
                        Text {
                            anchors.centerIn: parent
                            font.family: fontOpenSans.name
                            font.pixelSize: clockPanelIconSize
                            color: menuItemColor
                            text: if (hours.toString().length === 1)
                                      '0' + hours.toString()
                                  else
                                      hours.toString()
                        }
                    }
                    Text {
                        font.family: fontIcoMoon.name
                        font.pixelSize: clockPanelIconSize
                        color: menuItemColor
                        text: "\uea0b" // -
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                hours--
                                if (hours === -1)
                                    hours = 23
                            }
                            Timer {
                                interval: 200
                                running: parent.pressed
                                repeat: true
                                onTriggered: {
                                    hours--
                                    if (hours === -1)
                                        hours = 23
                                }
                            }
                        }
                    }
                }
                Column {
                    Rectangle {
                        width: firstElement.contentWidth
                        height: firstElement.contentHeight
                        color: "transparent"
                    }
                    Rectangle {
                        width: firstElement.contentWidth
                        height: firstElement.contentHeight
                        color: "transparent"
                        Text {
                            anchors.centerIn: parent
                            font.family: fontOpenSans.name
                            font.pixelSize: clockPanelIconSize
                            color: barColor
                            text: ":"
                        }
                    }
                    Rectangle {
                        width: firstElement.contentWidth
                        height: firstElement.contentHeight
                        color: "transparent"
                    }
                }
                Column {
                    Text {
                        font.family: fontIcoMoon.name
                        font.pixelSize: clockPanelIconSize
                        color: menuItemColor
                        text: "\uea0a" // +
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                minutes++
                                if (minutes === 60)
                                    minutes = 0
                            }
                            Timer {
                                interval: 150
                                running: parent.pressed
                                repeat: true
                                onTriggered: {
                                    minutes++
                                    if (minutes === 60)
                                        minutes = 0
                                }
                            }
                        }
                    }
                    Rectangle {
                        width: firstElement.contentWidth
                        height: firstElement.contentHeight
                        color: "transparent"
                        Text {
                            anchors.centerIn: parent
                            font.family: fontOpenSans.name
                            font.pixelSize: clockPanelIconSize
                            color: menuItemColor
                            text: if (minutes.toString().length === 1)
                                      '0' + minutes.toString()
                                  else
                                      minutes.toString()
                        }
                    }
                    Text {
                        font.family: fontIcoMoon.name
                        font.pixelSize: clockPanelIconSize
                        color: menuItemColor
                        text: "\uea0b" // -
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                minutes--
                                if (minutes === -1)
                                    minutes = 59
                            }
                            Timer {
                                interval: 150
                                running: parent.pressed
                                repeat: true
                                onTriggered: {
                                    minutes--
                                    if (minutes === -1)
                                        minutes = 59
                                }
                            }
                        }
                    }
                }
            }
            Row {
                Rectangle {
                    width: firstElement.contentWidth
                    height: firstElement.contentHeight
                    color: "transparent"
                }
                Rectangle {
                    width: firstElement.contentWidth
                    height: firstElement.contentHeight
                    color: "transparent"
                }
                Rectangle {
                    width: firstElement.contentWidth
                    height: firstElement.contentHeight
                    color: "transparent"
                }
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: if (parent.width > parent.height)
                       parent.height / 2
                   else
                       parent.width / 2
            height: width
            color: "transparent"
            Text {
                anchors.centerIn: parent
                font.family: fontIcoMoon.name
                font.pixelSize: clockPanelIconSize2
                color: "#1693A5"
                text: alarmString
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockStateString = clockOnString
                    if (hours.toString().length === 1 && minutes.toString(
                                ).length === 1)
                        timeTextString = '0' + hours.toString(
                                    ) + " : " + '0' + minutes.toString() + ' '
                    else if (hours.toString().length === 1)
                        timeTextString = '0' + hours.toString(
                                    ) + " : " + minutes.toString() + ' '
                    else if (minutes.toString().length === 1)
                        timeTextString = hours.toString(
                                    ) + " : " + '0' + minutes.toString() + ' '
                    else
                        timeTextString = hours.toString(
                                    ) + " : " + minutes.toString() + ' '
                    timeIconString = alarmString
                    timeIconColor = alarmColor
                    timeViewState = true
                    clockPanel.visible = false
                    audio.pause()
                    imageAnimationRunning = false
                    universalIcon.text = playingStateString = playString
                    clockTimer.running = true
                }
            }
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: if (parent.width > parent.height)
                       parent.height / 2
                   else
                       parent.width / 2
            height: width
            color: "transparent"
            Text {
                anchors.centerIn: parent
                font.family: fontIcoMoon.name
                font.pixelSize: clockPanelIconSize2
                color: "#FF0000"
                text: sleepString
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockStateString = clockOnString
                    if (hours.toString().length === 1 && minutes.toString(
                                ).length === 1)
                        timeTextString = '0' + hours.toString(
                                    ) + " : " + '0' + minutes.toString() + ' '
                    else if (hours.toString().length === 1)
                        timeTextString = '0' + hours.toString(
                                    ) + " : " + minutes.toString() + ' '
                    else if (minutes.toString().length === 1)
                        timeTextString = hours.toString(
                                    ) + " : " + '0' + minutes.toString() + ' '
                    else
                        timeTextString = hours.toString(
                                    ) + " : " + minutes.toString() + ' '
                    timeIconString = sleepString
                    timeIconColor = sleepColor
                    timeViewState = true
                    clockPanel.visible = false
                    audio.play()
                    imageAnimationRunning = true
                    universalIcon.text = playingStateString = pauseString
                    clockTimer.running = true
                }
            }
        }
    }
}

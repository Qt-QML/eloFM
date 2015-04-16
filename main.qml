import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.0
import "Themes.js" as Themes

ApplicationWindow {
    id: root
    visible: true
    title: "eloFM"
    property string appTitle: "eloFM"

    property int windows: 0
    property int android: 1
    property int os: windows

    // Windows
    width: 260
    height: 440
    minimumWidth: 260
    minimumHeight: 390
    maximumWidth: 260
    maximumHeight: 520
    x: os === windows ? Screen.width / 2 - width / 2 : 0
    y: os === windows ? Screen.height / 2 - height / 2 : 0
    // for tablets with windows (tablets get maximum sizes)
    Component.onCompleted: {
        if (os === windows) {
            x = Screen.width / 2 - width / 2
            y = Screen.height / 2 - height / 2
            width = 260
            height = 440
        }
    }

    property int colorSchemeIterator
    // Default Theme: Light
    property string barColor: "#FFFEF7"
    property string borderBarColor: "#54372A"
    property string bgColor: barColor
    property string listElementColor1: "#FFFEED"
    property string listElementColor2: "#F8FEF0"
    property string barTextColor: borderBarColor
    property string menuItemColor: borderBarColor
    property string textColor: borderBarColor
    property string searchTextColor: barColor
    property string scrollHandleColor: borderBarColor
    color: bgColor

    function s(sizeWindows, sizeAndroid) {
        if (os === android)
            // looks the same on all devices
            return sizeAndroid * 0.259 * Screen.pixelDensity
        else if (os === windows)
            // scalable because in pixels
            return sizeWindows
    }
    // if values are similar use this
    property real sp: if (os === android)
                          0.259 * Screen.pixelDensity
                      else if (os === windows)
                          1
    property int barSize: s(40, 35)
    property int borderBarSize: 1 * sp
    property int clickMargin: 30 * sp
    property int textSize: s(16, 12)
    property int barTitleSize: s(22, 16.5)
    property int barUniversalIconSize: s(18, 13)
    property int barUniversalIconSizeHover: s(20, 15)
    property int menuPanelIconSize: s(28, 23)
    property int menuPanelSpacing1: 25 * sp
    property int menuPanelSpacing2: 20 * sp
    property int panelIconSize: s(30, 25)
    property int clockPanelIconSize: s(50, 45)
    property int clockPanelIconSize2: s(50, 45)
    property string searchString: "\ue986"
    property string pauseString: "\uea1d"
    property string playString: "\uea1c"
    property string playingStateString: "\uea1d"
    property bool imageAnimationRunning: false
    property bool firstLaunchState: false
    property bool internetConnectionState: false
    property bool favoritesListShow: false
    property int favoriteState: 0

    // Alarm and Sleep Timer
    property string clockStateString: clockOffString
    property string clockOffString: "\ue94e"
    property string clockOnString: "\ue94f"
    property bool timeViewState: false
    property int hours: 0
    property int minutes: 0
    property string alarmString: "\ue950"
    property string sleepString: "\uea2a"
    property string alarmColor: "#1693A5"
    property string sleepColor: "#FF0000"
    property string timeTextString
    property string timeIconString
    property string timeIconColor

    FontLoader {
        id: fontOpenSans
        source: "f/fonts/OpenSans-Light.ttf"
    }

    FontLoader {
        id: fontIcoMoon
        source: "f/fonts/icomoon.ttf"
    }

    Database {
        id: db
    }

    Audio {
        id: audio
        volume: 1
        autoPlay: true
        onStatusChanged: {
            //console.log(status)

            // played: Android - 5, Windows - 6
            // disconected: Android - 7, Windows - 5(but we must check connection)
            if ((os === android && status === 5) || (os === windows
                                                     && status === 6))
                checkInternetConnectionTimer.running = false

            if ((os === android && status === 7) || (os === windows
                                                     && status === 5)) {
                checkInternetConnectionTimer.interval = 1
                checkInternetConnectionTimer.running = true
            }
        }
    }

    Timer {
        id: checkInternetConnectionTimer
        interval: 1
        running: true
        repeat: true
        onTriggered: {
            checkInternetConnection()
            //console.log(internetConnectionState)
            //console.log("interval: ", interval)
            if (interval < 2000)
                interval += 100
            if (internetConnectionState === true)
                interval = 2000

            if (internetConnectionState === false) {
                if (menuIcon.state === "back") {
                    universalIcon.text = searchString
                    menuIcon.state = "menu"
                    stackView.pop(stackView.get(1))
                }
                audio.source = ""
                appTitle = title
            }
        }
    }

    function checkInternetConnection() {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                try {
                    var json = JSON.parse(xhr.responseText.toString())
                    internetConnectionState = true
                } catch (e) {
                    internetConnectionState = false
                }
            }
        }
        xhr.open("GET", "http://185.49.14.123/e")
        xhr.send()
    }

    onWidthChanged: timerTitle.running = true
    Timer {
        id: timerTitle
        interval: 1
        onTriggered: if (textTitle.contentWidth > flickableTitle.width) {
                         flickableTitle.contentX = 0
                         titleTimer.running = true
                         startTitle.visible = false
                     } else {
                         titleTimer.running = false
                         startTitle.visible = true
                     }
    }

    toolBar: Item {
        // we must use toolBar, because it's rigid
        Rectangle {
            id: bar
            width: root.width
            height: barSize
            color: barColor

            Flickable {
                id: flickableTitle
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - menuIconField.width - universalIconField.width
                height: parent.height
                contentWidth: textTitle.contentWidth
                contentX: -(width - textTitle.contentWidth) / 2
                property bool first: true
                property bool second: false
                Timer {
                    id: titleTimer
                    running: false
                    repeat: true
                    interval: 100
                    onTriggered: {
                        if (parent.first
                                && parent.contentX < textTitle.contentWidth - parent.width + s(
                                    5, 5))
                            parent.contentX++
                        else {
                            parent.first = false
                            parent.second = true
                        }
                        if (parent.second)
                            parent.contentX--
                        if (parent.contentX < -s(5, 5)) {
                            parent.first = true
                            parent.second = false
                        }
                    }
                }
                Text {
                    id: textTitle
                    anchors.centerIn: parent
                    font.family: fontOpenSans.name
                    font.pixelSize: barTitleSize
                    color: barTextColor
                    antialiasing: true
                    smooth: true
                    text: appTitle

                    onTextChanged: {
                        if (contentWidth > flickableTitle.width) {
                            flickableTitle.contentX = 0
                            titleTimer.running = true
                            startTitle.visible = false
                        } else {
                            titleTimer.running = false
                            startTitle.visible = true
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: if (appTitle !== title) {
                                   if (menuIcon.state === "forward") {
                                       stackView.push(list)
                                       menuIcon.state = "menu"
                                   }

                                   if (menuIcon.state === "menu") {
                                       stackView.push(Qt.resolvedUrl(
                                                          "Player.qml"))
                                       menuIcon.state = "back"
                                   }

                                   searchField.text = ""
                                   searchField.activeFocusOnPress = false
                                   searchField.focus = false
                                   searchField.height = borderBarSize
                                   universalIcon.font.pixelSize = barUniversalIconSize

                                   universalIcon.text = playingStateString
                               }
                }
            }

            Rectangle {
                id: startTitle
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - menuIconField.width - universalIconField.width
                height: parent.height
                color: barColor
                Text {
                    anchors.centerIn: parent
                    font.family: fontOpenSans.name
                    font.pixelSize: barTitleSize
                    color: barTextColor
                    antialiasing: true
                    smooth: true
                    text: appTitle
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: if (appTitle !== title) {
                                   if (menuIcon.state === "forward") {
                                       stackView.push(list)
                                       menuIcon.state = "menu"
                                   }

                                   if (menuIcon.state === "menu") {
                                       stackView.push(Qt.resolvedUrl(
                                                          "Player.qml"))
                                       menuIcon.state = "back"
                                   }

                                   searchField.text = ""
                                   searchField.activeFocusOnPress = false
                                   searchField.focus = false
                                   searchField.height = borderBarSize
                                   universalIcon.font.pixelSize = barUniversalIconSize

                                   universalIcon.text = playingStateString
                               }
                }
            }

            Rectangle {
                id: menuIconField
                width: menuIcon.width + clickMargin - s(10, 10)
                height: parent.height
                color: barColor
                MenuIcon {
                    id: menuIcon
                    anchors.centerIn: parent
                    menuIconColor: barTextColor
                    scale: if (os === android)
                               0.7
                           else if (os === windows)
                               1
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        searchField.activeFocusOnPress = false
                        searchField.focus = false
                        searchField.height = borderBarSize
                        searchTimer.running = false
                        universalIcon.font.pixelSize = barUniversalIconSize
                        if (menuIcon.state === "menu") {
                            menuIcon.state = "forward"
                            stackView.pop(stackView.get(0))
                            searchField.text = ""
                        } else if (menuIcon.state === "forward") {
                            menuIcon.state = "menu"
                            stackView.push(list)
                        } else if (menuIcon.state === "back") {
                            universalIcon.text = searchString
                            menuIcon.state = "menu"
                            stackView.pop(stackView.get(1))
                        }
                    }
                }
            }

            Rectangle {
                id: universalIconField
                anchors.right: parent.right
                width: universalIcon.contentWidth + clickMargin
                height: parent.height
                color: barColor
                Text {
                    id: universalIcon
                    anchors.centerIn: parent
                    font.family: fontIcoMoon.name
                    font.pixelSize: barUniversalIconSize
                    color: barTextColor
                    antialiasing: true
                    smooth: true
                    text: searchString
                    Behavior on font.pixelSize {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.contentY = 0
                        searchField.text = ""

                        if (menuIcon.state === "forward") {
                            menuIcon.state = "menu"
                            stackView.push(list)
                            searchField.activeFocusOnPress = true
                            searchField.focus = true
                            searchField.height = searchField.implicitHeight
                            searchTimer.running = true
                            universalIcon.font.pixelSize = universalIcon.font.pixelSize
                                    === barUniversalIconSize ? barUniversalIconSizeHover : barUniversalIconSize
                        } else if (menuIcon.state === "back") {
                            if (!firstLaunchState) {
                                if (universalIcon.text === pauseString) {
                                    imageAnimationRunning = false
                                    audio.pause()
                                } else {
                                    imageAnimationRunning = true
                                    audio.play()
                                }
                                universalIcon.font.pixelSize = barUniversalIconSize
                                playingStateString = playingStateString
                                        === pauseString ? playString : pauseString
                                universalIcon.text = playingStateString
                            }
                        } else if (menuIcon.state === "menu") {
                            searchField.activeFocusOnPress = searchField.activeFocusOnPress
                                    === false ? true : false
                            searchField.focus = searchField.focus === false ? true : false
                            searchField.height = searchField.height
                                    === borderBarSize ? searchField.implicitHeight : borderBarSize
                            searchTimer.running = searchTimer.running === false ? true : false
                            universalIcon.font.pixelSize = universalIcon.font.pixelSize
                                    === barUniversalIconSize ? barUniversalIconSizeHover : barUniversalIconSize
                        }
                    }
                }
            }
        }

        TextField {
            id: searchField
            anchors.top: bar.bottom
            height: borderBarSize
            width: root.width
            font.family: fontOpenSans.name
            font.pixelSize: textSize
            textColor: searchTextColor
            activeFocusOnPress: false
            style: TextFieldStyle {
                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: borderBarColor
                }
            }

            onTextChanged: {
                searchTimer.restart()
                if (text.length > 0)
                    listModel.applyFilter(text)
                else
                    listModel.reload()
            }

            Behavior on height {
                NumberAnimation {
                    duration: 200
                }
            }
            Timer {
                id: searchTimer
                running: false
                interval: 7000
                repeat: false
                onTriggered: {
                    searchField.text = ""
                    searchField.activeFocusOnPress = false
                    searchField.focus = false
                    searchField.height = borderBarSize
                    universalIcon.font.pixelSize = barUniversalIconSize
                }
            }
        }
    }

    StackView {
        id: stackView
        y: bar.height + searchField.height
        width: parent.width
        height: parent.height - (bar.height + searchField.height)
        focus: true
        // Android
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 2) {
                             stackView.pop(stackView.get(1))
                             event.accepted = true
                             menuIcon.state = "menu"
                         } else if (event.key === Qt.Key_Back
                                    && stackView.depth === 2)
                             Qt.quit()

        initialItem: Qt.resolvedUrl("MenuPanel.qml")
        Component.onCompleted: stackView.push({
                                                  item: list,
                                                  immediate: true
                                              })
    }

    Item {
        id: list

        Rectangle {
            anchors.fill: parent
            color: bgColor

            ScrollView {
                anchors.fill: parent

                flickableItem.interactive: true
                style: ScrollViewStyle {
                    transientScrollBars: true
                    handle: Item {
                        implicitWidth: 3 * sp
                        implicitHeight: 26 * sp
                        Rectangle {
                            anchors.fill: parent
                            color: scrollHandleColor
                        }
                    }
                    scrollBarBackground: Item {
                        implicitWidth: 2 * sp
                        implicitHeight: 26 * sp
                    }
                }

                ListView {
                    id: listView

                    Behavior on y {
                        NumberAnimation {
                            duration: 200
                        }
                    }

                    model: ListModel {
                        id: listModel

                        Component.onCompleted: {
                            db.createDatabase()
                            reload()
                        }

                        function reload() {
                            var list = db.getAll()
                            listModel.clear(list)
                            for (var i = 0; i < list.length; ++i) {
                                listModel.append({
                                                     title: list.item(i).title,
                                                     source: list.item(
                                                                 i).source,
                                                     favorite: list.item(
                                                                   i).favorite
                                                 })
                            }
                        }

                        function applyFilter(title) {
                            var list = db.getByTitle(title)
                            listModel.clear()
                            for (var i = 0; i < list.length; ++i) {
                                listModel.append({
                                                     title: list[i].title,
                                                     source: list[i].source,
                                                     favorite: list[i].favorite
                                                 })
                            }
                        }

                        function getFavorites() {
                            var list = db.getFavorites()
                            listModel.clear()
                            for (var i = 0; i < list.length; ++i) {
                                listModel.append({
                                                     title: list[i].title,
                                                     source: list[i].source,
                                                     favorite: list[i].favorite
                                                 })
                            }
                        }
                    }

                    delegate: ListViewComponent {
                    }

                    onContentYChanged: {
                        if (contentY < -s(100, 100)) {
                            searchField.activeFocusOnPress = true
                            searchField.focus = true
                            searchField.height = searchField.implicitHeight
                            searchTimer.running = true
                            universalIcon.font.pixelSize = barUniversalIconSizeHover
                        }
                        if (contentY > s(10, 10)) {
                            searchField.text = ""
                            searchField.activeFocusOnPress = false
                            searchField.focus = false
                            searchField.height = borderBarSize
                            searchTimer.running = false
                            universalIcon.font.pixelSize = barUniversalIconSize
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: clockTimer
        running: false
        interval: 1000
        repeat: true
        onTriggered: {
            var date = new Date()
            // Alarm Timer
            if (timeIconString === alarmString) {
                if (hours === date.getHours()
                        && minutes === date.getMinutes()) {
                    audio.play()
                    imageAnimationRunning = true
                    if (universalIcon.state === "back")
                        universalIcon.text = playingStateString = pauseString
                    else
                        playingStateString = pauseString
                    running = false
                    clockStateString = clockOffString
                    timeViewState = false
                }
            }
            // Sleep Timer
            if (timeIconString === sleepString)
                if (hours === date.getHours()
                        && minutes === date.getMinutes()) {
                    audio.pause()
                    imageAnimationRunning = false
                    if (universalIcon.state === "back")
                        universalIcon.text = playingStateString = playString
                    else
                        playingStateString = playString
                    running = false
                    clockStateString = clockOffString
                    timeViewState = false
                }
        }
    }
}

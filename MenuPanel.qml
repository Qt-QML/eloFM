import QtQuick 2.3
import "Themes.js" as Themes

Item {
    Rectangle {
        id: menuPanel
        anchors.fill: parent
        color: bgColor

        Grid {
            anchors.centerIn: parent
            columns: if (parent.width > parent.height)
                         0
                     else
                         1
            rows: if (parent.width > parent.height)
                      1
                  else
                      0
            spacing: if (parent.width > parent.height)
                         menuPanelSpacing1
                     else
                         menuPanelSpacing2

            Rectangle {
                id: menuItem1
                width: if (parent.width > parent.height)
                           (menuPanel.width - 4 * menuPanelSpacing1) / 3
                       else
                           (menuPanel.height - 4 * menuPanelSpacing2) / 3
                height: width
                color: "transparent"
                radius: width / 2
                border.color: menuItemColor
                border.width: 1
                smooth: true
                antialiasing: true
                Text {
                    id: menuItem1Text
                    anchors.centerIn: parent
                    font.family: fontIcoMoon.name
                    font.pixelSize: menuPanelIconSize
                    color: menuItemColor
                    smooth: true
                    antialiasing: true
                    text: "\uea15"
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        favoritesListShow = false
                        menuIcon.state = "menu"
                        listModel.reload()
                        stackView.push(list)
                    }
                }
            }

            Rectangle {
                id: menuItem2
                width: if (parent.width > parent.height)
                           (menuPanel.width - 4 * menuPanelSpacing1) / 3
                       else
                           (menuPanel.height - 4 * menuPanelSpacing2) / 3
                height: width
                color: "transparent"
                radius: width / 2
                border.color: menuItemColor
                border.width: 1
                smooth: true
                antialiasing: true
                Text {
                    id: menuItem2Text
                    anchors.centerIn: parent
                    font.family: fontIcoMoon.name
                    font.pixelSize: menuPanelIconSize
                    color: menuItemColor
                    smooth: true
                    antialiasing: true
                    text: "\ue9d9"
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        favoritesListShow = true
                        menuIcon.state = "menu"
                        stackView.push(list)
                        listModel.getFavorites()
                    }
                }
            }

            Rectangle {
                id: menuItem3
                width: if (parent.width > parent.height)
                           (menuPanel.width - 4 * menuPanelSpacing1) / 3
                       else
                           (menuPanel.height - 4 * menuPanelSpacing2) / 3
                height: width
                color: "transparent"
                radius: width / 2
                border.color: menuItemColor
                border.width: 1
                smooth: true
                antialiasing: true
                Text {
                    id: menuItem3Text
                    anchors.centerIn: parent
                    font.family: fontIcoMoon.name
                    font.pixelSize: menuPanelIconSize
                    color: menuItemColor
                    smooth: true
                    antialiasing: true
                    text: "\ue997"
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        colorSchemeIterator %= 7
                        Themes.set(colorSchemeIterator)
                        db.saveTheme(colorSchemeIterator)
                        colorSchemeIterator++
                    }
                }
            }
        }
    }
}

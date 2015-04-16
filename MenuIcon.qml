import QtQuick 2.3

Item {
    id: localRoot

    property string menuIconColor: "blue"

    width: 24 * sp
    height: 24 * sp

    Rectangle {
        id: bar1
        x: 0
        y: 5 * sp
        width: 24 * sp
        height: 2 * sp
        antialiasing: true
        color: menuIconColor
    }

    Rectangle {
        id: bar2
        x: 0
        y: 10 * sp
        width: 24 * sp
        height: 2 * sp
        antialiasing: true
        color: menuIconColor
    }

    Rectangle {
        id: bar3
        x: 0
        y: 15 * sp
        width: 24 * sp
        height: 2 * sp
        antialiasing: true
        color: menuIconColor
    }

    property int animationDuration: 350

    state: "menu"
    states: [
        State {
            name: "menu"
        },

        State {
            name: "forward"
            PropertyChanges {
                target: localRoot
                rotation: 180
            }
            PropertyChanges {
                target: bar1
                rotation: -45
                width: 13 * sp
                x: 0
                y: 8 * sp
            }
            PropertyChanges {
                target: bar2
                width: 21 * sp
                x: 3 * sp
                y: 12 * sp
            }
            PropertyChanges {
                target: bar3
                rotation: 45
                width: 13 * sp
                x: 0
                y: 16 * sp
            }
        },

        State {
            name: "back"
            PropertyChanges {
                target: localRoot
                rotation: 180
            }
            PropertyChanges {
                target: bar1
                rotation: 45
                width: 13 * sp
                x: 12.5 * sp
                y: 8 * sp
            }
            PropertyChanges {
                target: bar2
                width: 21 * sp
                x: 1.5 * sp
                y: 12 * sp
            }
            PropertyChanges {
                target: bar3
                rotation: -45
                width: 13 * sp
                x: 12.5 * sp
                y: 16 * sp
            }
        }
    ]

    transitions: [
        Transition {
            RotationAnimation {
                target: localRoot
                direction: RotationAnimation.Clockwise
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
            PropertyAnimation {
                target: bar1
                properties: "rotation, width, x, y"
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
            PropertyAnimation {
                target: bar2
                properties: "rotation, width, x, y"
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
            PropertyAnimation {
                target: bar3
                properties: "rotation, width, x, y"
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    ]
}

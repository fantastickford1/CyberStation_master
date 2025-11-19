import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: ListView.view ? ListView.view.width : 1000
    height: 110
    color: model.timerExpired ? "#ffebee" : "#ffffff"
    radius: 24
    border.color: model.timerExpired ? "#e74c3c" : "#eef0f5"
    border.width: model.timerExpired ? 3 : 1
    
    // Blinking animation for expired timer
    SequentialAnimation {
        running: model.timerExpired
        loops: Animation.Infinite
        PropertyAnimation {
            target: root
            property: "opacity"
            from: 1.0
            to: 0.7
            duration: 800
        }
        PropertyAnimation {
            target: root
            property: "opacity"
            from: 0.7
            to: 1.0
            duration: 800
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 48

        // 1. Icon + Name
        Row {
            spacing: 16
            Image {
                source: model.status === "busy"
                    ? "qrc:/icons/computer-red.svg"
                    : "qrc:/icons/computer-green.svg"
                width: 40; height: 40
                anchors.verticalCenter: parent.verticalCenter
            }
            Column {
                spacing: 4
                Text {
                    text: model.name || "KnownComputer"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#1a1a1a"
                }
                // Start Time
                Text {
                    text: model.startTime || "02.0292.am"
                    font.pixelSize: 14
                    color: "#888888"
                }
            }
        }

        // Current Time
        Text {
            text: model.currentTime || "02:02:92 am"
            font.pixelSize: 16
            color: "#2d3436"
            Layout.alignment: Qt.AlignVCenter
        }

        // 3. Duration badge (clickable when busy)
        Rectangle {
            width: 100; height: 40
            radius: 20
            color: {
                if (model.timerExpired) return "#e74c3c"
                if (model.timerActive) return "#f39c12"
                return model.status === "busy" ? '#b8b8b8' : "#e6f7ee"
            }
            Layout.alignment: Qt.AlignVCenter
            
            Text {
                anchors.centerIn: parent
                text: model.timerActive ? (model.timeRemaining || "0:00") : (model.duration || "0 hrs")
                color: {
                    if (model.timerExpired) return "white"
                    if (model.timerActive) return "white"
                    return model.status === "busy" ? '#ffffff' : "#27ae60"
                }
                font.bold: true
                font.pixelSize: 15
            }
            
            MouseArea {
                anchors.fill: parent
                enabled: model.status === "busy"
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: root.setTimerRequested(index)
            }
        }

        // 4. Availability
        Text {
            text: model.availability || "Available"
            font.pixelSize: 17
            font.bold: true
            color: {
                if (model.timerExpired) return "#e74c3c"
                return model.status === "busy" ? '#747474' : "#27ae60"
            }
            Layout.alignment: Qt.AlignVCenter
        }

        Item { Layout.fillWidth: true }

        // 5. BUTTONS
        Row {
            spacing: 16
            Layout.alignment: Qt.AlignVCenter

            // Add Services (always when busy)
            Button {
                visible: model.status === "busy"
                text: "Add Services"
                background: Rectangle { radius: 14; color: "#e3f2fd"; border.color: "#54a0ff"; border.width: 2 }
                contentItem: Text { color: "#54a0ff"; text: parent.text; font.bold: true }
            }
            
            // Clear Timer (only when timer is active)
            Button {
                visible: model.timerActive
                text: "Clear Timer"
                background: Rectangle { radius: 14; color: "#fff3cd"; border.color: "#f39c12"; border.width: 2 }
                contentItem: Text { color: "#f39c12"; text: parent.text; font.bold: true }
                onClicked: root.clearTimerRequested(index)
            }

            // START / END & PAY BUTTON
            Button {
                text: model.status === "busy" ? "End & Pay" : "Start"
                icon.source: model.status === "busy" ? "qrc:/icons/cash.svg" : "qrc:/icons/play.svg"
                icon.color: "white"

                background: Rectangle { 
                    radius: 14
                    color: model.status === "busy" ? '#54a0ff' : "#27ae60"
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    leftPadding: parent.icon.source.toString() ? 34 : 0
                }

                onClicked: {
                    if (model.status === "busy") {
                        root.endSessionRequested(index)
                    } else {
                        root.startSessionRequested(index)
                    }
                }
            }
        }
    }

    // Custom signals
    signal endSessionRequested(int modelIndex)
    signal startSessionRequested(int modelIndex)
    signal setTimerRequested(int modelIndex)
    signal clearTimerRequested(int modelIndex)
}
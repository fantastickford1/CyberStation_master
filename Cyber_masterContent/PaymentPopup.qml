import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    width: 420
    height: 340
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    anchors.centerIn: Overlay.overlay

    // Properties that will be filled from outside
    property int currentIndex: -1
    property string computerName: ""
    property string totalTime: ""
    property var model: null          // We'll pass the ListModel here

    background: Rectangle {
        radius: 24
        color: "#ffffff"
        border.color: "#e0e0e0"
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 28

        Text {
            text: "End Session & Payment"
            font.pixelSize: 26
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Column {
            spacing: 12
            Layout.alignment: Qt.AlignHCenter
            Text { text: "Computer:    <b>" + root.computerName + "</b>"; font.pixelSize: 18 }
            Text { text: "Total time:   <b>" + root.totalTime + "</b>"; font.pixelSize: 18 }
        }

        RowLayout {
            spacing: 20
            Layout.alignment: Qt.AlignHCenter

            Button {
                text: "Cancel"
                flat: true
                onClicked: root.close()
            }

            Button {
                text: "Confirm Payment"
                background: Rectangle {
                    radius: 16
                    color: "#27ae60"
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                }
                onClicked: {
                    if (root.currentIndex >= 0 && root.model) {
                        root.model.setProperty(root.currentIndex, "status", "available")
                        root.model.setProperty(root.currentIndex, "availability", "Available")
                        root.model.setProperty(root.currentIndex, "duration", "")
                        root.model.setProperty(root.currentIndex, "timerActive", false)
                        root.model.setProperty(root.currentIndex, "timerExpired", false)
                        root.model.setProperty(root.currentIndex, "timeRemaining", "")
                        root.model.setProperty(root.currentIndex, "timerMinutes", 0)
                    }
                    root.close()
                }
            }
        }
    }
}
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    width: 300
    height: 250
    anchors.centerIn: parent
    modal: true
    
    property int computerIndex: -1
    property string computerName: ""
    
    signal timerSet(int index, int minutes)
    
    onOpened: minutesInput.forceActiveFocus()
    
    Rectangle {
        anchors.fill: parent
        radius: 16
        color: "#ffffff"
        border.color: "#e8e8ec"
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20
            
            Text {
                text: `Set Timer for ${computerName}`
                font.pixelSize: 18
                font.bold: true
                color: "#1a1a1a"
                Layout.alignment: Qt.AlignHCenter
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                
                TextField {
                    id: minutesInput
                    Layout.preferredWidth: 100
                    validator: IntValidator { bottom: 1; top: 999 }
                    selectByMouse: true
                    background: Rectangle {
                        radius: 8
                        border.color: "#cccccc"
                        color: "#ffffff"
                    }
                }
                
                Text {
                    text: "minutes"
                    color: "#666666"
                }
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Button {
                    text: "Set Timer"
                    enabled: minutesInput.text.length > 0 && minutesInput.acceptableInput
                    background: Rectangle {
                        radius: 8
                        color: parent.enabled ? (parent.hovered ? "#4a90e2" : "#54a0ff") : "#cccccc"
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked: {
                        root.timerSet(root.computerIndex, parseInt(minutesInput.text))
                        root.close()
                    }
                }
                
                Button {
                    text: "Cancel"
                    background: Rectangle {
                        radius: 8
                        color: parent.hovered ? "#f5f5f5" : "transparent"
                        border.color: "#cccccc"
                    }
                    onClicked: root.close()
                }
            }
        }
    }
}
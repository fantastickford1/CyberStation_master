import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 1200
    height: 740
    color: "#f5f6fa"
    radius: 24

    // Expose model from outside
    property var computerModel

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // LEFT SIDEBAR
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 80
            color: "#ffffff"
            radius: 20
            border.color: "#e8e8ec"

            Column {
                anchors.centerIn: parent
                spacing: 40

                Repeater {
                    model: ["home", "user", "message", "settings", "calendar"]
                    delegate: Button {
                        width: 56
                        height: 56
                        flat: true
                        icon.source: `qrc:/icons/${modelData}.svg`
                        icon.width: 28
                        icon.height: 28
                        background: Rectangle {
                            radius: 16
                            color: parent.hovered ? "#f0f0ff" : "transparent"
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                // Bottom icon (more options)
                Button {
                    width: 56
                    height: 56
                    flat: true
                    icon.source: "qrc:/icons/dots-horizontal.svg"
                    icon.width: 28
                    icon.height: 28
                    background: Rectangle {
                        radius: 16
                        color: parent.hovered ? "#f0f0ff" : "transparent"
                    }
                }
            }
        }

        // MAIN CONTENT AREA
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 30
            spacing: 24

            // Header
            RowLayout {
                spacing: 20

                Image {
                    source: "qrc:/icons/cafe-logo.svg"
                    sourceSize: Qt.size(48, 48)
                }

                Text {
                    text: "Cyber Café Management"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#1a1a1a"
                }

                Item {
                    Layout.fillWidth: true
                }

                Row {
                    spacing: 20
                    Repeater {
                        model: ["bell", "dots-vertical", "menu"]
                        delegate: Image {
                            source: `qrc:/icons/${modelData}.svg`
                            sourceSize: Qt.size(28, 28)
                        }
                    }
                }

                Image {
                    source: "qrc:/images/cafe-bg.png"
                    sourceSize: Qt.size(90, 90)
                }
            }

            // Computers List (no search bar!)
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: availableWidth

                ListView {
                    id: listView
                    spacing: 20
                    model: root.computerModel
                    delegate: ComputerCard {
                        id: computerCard
                        
                        Connections {
                            target: computerCard
                            function onEndSessionRequested(index) {
                                paymentPopup.currentIndex = index
                                paymentPopup.computerName = model.name
                                paymentPopup.totalTime = model.duration
                                paymentPopup.open()
                            }
                            function onStartSessionRequested(index) {
                                listView.model.setProperty(index, "status", "busy")
                                listView.model.setProperty(index, "availability", "Busy")
                            }
                            function onSetTimerRequested(index) {
                                timerPopup.computerIndex = index
                                timerPopup.computerName = listView.model.get(index).name
                                timerPopup.open()
                            }
                            function onClearTimerRequested(index) {
                                listView.model.setProperty(index, "timerActive", false)
                                listView.model.setProperty(index, "timerExpired", false)
                                listView.model.setProperty(index, "timeRemaining", "")
                                listView.model.setProperty(index, "timerMinutes", 0)
                            }
                        }
                    }
                }
            }
        }
    }

    PaymentPopup {
        id: paymentPopup
        model: listView.model
    }
    
    TimerPopup {
        id: timerPopup
    }
    
    Connections {
        target: timerPopup
        function onTimerSet(index, minutes) {
            listView.model.setProperty(index, "timerActive", true)
            listView.model.setProperty(index, "timerMinutes", minutes)
            listView.model.setProperty(index, "timeRemaining", minutes + ":00")
            listView.model.setProperty(index, "timerExpired", false)
        }
    }
}
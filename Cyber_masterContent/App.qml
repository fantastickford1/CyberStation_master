import QtQuick
import Cyber_master

Window {
    width: 1280
    height: 800

    visible: true
    title: "Cyber_master"

    MainDashboard {
        id: mainScreen
        anchors.fill: parent
        computerModel: ListModel {
            ListElement {
                name: "Comp1"
                startTime: "00:00.00"
                currentTime: "00:00"
                duration: "0 hrs"
                availability: "Available"
                status: "available"
                timerActive: false
                timerExpired: false
                timeRemaining: ""
                timerMinutes: 0
            }
            ListElement {
                name: "Comp2"
                startTime: "00:00.00"
                currentTime: "00:00"
                duration: "0 hrs"
                availability: "Available"
                status: "available"
                timerActive: false
                timerExpired: false
                timeRemaining: ""
                timerMinutes: 0
            }
            ListElement {
                name: "Comp3"
                startTime: "10:15.00"
                currentTime: "12:30"
                duration: "2 hrs 15 min"
                availability: "Busy"
                status: "busy"
                timerActive: false
                timerExpired: false
                timeRemaining: ""
                timerMinutes: 0
            }
            ListElement {
                name: "Comp4"
                startTime: "11:00.00"
                currentTime: "12:30"
                duration: "1 hr 30 min"
                availability: "Busy"
                status: "busy"
                timerActive: true
                timerExpired: false
                timeRemaining: "15:30"
                timerMinutes: 45
            }
            ListElement {
                name: "Comp5"
                startTime: "09:30.00"
                currentTime: "12:30"
                duration: "3 hrs"
                availability: "Busy"
                status: "busy"
                timerActive: true
                timerExpired: true
                timeRemaining: "0:00"
                timerMinutes: 120
            }
            ListElement {
                name: "Comp6"
                startTime: "00:00.00"
                currentTime: "00:00"
                duration: "0 hrs"
                availability: "Available"
                status: "available"
                timerActive: false
                timerExpired: false
                timeRemaining: ""
                timerMinutes: 0
            }
        }
    }

}


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
        computerModel: computerModel  // Use Python model from context
    }

}


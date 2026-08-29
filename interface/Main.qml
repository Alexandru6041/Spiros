import QtQuick
import QtQuick.Window

Window {
    id:window

    width: 900
    height:600
    visible: true
    title: "SpirosApp"

    property string currentUser: ""

    Loader {
        id:screenContainer
        anchors.fill: parent
        sourceComponent: authComponent
    }

    Component {
        id: authComponent

        Auth {
            onAuthSuccess: (username) => {
                window.currentUser = username
                screenContainer.sourceComponent = dashboardComponent
            }
        }
    }

    Component {
        id: dashboardComponent

        Dashboard {
            username: window.currentUser
        }
    }
}

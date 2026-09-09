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

    Database {
        id: db
    }

    PlatformRepository {
        id: platformRepository
        database: db
    }

    ArtistRepository {
        id: artistiRepository
        database: db
    }

    PieseRepository {
        id: pieseRepository
        database: db
    }

    ContractRepository {
        id: contractRepository
        database: db
    }

    Component {
        id: authComponent

        Auth {
            bridge: db
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
            platformRepo: platformRepository
            artistRepo: artistiRepository
            pieseRepo: pieseRepository
            contractRepo: contractRepository

        }
    }
}

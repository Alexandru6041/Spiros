import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Effects
import QtQuick.Layouts

Item {
    id:dashboard

    anchors.fill: parent

    property string username: ""
    property string currentPage: "panou"

    property int animationDuration: 250

    property var platformRepo: null
    property var pieseRepo: null
    property var contractRepo: null
    property var colaboratorRepo: null

    Component.onCompleted: console.log("[DEBUG] DASHBOARD platform repo: ", platformRepo)

    Row {
        anchors.fill: parent

        ///Sidebar left
        Rectangle {
            id: sidebar
            width: 200
            height: parent.height
            color: "#2a0d16"

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 28
                spacing: 4

                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    spacing: 2
                    bottomPadding :24

                    Text {
                        text: "Spiros"
                        color: "#ecdad6"
                        font.pixelSize: 36
                        font.family: "Georgia"
                    }

                    Text {
                        text: "Official"
                        color: "#8f5c68"
                        font.pixelSize: 18
                        font.letterSpacing: 1.5
                        font.family: "Times new roman"
                    }
                }

                Repeater {
                    model: [
                        { label: "Panou", page: "panou"},
                        { label: "Colaboratori", page: "colaboratori"},
                        { label: "Piese", page: "piese"},
                        { label: "Albume", page: "albume"},
                        { label: "Contracte", page: "contracte"},
                        { label: "Distributie", page: "distributie"}

                    ]

                    Rectangle {
                        width: sidebar.width
                        height: 44
                        color: dashboard.currentPage === modelData.page ? "#3d1420" : "transparent"


                        Behavior on color {
                            ColorAnimation {
                                duration: animationDuration
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Rectangle {
                            width: 2
                            height: parent.height
                            color: "#A04A5E"
                            opacity: dashboard.currentPage === modelData.page ? 1 : 0

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: animationDuration
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 24
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 11

                            Text {
                                text: modelData.label

                                color: modelData.page === dashboard.currentPage ? "#F2E4E0" : "#B98C94"
                                Behavior on color {
                                    ColorAnimation {
                                        duration: animationDuration
                                    }
                                }

                                font.pixelSize: 15
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                dashboard.currentPage = modelData.page
                                console.log("Switched to page: ", modelData.page)
                            }
                        }
                    }
                }

            }
        }
        Rectangle {
            width: parent.width - sidebar.width
            height: parent.height

            color: "#F2EBE2"

            Loader {
                id:contentLoader

                anchors.fill: parent

                width: parent.width - sidebar.width
                height: parent.height

                sourceComponent: {
                    if(dashboard.currentPage === "panou")
                        return panouPage

                    if(dashboard.currentPage === "colaboratori")
                        return colaboratorPage

                    return panouPage
                }

                onLoaded: {
                    if(item) {
                        item.opacity = 0
                        fadeIn.restart()
                    }
                }


                NumberAnimation {
                    id: fadeIn
                    target: contentLoader.item

                    property: "opacity"
                    from: 0
                    to: 1



                    duration: animationDuration
                    easing.type: Easing.InOutQuad
                }
            }
        }



    }

    ///Right Panel
    Component {
        id:panouPage

        Rectangle {
            color: "#F2EBE2"

            Column {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 22


                Row {
                    width: parent.width

                    Column {
                        width: parent.width - 46
                        spacing: 2

                        Text {
                            text: {
                                var current_date = new Date().getHours()
                                var greeting = current_date < 12 && current_date > 5 ? "Buna dimineata" : (current_date < 18 ? "Buna ziua" : "Buna seara")
                                return greeting + ", " + dashboard.username
                            }
                            color: "#2a0d16"
                            font.pixelSize: 23
                            font.family: "Georgia"

                        }

                        Text {
                            text: Qt.formatDate(new Date(), "dddd, d MMMM yyyy")
                            color: "#8a6b70"
                            font.pixelSize: 13
                        }
                    }

                    Rectangle {
                        width: 38
                        height: 38
                        radius: 19
                        color: "#2a0d16"
                        Text {
                            anchors.centerIn: parent
                            text: dashboard.username.charAt(0).toUpperCase()
                            color: "#ECDAD6"
                            font.pixelSize: 14
                            font.family: "Georgia"
                        }
                    }
                }

                ///Stats Cards

                Row {
                    width: parent.width
                    spacing: 14


                    Rectangle {
                        width: (parent.width - 28) / 3
                        height: 90
                        radius: 10
                        color: "#ffffff"
                        border.color: "#E3D5C8"
                        border.width: 1

                        Column {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.margins: 16
                            spacing: 8

                            Text {text: "ARTISTI"; color: "#8A6B70"; font.pixelSize: 11; font.letterSpacing: 0.5}
                            Text {text: colaboratorRepo ? colaboratorRepo.getCount() : "0"; color: "#2A0D16"; font.pixelSize: 30; font.family: "Georgia"}
                        }
                    }

                    Rectangle {
                        width: (parent.width - 28) / 3
                        height: 90
                        radius: 10
                        color: "#ffffff"
                        border.color: "#E3D5C8"
                        border.width: 1

                        Column {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.margins: 16
                            spacing: 8

                            Text {text: "PIESE"; color: "#8A6B70"; font.pixelSize: 11; font.letterSpacing: 0.5}
                            Text {text: pieseRepo ? pieseRepo.getCount() : "0"; color: "#2A0D16"; font.pixelSize: 30; font.family: "Georgia"}
                        }
                    }


                    Rectangle {
                        width: (parent.width - 28) / 3
                        height: 90
                        radius: 10
                        color: "#ffffff"
                        border.color: "#E3D5C8"
                        border.width: 1

                        Column {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.margins: 16
                            spacing: 8

                            Text {text: "CONTRACTE"; color: "#8A6B70"; font.pixelSize: 11; font.letterSpacing: 0.5}
                            Text {text: contractRepo ? contractRepo.getCount() : "0"; color: "#2A0D16"; font.pixelSize: 30; font.family: "Georgia"}
                        }
                    }


                }


                ///Distribution Panel
                Rectangle {
                    id: distributionPanel
                    width: parent.width
                    height: distColumn.height + 50
                    radius: 10
                    color: "#ffffff"
                    border.color: "#E3D5C8"
                    border.width: 1


                    Column {
                        id: distColumn
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 18
                        spacing: 14

                        Row {
                            spacing: 8

                            Text{
                                text:"Distributie pe platforme"
                                color: "#2A0D16"
                                font.pixelSize: 13
                                font.bold: true

                            }
                        }

                        ///Slidere Platforme
                        Repeater {
                            model: platformRepo ? platformRepo.getTopPlatforms() : []

                            Column {
                                width: distributionPanel.width - 36
                                spacing: 5


                                Row {
                                    width: parent.width

                                    Text {
                                        text: modelData.nume
                                        color: "#2A0D16"
                                        font.pixelSize: 12
                                        width: parent.width - 60
                                    }


                                    Text {
                                        text: modelData.distribuite + " / " + modelData.total
                                        color: "#8A6B70"
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignRight
                                        width: 60
                                    }
                                }


                                Rectangle {
                                    width: parent.width
                                    height: 6
                                    radius: 3
                                    color: "#EFE5DA"
                                    Rectangle {
                                        width: parent.width * (Number(modelData.distribuite) / Number(modelData.total))
                                        height: parent.height
                                        radius: 3
                                        color: "#7A2438"
                                    }
                                }
                            }
                        }

                    }
                }

                Rectangle {
                    id: expAlert
                    width: parent.width
                    height: 52
                    radius: 10
                    color:"#ffffff"
                    border.color: "#E3D5C8"
                    border.width: 1
                    visible: true


                    Row {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 18
                        anchors.rightMargin: 18
                        spacing: 9


                        Image {
                            id: alertIcon
                            source:"icons/svgs/solid/exclamation-triangle.svg" ///"icons/svgs/regular/file-excel.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                            sourceSize.width: 15
                            sourceSize.height: 15


                            opacity: 0.8

                        }


                        Text {
                            text: "Contractul 123/12.03.2024 expira in 15 zile"
                            color: "#6E5058"
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 130

                        }

                        Text {
                            text: "Reinnoieste ->"
                            color: "#A04A5E"
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter

                        }
                    }

                }

            }

        }
    }




    Component {
        id: colaboratorPage
        Rectangle {
            id:colaboratorRoot
            color: "#F2EBE2"

            property int selectedId: -1
            property int reloadFlag: 0

            property string searchText: ""
            property string typeFilter: ""
            property string selectedType: ""
            property string statusFilter: "true"

            property var artists: {
                reloadFlag
                return dashboard.colaboratorRepo ? dashboard.colaboratorRepo.listColaboratori(typeFilter, searchText, statusFilter) : []
            }

            Loader {
                anchors.fill: parent
                sourceComponent: {
                    if(colaboratorRoot.selectedId === -1) return listView

                    if(colaboratorRoot.selectedType === "Artist")
                        return artistDetailView

                    if(colaboratorRoot.selectedType === "SRL")
                        return srlDetailView

                    return colaboratorDetailView
                }
            }

            Component {
                id:listView

                Rectangle {
                    color: "#F2EBE2"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 30
                        spacing: 18

                        Row {
                            width: parent.width

                            Text {
                                text: "Artisti"
                                color: "#2A0D16"

                                font.pixelSize: 24
                                font.family: "Georgia"

                                width: parent.width - 140
                            }

                            ///Top Buttons
                            Rectangle {
                                width: 130
                                height: 36
                                radius: 7

                                color: "#4E1826"
                                Text {
                                    anchors.centerIn: parent

                                    text: "+ Adauga artist"
                                    color: "#ECDAD6"
                                    font.pixelSize: 12
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: console.log("Add artist button clicked")
                                }
                            }
                        }

                        ///Filters
                        Row {
                            width: parent.width
                            spacing: 16

                            ///TypeFilters
                            Rectangle {
                                width: filterRow.width + 6
                                height: 34
                                radius: 9
                                color: "#E8DDD0"

                                Row {
                                    id: filterRow
                                    anchors.centerIn: parent

                                    spacing: 2

                                    Repeater {
                                        model: [
                                            {label: "Toti", value:  ""},
                                            {label: "Artisti", value: "artist"},
                                            {label: "Colaboratori", value: "colaborator"},
                                            {label: "Societati Comerciale", value: "srl"}
                                        ]


                                        Rectangle {
                                            width: segText.width + 28
                                            height: 28
                                            radius: 7
                                            color: colaboratorRoot.typeFilter === modelData.value ? "#2A0D16" : "transparent"

                                            Behavior on color {
                                                ColorAnimation {
                                                    duration: 150
                                                }
                                            }

                                            Text {
                                                id: segText
                                                anchors.centerIn: parent
                                                text: modelData.label
                                                font.pixelSize: 12

                                                color: colaboratorRoot.typeFilter === modelData.value ? "#F2E4E0" : "#6E5058"
                                                Behavior on color {

                                                    ColorAnimation {
                                                        duration: 150
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: colaboratorRoot.typeFilter = modelData.value
                                            }
                                        }
                                    }
                                }
                            }

                            ///Active/Inactive Filter TODO
                            Rectangle {
                                width: statusRow.width + 6
                                height: 34
                                radius: 9
                                color: "#E8DDD0"

                                Row {
                                    id: statusRow

                                    anchors.centerIn: parent
                                    spacing: 2
                                    Repeater {
                                        model: [
                                            {label: "Activi", value: "true"},
                                            {label: "Inactivi", value: "false"}
                                        ]

                                        Rectangle {
                                            width: stText.width + 24
                                            height: 28
                                            radius: 7

                                            anchors.verticalCenter: parent.verticalCenter
                                            color: colaboratorRoot.statusFilter === modelData.value ? "#2A0D16" : "transparent"
                                            Behavior on color {
                                                ColorAnimation {
                                                    duration: 150
                                                }
                                            }

                                            Text {
                                                id:stText

                                                anchors.centerIn: parent
                                                text: modelData.label
                                                font.pixelSize: 12
                                                color: colaboratorRoot.statusFilter === modelData.value ? "#F2E4E0" : "#6E5058"
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: colaboratorRoot.statusFilter = modelData.value
                                            }
                                        }
                                    }
                                }
                            }
                        }


                        //Search Box
                        Rectangle {
                            width: parent.width
                            height: 40
                            radius: 8
                            color: "#ffffff"
                            border.color: "#E3D5C8"
                            border.width: 1


                            TextField {
                                id:searchField

                                anchors.fill: parent

                                anchors.leftMargin: 10
                                placeholderText: "Cauta dupa nume sau alias..."

                                font.pixelSize: 13
                                color: "#2A0D16"

                                background: null
                                verticalAlignment: TextInput.AlignVCenter

                                onTextChanged: colaboratorRoot.searchText = text
                            }
                        }

                        ///Column headers
                        RowLayout {
                            width: parent.width
                            spacing: 11

                            Item{
                                Layout.preferredWidth: 30
                            }

                            Text {
                                Layout.preferredWidth: 180
                                text: "NUME"

                                color: "#8A6B70"
                                font.pixelSize: 11
                            }

                            Text {
                                text: "TIP"
                                color: "#8A6B70"
                                font.pixelSize: 11
                                Layout.preferredWidth: 65
                                horizontalAlignment: Text.AlignHCenter

                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            Text {
                                text: "PIESE"

                                color: "#8A6B70"
                                font.pixelSize: 11
                                Layout.preferredWidth:  50
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                text: "CONTRACTE"

                                color: "#8A6B70"
                                font.pixelSize: 11
                                Layout.preferredWidth: 100
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        ///List
                        Rectangle {
                            width: parent.width
                            height: parent.height - 160

                            radius: 10
                            color: "#ffffff"
                            border.color: "#E3D5C8"
                            border.width: 1

                            clip: true

                            ListView {
                                anchors.fill: parent

                                anchors.margins: 1
                                model: artists
                                clip: true

                                delegate: Rectangle {
                                    width:ListView.view.width
                                    height: 50

                                    color: rowMouse.containsMouse ? "#FAF6F0" : "transparent"

                                    RowLayout {
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 14
                                        anchors.rightMargin: 14

                                        spacing: 11
                                        ///Avatar
                                        Rectangle {
                                            Layout.preferredWidth: 30
                                            Layout.preferredHeight: 30
                                            radius: 15
                                            color: "#E8D3D0"

                                            Layout.alignment: Qt.AlignVCenter

                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.nume ? modelData.nume.charAt(0).toUpperCase() : "?"
                                                color: "#5A1F2C"
                                                font.pixelSize: 12
                                            }
                                        }

                                        ///Name
                                        Text {
                                            Layout.preferredWidth: 180
                                            Layout.alignment: Qt.AlignVCenter
                                            text: modelData.nume ? modelData.nume : "(necunoscut)"
                                            color: "#2A0D16"
                                            font.pixelSize: 14
                                            elide: Text.ElideRight
                                        }

                                        ///Type Badge
                                        Rectangle {
                                            Layout.preferredWidth: badgeText.width + 16
                                            Layout.preferredHeight: 20
                                            radius: 10
                                            Layout.alignment: Qt.AlignVCenter

                                            color: {
                                                if(modelData.tip_afisat === "SRL")
                                                    return "#D0DAE0"
                                                else if(modelData.tip_afisat === "Artist")
                                                    return "#E3D0D5"

                                                return "#DAE0D0"
                                            }

                                            Text {
                                                id:badgeText
                                                anchors.centerIn: parent
                                                text: modelData.tip_afisat
                                                font.pixelSize: 10

                                                color: {
                                                    if(modelData.tip_afisat === "SRL")
                                                        return "#2C4A5A"
                                                    else if(modelData.tip_afisat === "Artist")
                                                        return "#7A2438"

                                                    return "#3A4A2C"
                                                }
                                            }
                                        }

                                        Item {
                                            Layout.fillWidth: true
                                        }

                                        ///Song Count
                                        Text {
                                            text: modelData.nr_piese
                                            color: "#6E5058"
                                            Layout.alignment: Qt.AlignVCenter
                                            font.pixelSize: 13
                                            Layout.preferredWidth: 60
                                            horizontalAlignment: Text.AlignHCenter
                                        }


                                        ///Contracte Count
                                        Text {
                                            text: modelData.nr_contracte

                                            color: "#6E5058"
                                            font.pixelSize: 13
                                            Layout.alignment: Qt.AlignVCenter
                                            Layout.preferredWidth:80
                                            horizontalAlignment: Text.AlignHCenter
                                        }
                                    }

                                    ///Separator Line
                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        width: parent.width
                                        height: 0.5
                                        color: "#EFE5DA"
                                    }

                                    MouseArea {
                                        id: rowMouse
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onClicked: {
                                            console.log("Open detail: ", modelData.id, modelData.nume)
                                            colaboratorRoot.selectedId = modelData.id
                                            colaboratorRoot.selectedType = modelData.tip_afisat
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Component {
                id: artistDetailView

                Rectangle {
                    id: detailRoot
                    color: "#F2EBE2"

                    property bool editing: false

                    property int infoReload: 0

                    property string editNume: ""
                    property string editAdresa: ""
                    property string editCUI: ""
                    property string editObservatii: ""

                    property var info: {
                        infoReload
                        return dashboard.colaboratorRepo ? dashboard.colaboratorRepo.getArtistInfo(colaboratorRoot.selectedId) : []
                    }
                    property var songs: dashboard.colaboratorRepo ? dashboard.colaboratorRepo.getArtistSongs(colaboratorRoot.selectedId) : []
                    property var contracts: dashboard.colaboratorRepo ? dashboard.colaboratorRepo.getArtistContracts(colaboratorRoot.selectedId) : []
                    property var artist: info.length > 0 ? info[0] : ({})
                    property var representations: dashboard.colaboratorRepo ? dashboard.colaboratorRepo.getRepresentations(colaboratorRoot.selectedId) : []

                    property var aliases: []


                    function refreshInfo() {
                        infoReload++
                    }

                    function enterEdit() {
                        editNume = artist.nume ? artist.nume : ""
                        editCUI = artist.cui ? artist.cui : ""
                        editAdresa = artist.adresa ? artist.adresa : ""
                        editObservatii = artist.observatii ? artist.observatii : ""
                        editing = true
                    }

                    function cancelEdit() {
                        editing = false
                    }

                    function saveEdit() {
                        ///TODO
                        dashboard.colaboratorRepo.updateArtist(
                            colaboratorRoot.selectedId,
                            editNume,
                            editCUI,
                            editAdresa,
                            editObservatii
                        )
                        editing = false
                        refreshInfo()
                    }

                    function refreshAliases() {
                        aliases = []
                        aliases = dashboard.colaboratorRepo.getArtistAliases(colaboratorRoot.selectedId)
                    }

                    function addNewAlias() {
                        var a = newAliasField.text.trim()
                        console.log("Add alias button clicked, text: ", a, "name: ", artist.nume, "id: ", colaboratorRoot.selectedId)
                        if(a !== "") {
                            dashboard.colaboratorRepo.addAlias(colaboratorRoot.selectedId, a)
                            newAliasField.text = ""
                            detailRoot.refreshAliases()
                        }
                    }

                    Component.onCompleted: refreshAliases()

                    ScrollView {
                        id:detailScroll
                        anchors.fill: parent
                        anchors.rightMargin: 8
                        clip: true
                        contentWidth: availableWidth
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff


                        Column {
                            width: detailScroll.availableWidth
                            anchors.fill: parent
                            leftPadding: 30
                            rightPadding: 40
                            topPadding: 20
                            bottomPadding: 30
                            spacing: 16

                            ///Top Bar Buttons
                            Item {
                                width: parent.width - 50
                                height: 30

                                ///Back Button
                                Text {
                                    text: "< Inapoi"
                                    color: "#8A6B70"
                                    anchors.left: parent.left
                                    font.pixelSize: 13
                                    width: parent.width - 250
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: colaboratorRoot.selectedId = -1
                                    }
                                }

                                Row {
                                    spacing: 8
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter

                                    Rectangle {
                                        visible: !detailRoot.editing
                                        width: 80
                                        height: 30
                                        radius: 6

                                        color: "transparent"
                                        border.color: "#C9B8A8"
                                        border.width: 1
                                        Text {
                                            anchors.centerIn: parent
                                            text: "Editeaza"
                                            color: "#6E5058"
                                            font.pixelSize: 12
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked:
                                            {
                                                console.log ("Edit button pressed on artist detail page ")
                                                detailRoot.enterEdit()
                                            }
                                        }
                                    }

                                    Rectangle {
                                        visible: !detailRoot.editing
                                        width: toggleText.width + 24
                                        height: 30
                                        radius: 6

                                        property bool isActive: artist.activ === "t" || artist.activ === "true"

                                        color: "transparent"
                                        border.color: isActive ? "#C9B8A8" : "#2D6A4F"
                                        border.width: 1

                                        Text {
                                            id:toggleText
                                            anchors.centerIn: parent
                                            text: parent.isActive ? "Inactiv" : "Restabileste"
                                            color: parent.isActive ? "#6E5058" : "#2D6A4F"
                                            font.pixelSize: 12
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if(parent.isActive) {
                                                    console.log ("Inactive button pressed on " + artist.nume  + "'s detail page.")
                                                    confirmOverlay.openWith("Sigur vreti sa marcati acest artist ca inactiv?\n" + artist.nume +" va fi ascuns din lista.\nDupa confirmare veti fi redirectionat catre pagina 'Colaboratori'",
                                                                            "Seteaza inactiv",
                                                                            function (){
                                                                                dashboard.colaboratorRepo.setInactive(colaboratorRoot.selectedId)
                                                                                colaboratorRoot.reloadFlag++
                                                                                colaboratorRoot.selectedId = -1
                                                                            })
                                                } else {
                                                    console.log ("Reactivate button pressed on " + artist.nume  + "'s detail page.")
                                                    confirmOverlay.openWith("Sigur vreti sa restabiliti acest artist?\n" + "Dupa confirmare veti fi redirectionat catre pagina 'Colaboratori'",
                                                                            "Restabileste",
                                                                            function (){
                                                                                dashboard.colaboratorRepo.setActive(colaboratorRoot.selectedId)
                                                                                colaboratorRoot.reloadFlag++
                                                                                colaboratorRoot.selectedId = -1
                                                                            })
                                                }
                                            }
                                        }
                                    }

                                    Rectangle {
                                        visible: !detailRoot.editing
                                        width: 70
                                        height: 30
                                        radius: 6

                                        color: "transparent"
                                        border.color: "#D9A9A9"
                                        border.width: 1
                                        Text {
                                            anchors.centerIn: parent
                                            text: "Sterge"
                                            color: "#9B2226"
                                            font.pixelSize: 12
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                console.log ("DELETE button pressed on artist " + artist.nume + " detail page.")


                                                function joinSi(arr) { ///Joining the parti[] with a 'si' before the last member of the array for gramatical purposes.
                                                    if(arr.length === 0)
                                                        return ""
                                                    if(arr.length === 1)
                                                        return arr[0]

                                                    return arr.slice(0, -1).join(", ") + " si " + arr[arr.length - 1]
                                                }

                                                var d = dashboard.colaboratorRepo.getDependencies(colaboratorRoot.selectedId)[0]
                                                var total = Number(d.nr_piese) + Number(d.nr_contracte) + Number(d.nr_semnate) + Number(d.nr_reprezentari)

                                                if(total === 0) {
                                                    confirmOverlay.openWith(
                                                        "Sigur vreti sa stergeti definitiv artistul " + artist.nume + "?\nAceasta actiune este permanenta si nu poate fi anulata.",
                                                        "Sterge definitiv",
                                                        function() {
                                                            dashboard.colaboratorRepo.deleteArtist(colaboratorRoot.selectedId)
                                                            colaboratorRoot.reloadFlag++
                                                            colaboratorRoot.selectedId = -1
                                                        }
                                                    )
                                                } else {
                                                    var parti = []
                                                    var isActive = artist.activ === "t" || artist.activ === "true"
                                                    if(Number(d.nr_piese) > 0)
                                                        parti.push(d.nr_piese + ((Number(d.nr_piese === 1)) ? " piesa" : " piese"))
                                                    if(Number(d.nr_contracte) > 0)
                                                        parti.push(d.nr_contracte + ((Number(d.nr_contracte) === 1) ? " contracte asociate" : " contract asociat"))
                                                    if(Number(d.nr_semnate) > 0)
                                                        parti.push(d.nr_semnate + ((Number(d.nr_semnate) === 1) ? " contracte semnate" : " contract semnat"))
                                                    if(Number(d.nr_reprezentari) > 0)
                                                        parti.push(d.nr_reprezentari + ((Number(d.nr_reprezentari) === 1) ? " pozitie de reprezentant intr-un SRL" : " pozitii de reprezentant in SRL-uri"))

                                                    if(isActive) {
                                                        confirmOverlay.openWith(
                                                            artist.nume + " nu poate fi sters/stearsa, deoarece are " + joinSi(parti) + ".\nArtistul poate fi dezactivat, datele acestuia fiind pastrate in siguranta.",
                                                            "Seteaza inactiv",
                                                            function() {
                                                                dashboard.colaboratorRepo.setInactive(colaboratorRoot.selectedId)
                                                                colaboratorRoot.reloadFlag++
                                                                colaboratorRoot.selectedId = -1
                                                            }
                                                        )
                                                    } else {
                                                        confirmOverlay.openAcknowledge(
                                                            artist.nume + " nu poate fi sters/stearsa, deoarece are " + joinSi(parti) + ".\n" + artist.nume + " este deja inactiv.",
                                                            "Am inteles",
                                                            function() {}
                                                        )
                                                    }
                                                }

                                            }
                                        }
                                    }


                                    ///Editing mode buttons
                                    Rectangle {
                                        visible: detailRoot.editing
                                        width: 90
                                        height: 30
                                        radius: 6

                                        color: "#4E1826"
                                        Text {
                                            anchors.centerIn: parent;
                                            text: "Salveaza"
                                            color: "#ECDAD6"
                                            font.pixelSize: 12
                                        }

                                        MouseArea {
                                            anchors.fill: parent;
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                console.log("The following edits were saved for artist " + artist.nume + "\n\tNume: " + detailRoot.editNume + "\n\tAdresa: " + detailRoot.editAdresa + "\n\tCUI: " + detailRoot.editCUI + "\n\tObservatii: " + detailRoot.editObservatii)
                                                detailRoot.saveEdit()
                                            }
                                        }
                                    }

                                    Rectangle {
                                        visible: detailRoot.editing
                                        width: 90
                                        height: 30
                                        radius: 6

                                        color: "transparent"
                                        border.color: "#C9B8A8"
                                        border.width: 1
                                        Text {
                                            anchors.centerIn: parent;
                                            text: "Anlueaza"
                                            color: "#6E5058"
                                            font.pixelSize: 12
                                        }

                                        MouseArea {
                                            anchors.fill: parent;
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                console.log("Edits for artist " + detailRoot.editNume + " have been canceled")
                                                detailRoot.cancelEdit()
                                            }
                                        }
                                    }
                                }
                            }


                            ///Artist Header
                            Row {
                                spacing: 14

                                Rectangle {
                                    width: 52
                                    height: 52
                                    radius: 26
                                    color: "#E8D3D0"

                                    Text {
                                        anchors.centerIn: parent
                                        text: artist.nume ? artist.nume.charAt(0).toUpperCase() : "?"
                                        color: "#5A1F2C"
                                        font.pixelSize: 19
                                        font.family: "Georgia"
                                    }
                                }

                                Column {
                                    spacing: 2

                                    Row {
                                        spacing: 9

                                        Item {
                                            width: detailRoot.editing ? 280 : 195
                                            height: 40

                                            ///VIEW-ONLY
                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: artist.nume ? artist.nume : "(necunoscut)"
                                                color: "#2A0D16"
                                                font.pixelSize: 24
                                                font.family: "Georgia"
                                                opacity: detailRoot.editing ? 0 : 1
                                                visible: opacity > 0
                                                Behavior on opacity {
                                                    NumberAnimation {
                                                        duration: 200
                                                        easing.type: Easing.InOutQuad
                                                    }
                                                }
                                            }

                                            ///EDITING
                                            Rectangle {
                                                anchors.fill: parent
                                                radius: 7
                                                color: "#ffffff"
                                                border.color: "#A04A5E"
                                                border.width: 1.5
                                                opacity: detailRoot.editing ? 1: 0
                                                visible: opacity > 0
                                                Behavior on opacity {
                                                    NumberAnimation {
                                                        duration: 200
                                                        easing.type: Easing.InOutQuad
                                                    }
                                                }

                                                TextField {
                                                    anchors.fill: parent
                                                    anchors.margins:3
                                                    anchors.leftMargin: 10
                                                    text: detailRoot.editNume
                                                    font.pixelSize: 20
                                                    font.family: "Georgia"
                                                    color: "#2A0D16"
                                                    background: null
                                                    verticalAlignment: TextInput.AlignVCenter

                                                    enabled: detailRoot.editing
                                                    onTextChanged: detailRoot.editNume = text
                                                }
                                            }
                                        }

                                        ///Type Badge
                                        Rectangle {
                                            width: badgeText.width + 16
                                            height: 20
                                            radius: 10

                                            anchors.verticalCenter: parent.verticalCenter
                                            color: artist.tip_afisat === "SRL" ? "#D0DAE0" : (artist.tip_afisat === "Artist" ? "#E3D0D5" : (artist.tip_afiast === "Colaborator" ? "#DAE0D0" : "#E3D0D5"))
                                            Text {
                                                id: badgeText
                                                anchors.centerIn: parent
                                                text: artist.tip_afisat ? artist.tip_afisat : "STATUS MISMATCH"
                                                font.pixelSize: 10
                                                color: artist.tip_afisat === "SRL" ? "#2C4A5A" : (artist.tip_afisat === "Artist" ? "#7A2438" : (artist.tip_afisat === "Colaborator" ? "#3A4A2C" : "#7A2438"))

                                            }
                                        }
                                    }

                                    Text {
                                        text: songs.length + (songs.length === 1 ? " piesa · " : " piese · ") + contracts.length +  (contracts.length === 1 ? " contracte · " : " contracte · ") + aliases.length  + (aliases.length === 1 ? " alias" : " alias-uri")
                                        color: "#8A6B70"
                                        font.pixelSize: 14
                                    }

                                    Item {
                                        width: 400
                                        height: detailRoot.editing ? 28 : cuiRow.height

                                        Row {
                                            id: cuiRow
                                            spacing: 16
                                            opacity: detailRoot.editing ? 0 : 1
                                            visible: opacity > 0 && (!!artist.cui || !!artist.adresa)
                                            Behavior on opacity {
                                                NumberAnimation {
                                                    duration: 200
                                                    easing.type: Easing.InOutQuad
                                                }
                                            }

                                            Text {
                                                visible: !!artist.cui ? true : false
                                                text: "CUI: " + (!!artist.cui ? artist.cui : "")
                                                color: "#A8998A"
                                                font.pixelSize: 11
                                            }
                                            Text {
                                                visible: artist.adresa ? true : false

                                                text: "Adresa: " + (!!artist.adresa ? artist.adresa : "")
                                                color: "#A8998A"
                                                font.pixelSize: 11
                                            }
                                        }

                                        ///EDIT MODE
                                        Row {
                                            spacing: 10
                                            opacity: detailRoot.editing ? 1 : 0
                                            visible: opacity > 0
                                            Behavior on opacity {
                                                NumberAnimation {
                                                    duration: 200
                                                    easing.type: Easing.InOutQuad
                                                }
                                            }

                                            Rectangle {
                                                width: 150
                                                height: 28

                                                radius: 6
                                                color: "#ffffff"
                                                border.color: "#A04A5E"
                                                border.width: 1

                                                TextField {
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 8
                                                    text: detailRoot.editCUI
                                                    placeholderText: "CUI"
                                                    placeholderTextColor: "#2A0D16"
                                                    background: null
                                                    font.pixelSize: 11
                                                    color: "#2A0D16"
                                                    verticalAlignment: TextInput.AlignVCenter
                                                    enabled: detailRoot.editing
                                                    onTextChanged: detailRoot.editCUI = text
                                                }
                                            }

                                            Rectangle {
                                                width: 230
                                                height: 28

                                                radius: 6
                                                color: "#ffffff"
                                                border.color: "#A04A5E"
                                                border.width: 1

                                                TextField {
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 8
                                                    text: detailRoot.editAdresa
                                                    placeholderText: "Adresa"
                                                    placeholderTextColor: "#B8A99A"
                                                    font.pixelSize: 11
                                                    color: "#2A0D16"
                                                    background: null
                                                    verticalAlignment: TextInput.AlignVCenter
                                                    enabled: detailRoot.editing
                                                    onTextChanged: detailRoot.editAdresa = text
                                                }
                                            }


                                        }
                                    }
                                }
                            }


                            ///Aliases
                            Rectangle {
                                width: parent.width - 50

                                height: aliasColumn.height + 32
                                radius: 10
                                color: "#ffffff"
                                border.color: "#E3D5C8"
                                border.width: 1

                                Column {
                                    id: aliasColumn

                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.margins: 16
                                    spacing: 12

                                    Text {
                                        text: "ALIAS-URI"
                                        color: "#8a6b70"
                                        font.pixelSize: 11
                                        font.letterSpacing: 0.5
                                    }

                                    Row {
                                        spacing: 8

                                        Rectangle {
                                            width: 130
                                            height: 26
                                            radius: 13

                                            color:"#F2EBE2"
                                            border.color: "#C9B8A8"
                                            border.width: 1

                                            TextField {
                                                id:newAliasField
                                                anchors.fill: parent
                                                anchors.leftMargin: 10
                                                placeholderText: "Alias nou..."
                                                font.pixelSize: 12
                                                color: "#2A0D16"
                                                placeholderTextColor: "#2A0D16"
                                                background: null
                                                verticalAlignment: TextInput.AlignVCenter

                                                onAccepted: detailRoot.addNewAlias()
                                            }
                                        }

                                        Rectangle {
                                            width: 30
                                            height: 26
                                            radius: 13
                                            color: "#4E1826"
                                            Text {
                                                anchors.centerIn: parent
                                                text: "+"
                                                color: "#ECDAD6"
                                                font.pixelSize: 16
                                            }

                                            MouseArea {
                                                anchors.fill: parent

                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: {
                                                    detailRoot.addNewAlias();
                                                }
                                            }
                                        }
                                    }

                                    Flow {
                                        width: parent.width
                                        spacing: 8
                                        Repeater {
                                            model: aliases
                                            Rectangle {
                                                width: aliasRow.width + 20
                                                height: 26
                                                radius: 13
                                                color: "#F2EBE2"
                                                border.color: "#E3D5C8"
                                                border.width: 1

                                                Row {
                                                    id: aliasRow
                                                    anchors.centerIn: parent
                                                    spacing: 6
                                                    Text {
                                                        text: modelData.alias
                                                        color: "#2A0D16"
                                                        font.pixelSize: 12
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }

                                                    Text {
                                                        text: "ⓧ"
                                                        color: "#A8998A"
                                                        font.pixelSize: 15
                                                        anchors.verticalCenter: parent.verticalCenter

                                                        MouseArea {
                                                            anchors.fill: parent
                                                            cursorShape: Qt.PointingHandCursor

                                                            onClicked: {
                                                                dashboard.colaboratorRepo.deleteAlias(modelData.id)
                                                                detailRoot.refreshAliases()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            ///Songs + Contracts panels
                            Row {
                                width: parent.width - 50
                                height: 220
                                spacing: 14

                                Rectangle {
                                    width: (parent.width - 14) / 2
                                    height: parent.height
                                    radius: 10

                                    color: "#ffffff"
                                    border.color: "#E3D5C8"
                                    border.width: 1
                                    clip: true


                                    Column {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        spacing: 10

                                        Text {
                                            text: "Piese"
                                            color: "#2A0D16"
                                            font.pixelSize: 14
                                            font.bold: true
                                        }

                                        ListView {
                                            width: parent.width
                                            height: parent.height - 30
                                            model: songs
                                            clip: true

                                            delegate: Row {
                                                width: ListView.view.width

                                                Text {
                                                    text:modelData.titlu
                                                    color: "#6E5058"
                                                    font.pixelSize: 13
                                                    topPadding: 6
                                                    bottomPadding: 6
                                                    width: parent.width - 55
                                                    elide: Text.ElideRight
                                                }

                                                Text {
                                                    text: modelData.durata ? modelData.durata : ""
                                                    color: "#A8998A"
                                                    font.pixelSize: 12
                                                    topPadding: 6
                                                    bottomPadding: 6
                                                    width: 55
                                                    horizontalAlignment: Text.AlignRight
                                                }
                                            }
                                        }
                                    }
                                }

                                ///Contracts
                                Rectangle {
                                    width: (parent.width - 14) / 2
                                    height: parent.height
                                    radius: 10

                                    color: "#ffffff"
                                    border.color: "#E3D5C8"
                                    border.width: 1
                                    clip: true


                                    Column {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        spacing: 10

                                        Text {
                                            text: "Contracte"
                                            color: "#2A0D16"
                                            font.pixelSize: 14
                                            font.bold: true
                                        }

                                        ListView {
                                            width: parent.width
                                            height: parent.height - 30
                                            model: contracts
                                            clip: true

                                            delegate: Row {
                                                width: ListView.view.width
                                                Text {
                                                    text: modelData.numar
                                                    color: "#6E5058"
                                                    font.pixelSize: 13
                                                    topPadding: 6
                                                    bottomPadding: 6
                                                    width: parent.width - 90
                                                    elide: Text.ElideRight
                                                }

                                                Text {
                                                    text: modelData.valoare ? (modelData.valoare + " " + modelData.moneda) : "Referinta Document"
                                                    color: "#A8998A"
                                                    font.pixelSize: 12
                                                    topPadding: 6
                                                    bottomPadding: 6
                                                    width: 90
                                                    horizontalAlignment: Text.AlignRight
                                                }
                                            }
                                        }
                                    }
                                }
                            }


                            ///Representative panels
                            Rectangle {
                                width: parent.width - 50
                                height: 42
                                radius: 10

                                color: "#ffffff"
                                border.color: "#E3D5C8"
                                border.width: 1
                                visible: representations.length > 0

                                Row {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.leftMargin: 14
                                    anchors.right: parent.right

                                    anchors.rightMargin: 14
                                    spacing: 12

                                    Text {
                                        text: "REPREZINTA"
                                        color: "#8A6B70"
                                        font.pixelSize: 10
                                        font.letterSpacing: 0.5
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Flow {
                                        width: parent.width - 110
                                        spacing: 6
                                        anchors.verticalCenter: parent.verticalCenter

                                        Repeater {
                                            model: representations

                                            Rectangle {
                                                width: chipRow.width + 20

                                                height: 22
                                                radius: 11

                                                color: "#F2EBE2"
                                                border.color: "#E3D5C8"
                                                border.width: 1

                                                Row {
                                                    id: chipRow

                                                    anchors.centerIn: parent
                                                    spacing: 4
                                                    Text {
                                                        text: modelData.srl_nume
                                                        color: "#2A0D16"
                                                        font.pixelSize: 11
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }


                                                    Text {
                                                        visible: !!modelData.functie
                                                        text: "· " + (modelData.functie ? modelData.functie : "")
                                                        color: "#A8998A"
                                                        font.pixelSize: 11
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width - 50
                                height: obsContent.height + 28
                                radius: 10
                                color: "#ffffff"
                                border.color: "#E3D5C8"
                                border.width: 1

                                visible: detailRoot.editing || (artist.observatii ? true : false)

                                Item {
                                    id:obsContent
                                    anchors.left: parent.left
                                    anchors.right: parent.right

                                    anchors.top: parent.top
                                    anchors.margins: 14

                                    height: Math.max(obsDisplay.height, obsEditBox.height) + 24

                                    Text {
                                        text: "OBSERVATII"
                                        color: "#8A6B70"
                                        font.pixelSize: 10
                                        font.letterSpacing: 0.5
                                    }


                                    ///VIEW MODE
                                    Text {
                                        id:obsDisplay
                                        anchors.top: parent.top
                                        anchors.topMargin: 20
                                        width: parent.width

                                        text: artist.observatii ? artist.observatii : ""
                                        color: "#6E5058"
                                        font.pixelSize: 13
                                        wrapMode: Text.WordWrap
                                        opacity: detailRoot.editing ? 0 : 1
                                        visible: opacity > 0
                                        Behavior on opacity {
                                            NumberAnimation {
                                                duration: 200
                                                easing.type: Easing.InOutQuad
                                            }
                                        }
                                    }


                                    ///EDIT MODE
                                    Rectangle {
                                        id:obsEditBox
                                        anchors.top: parent.top
                                        anchors.topMargin: 20
                                        width: parent.width
                                        height: 70
                                        radius: 7

                                        color: "#ffffff"
                                        border.color: "#A04A5E"
                                        border.width: 1
                                        opacity: detailRoot.editing ? 1 : 0
                                        visible: opacity > 0
                                        Behavior on opacity {
                                            NumberAnimation {
                                                duration: 200
                                                easing.type: Easing.InOutQuad
                                            }
                                        }

                                        TextArea {
                                            anchors.fill: parent
                                            anchors.margins: 6
                                            text: detailRoot.editObservatii
                                            font.pixelSize: 13
                                            color: "#2A0D16"
                                            wrapMode: TextArea.Wrap
                                            background: null
                                            enabled: detailRoot.editing
                                            onTextChanged: {
                                                detailRoot.editObservatii = text
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id:confirmOverlay

                        property bool showCancel: true

                        anchors.fill: parent
                        color: "#732a0d16" ///dimmed burgundy
                        visible: false
                        z:100

                        property string message: ""
                        property string confirmLabel: "Confirma"
                        property var onConfirm: (function(){})

                        function openWith(msg, label, action) {
                            message = msg
                            confirmLabel = label
                            onConfirm = action
                            showCancel = true
                            visible = true
                        }

                        function openAcknowledge(msg, label, action) {
                            message = msg
                            confirmLabel = label
                            onConfirm = action
                            showCancel = false
                            visible = true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: confirmOverlay.visible =  false
                        }

                        Rectangle {
                            anchors.centerIn: parent
                            width: 340
                            radius: 16
                            color: "#F2EBE2"
                            height: panelCol.height + 48

                            MouseArea {
                                anchors.fill: parent
                            }

                            Column {
                                id:panelCol

                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.margins: 24
                                spacing: 14


                                ///Dialog Title
                                Row {
                                    spacing: 10

                                    Rectangle {
                                        width: 34
                                        height: 34
                                        radius: 9
                                        color: "#F3DEDE"

                                        Text {
                                            anchors.centerIn: parent
                                            text: "!"
                                            color: "#9b2226"
                                            font.pixelSize: 18
                                            font.bold: true
                                        }
                                    }

                                    Text {
                                        text: confirmOverlay.showCancel ? "Confirmare" : "Atentie"
                                        color: "#2A0D16"
                                        font.pixelSize: 19
                                        font.family: "Georgia"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                ///Message
                                Text {
                                    width: parent.width
                                    text: confirmOverlay.message
                                    color: "#6E5058"
                                    font.pixelSize: 13
                                    wrapMode: Text.WordWrap
                                    lineHeight: 1.3
                                }

                                ///Buttons
                                Row {
                                    anchors.right: parent.right
                                    spacing: 10

                                    ///cancel button
                                    Rectangle {
                                        visible: confirmOverlay.showCancel
                                        width: cancelText.width + 32;
                                        height: 36
                                        radius: 9

                                        color: "transparent"
                                        border.color: "#C9B8A8"
                                        border.width: 1

                                        Text {
                                            id:cancelText
                                            anchors.centerIn: parent;
                                            text: "Anuleaza"
                                            color: "#6E5058"
                                            font.pixelSize: 13
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: confirmOverlay.visible = false
                                        }
                                    }

                                    ///Confirm
                                    Rectangle {
                                        width: confirmText.width + 32;
                                        height: 36
                                        radius: 9
                                        color: "#4E1826"

                                        Text {
                                            id: confirmText
                                            anchors.centerIn: parent;
                                            text: confirmOverlay.confirmLabel
                                            color: "#ECDAD6"
                                            font.pixelSize: 13
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                confirmOverlay.onConfirm()
                                                confirmOverlay.visible = false
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Component {
                id: srlDetailView

                Rectangle {
                    color: "#F2EBE2"

                    Text {
                        anchors.centerIn: parent
                        text: "SRL detail: " + colaboratorRoot.selectedId
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            colaboratorRoot.selectedId = -1
                        }
                    }

                }
            }

            Component {
                id: colaboratorDetailView

                Rectangle {
                    color: "#F2EBE2"

                    Text {
                        anchors.centerIn: parent
                        text: "Colaborator detail: " + colaboratorRoot.selectedId
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            colaboratorRoot.selectedId = -1
                        }
                    }
                }
            }
        }
    }
}

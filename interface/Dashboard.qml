import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Effects

Item {
    id:dashboard

    anchors.fill: parent

    property string username: ""

    property var platformRepo: null
    property var pieseRepo: null
    property var contractRepo: null
    property var artistRepo: null

    property var bridge: null

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
                        { label: "Panou", icon: "", active: true},
                        { label: "Artisti", icon: "", active: false},
                        { label: "Piese", icon: "", active: false},
                        { label: "Albume", icon: "", active: false},
                        { label: "Contracte", icon: "", active: false},
                        { label: "Distributie", icon: "", active: false}

                    ]

                    Rectangle {
                        width: sidebar.width
                        height: 44
                        color: modelData.active ? "#3d1420" : "transparent"


                        Rectangle {
                            width: 2
                            height: parent.height
                            color: "#A04A5E"
                            visible: modelData.active
                        }

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 24
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 11

                            Text {
                                text: modelData.label
                                color: modelData.active ? "#F2E4E0" : "#B98C94"
                                font.pixelSize: 15
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

            }
        }

        //Sidebar right
        Rectangle {
            width: parent.width - sidebar.width
            height: parent.height
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
                            Text {text: artistRepo ? artistRepo.getCount() : "0"; color: "#2A0D16"; font.pixelSize: 30; font.family: "Georgia"}
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
}

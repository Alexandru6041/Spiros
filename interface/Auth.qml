import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Window

Item {
    id:authScreen
    anchors.fill: parent

    signal authSuccess(string username)

    DatabaseBridge {
        id: db
    }



    Row {
        anchors.fill: parent; ///filling the whole window

        ///Left panel

        Rectangle {
            width: parent.width * 0.38
            height: parent.height
            color: "#3C0D16" /// deep burdungy - "#2a0d16"  -light burgundy "#3C0D16

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 30
                anchors.rightMargin: 30
                spacing: 16


                Text {
                    text: "Spiros Official"
                    color: "#ecdad6"
                    font.pixelSize: 42
                    font.family: "Georgia"
                }

                Rectangle {
                    width: 34
                    height: 2
                    color: "#7a2438"
                }

                Text {
                    text: "In boxele tale din 1993"
                    color: "#a9757f"
                    font.pixelSize: 17
                    width: parent.width
                    wrapMode: Text.WordWrap
                    lineHeight:  1.4
                    font.family: "Gill Sans"
                }
            }

            ///footer
            Text {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                /// anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 30
                anchors.leftMargin: 30
                text: "Repertoriu · Contracte · Distributie"
                color: "#6e4650"

                font.pixelSize: 15
                font.letterSpacing: 1.5

            }
        }


        ///Right Panel

        Rectangle {
            width: parent.width * 0.62
            height: parent.height
            color: "#f2ebe2"

            Column {
                anchors.centerIn: parent
                width: 260
                spacing: 22

                Text {
                    text: "Bine ai venit"
                    color: "#3C0D16"
                    font.pixelSize: 42
                    font.family: "Georgia"
                }


                ///Username field
                Column {
                    width: parent.width
                    spacing: 8

                    Text {
                        text: "Utilizator"
                        color: "#8a6b70"
                        font.pixelSize:  20
                        font.letterSpacing: 1
                    }

                    TextField {
                        id: usernameField
                        width: parent.width
                        placeholderText: ""
                        font.pixelSize: 18
                        color: "#3C0D16"

                        background: Rectangle {
                            color: "transparent"
                            border.color: "#c9b8a8"
                            border.width: 1
                            radius: 6
                        }
                    }
                }

                ///Password SearchField
                Column {
                    width: parent.width
                    spacing: 8

                    Text {
                        text: "Parola"
                        color: "#8a6b70"
                        font.pixelSize: 20
                        font.letterSpacing: 1
                    }

                    TextField {
                        id: passwordField
                        width: parent.width
                        placeholderText: ""
                        echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password
                        font.pixelSize: 18
                        color: "#3C0D16"
                        rightPadding: 44 ///toggle button space

                        background: Rectangle {
                            color: "transparent"
                            border.color: "#c9b8a8"
                            border.width:  1
                            radius: 6
                        }


                        AbstractButton {
                            id:showPassword
                            checkable: true
                            width: 32
                            height: 32
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter

                            contentItem: Item {
                                Image {
                                    id: eyeIcon
                                    source: showPassword.checked ? "icons/svgs/regular/eye.svg" : "icons/svgs/regular/eye-slash.svg"
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                    sourceSize.width: 15
                                    sourceSize.height: 15
                                    visible:false
                                }
                                MultiEffect {
                                    anchors.fill: eyeIcon
                                    source: eyeIcon
                                    colorization: 1.0
                                    colorizationColor: "#8a6b70"
                                    opacity: 0.5
                                }
                            }
                        }
                    }

                }



                ///Sign in
                Button {
                    id: signInButton
                    width: parent.width
                    height: 46
                    text: "Autentificare"

                    background: Rectangle {
                        color: "#4e1826"
                        radius: 9
                    }

                    contentItem: Text {
                        text: signInButton.text
                        color: "#ECDAD6"
                        font.pixelSize: 17
                        font.letterSpacing: 1.7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }


                    Timer {
                        id:clearTime
                        interval: 3000
                        repeat: false
                        onTriggered: {
                            loginMessage.text = "";
                            loginMessage.visible = false;
                            passwordField.text = "";
                            usernameField.text = "";
                        }
                    }

                    onClicked: {
                        var success = db.login(usernameField.text, passwordField.text);
                        loginMessage.visible = true;

                        if(success) {
                            loginMessage.text = "Autentificare reusita";
                            loginMessage.color = "#2d6a4f";
                            console.log("[AUTHENTICAITON]: Success. The user has been authenticated. Redirecting to dashboard...");
                            authScreen.authSuccess(usernameField.text);

                        } else {
                            loginMessage.text = "Autentificare esuata";
                            loginMessage.color = "#9b2226";
                            console.log("[AUTHENTICATION]: Error. The user could not be authenticated.");
                        }
                        clearTime.restart();

                    }

                }

                ///SignIn message

                Text {
                    id:loginMessage
                    text: ""
                    width: parent.width
                    color: "#4e1826"
                    font.pixelSize: 16
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }

            }
        }
    }
}

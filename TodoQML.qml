import QtQuick 2.0

Image {
    width: 550
    height: 600
    source: "bg.png"
    fillMode: Image.Tile

    Text {
        id: title
        text: "todos"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 36
        font.pixelSize: 70
        font.family: "Arial"
        font.bold: true
        color: "#777"
        opacity: 0.22
        style: Text.Sunken
        styleColor: "black"
    }

    Rectangle {
        id: topbar
        z: 2
        width: parent.width
        height: 15
        anchors.top: title.bottom
        anchors.topMargin: 12
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0.518, 0.431, 0.392, 0.8) }
            GradientStop { position: 1.0; color: Qt.rgba(0.396, 0.329, 0.298, 0.8) }
        }
    }

    Rectangle {
        id: newItem
        anchors.top: topbar.bottom
        width: parent.width
        height: 61
        color: "#F8F8F8"

        TextInput {
            id: newInput
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            clip: true

            font.family: "Arial"
            font.pixelSize: 24
            color: "#4D4D4D"

            onAccepted: {
                todoModel.append({ done: false, entry: text });
                text = '';
            }
        }

        Text {
            text: "What needs to be done?"
            x: 60
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Arial"
            font.pixelSize: 24
            font.italic: true
            color: "#BBB"
            visible: !newInput.text.length
        }
    }

    ListModel {
        id: todoModel
        ListElement {
            done: true
            entry: "Example TODO"
        }
    }

    Column {
        id: todoList
        width: parent.width
        anchors.top: newItem.bottom
        Repeater {
            model: todoModel
            //TodoEntry { }
        }
    }

    // Stripes
    Rectangle {
        x: 40
        width: 1
        anchors.top: topbar.top
        anchors.bottom: todoList.bottom
        color: "#F5D6D6"
    }
    Rectangle {
        x: 43
        width: 1
        anchors.top: topbar.top
        anchors.bottom: todoList.bottom
        color: "#F5D6D6"
    }

    Rectangle {
        id: footer
        width: parent.width
        anchors.top: todoList.bottom
        height: 33
        color: "#ECECEC"

        Text {
            text: todoModel.count + " item" + (todoModel.count === 1 ? "" : "s") + " left"
            x: 14
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Arial"
            font.pixelSize: 14
        }

        Row {
            id: filters
            anchors.centerIn: parent
            spacing: 9
            Text { text: "All"; font.family: "Arial"; font.pixelSize: 14; }
            Text { text: "Active"; font.family: "Arial"; font.pixelSize: 14; }
            Text { text: "Completed"; font.family: "Arial"; font.pixelSize: 14; }
        }
    }
}

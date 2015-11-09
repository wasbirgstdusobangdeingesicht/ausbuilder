import QtQuick 2.0

ListModel {

    ListElement {
        title: "Practice"
        property string url: "Practice.qml"
        property var props
    }
    ListElement {
        title: "Select pack"
        property string url: "CardSelector.qml"
        property var props
    }
    ListElement {
        title: "Listen"
        property string url: "PlayPhrase.qml"
        property var props
    }
    ListElement {
        title: "About"
        property string url: "About.qml"
        property var props
    }

    Component.onCompleted: {
        // init props fields
        for(var i = 0; i < count; ++i)
        {
            get(i).props = {}
        }
    }

    function indexByUrl(url) {
        var ret = -1
        for(var i = 0; i < count; ++i)
        {
            if(get(i).url !== url)
                continue;
            ret = i
            break
        }
        return ret
    }

}

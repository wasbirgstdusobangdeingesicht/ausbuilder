import QtQuick 2.0
import "global.js" as Utils

BasicScreen {
    id: cardSlector

    property alias currentIndex: view.currentIndex

    ListView {
        id: view
        anchors.fill: parent
        model: ListModel {
            ListElement { txt: "01.1_The_Body" }
            ListElement { txt: "01.2_Appearance" }
            ListElement { txt: "01.3_Mind_and_Reason" }
            ListElement { txt: "01.4_Character" }
            ListElement { txt: "01.5_Pleasant_and_Neut._Emot." }
            ListElement { txt: "01.6_Negative_Emotions" }
            ListElement { txt: "01.7_Health_and_Illness" }
            ListElement { txt: "01.8_Life_and_Death" }
            ListElement { txt: "02.1_Senses_and_Body_Funct." }
            ListElement { txt: "02.2_Hygiene_and_Cleanliness" }
            ListElement { txt: "02.3_Doing" }
            ListElement { txt: "02.4_Movement_and_Rest" }
            ListElement { txt: "02.5_Moving_of_Obj._and_Beings" }
            ListElement { txt: "02.6_Giving_and_Taking" }
            ListElement { txt: "02.7_Handling_Obj._and_Beings" }
            ListElement { txt: "02.8_Learning_and_Knowledge" }
            ListElement { txt: "03.10_Wish_Request_Order" }
            ListElement { txt: "03.11_Courtesy_Exclmns._Fillers" }
            ListElement { txt: "03.1_General_Lang._and_Speech" }
            ListElement { txt: "03.2_Speech" }
            ListElement { txt: "03.3_Writing_and_Reading" }
            ListElement { txt: "03.4_Information" }
            ListElement { txt: "03.5_Expressing_Opinions" }
            ListElement { txt: "03.6_Acceptance_and_Rejection" }
            ListElement { txt: "03.7_Certainty_and_Doubt" }
            ListElement { txt: "03.8_Pos._Eval._and_Neutrality" }
            ListElement { txt: "03.9_Negative_Evaluation" }
            ListElement { txt: "04.1_Identification" }
            ListElement { txt: "04.2_Family_and_Relationships" }
            ListElement { txt: "04.3_Social_Ties" }
            ListElement { txt: "04.4_Professions" }
            ListElement { txt: "04.5_Social_Position" }
            ListElement { txt: "04.6_Pos._Neut._Social_Behav." }
            ListElement { txt: "04.7_Negative_Social_Behavior" }
            ListElement { txt: "04.8_Contacts_and_Events" }
            ListElement { txt: "04.9_Fate_and_Coincidence" }
            ListElement { txt: "05.1_House_and_Apartment" }
            ListElement { txt: "05.2_Furnishings" }
            ListElement { txt: "05.3_Basic_Commodities" }
            ListElement { txt: "05.4_Clothing_and_Jewelry" }
            ListElement { txt: "05.5_Meals_Restaurant" }
            ListElement { txt: "05.6_Groceries_and_Food" }
            ListElement { txt: "05.7_Fruits_and_Vegetables" }
            ListElement { txt: "05.8_Drinking_and_Smoking" }
            ListElement { txt: "05.9_Doctor_and_Hospital" }
            ListElement { txt: "06.1_Gen._Busn._and_Admin." }
            ListElement { txt: "06.2_Stores_and_Shopping" }
            ListElement { txt: "06.3_Money_and_Property" }
            ListElement { txt: "06.4_Work" }
            ListElement { txt: "06.5_Post_Office_Telephone" }
            ListElement { txt: "06.6_Authorities_Police" }
            ListElement { txt: "06.7_Law" }
            ListElement { txt: "07.1_Theater_Film_Fine_Arts" }
            ListElement { txt: "07.2_Music" }
            ListElement { txt: "07.3_Media" }
            ListElement { txt: "07.4_Leisure_Activities" }
            ListElement { txt: "07.5_Sports" }
            ListElement { txt: "08.1_Government_and_Politics" }
            ListElement { txt: "08.2_War_and_Peace" }
            ListElement { txt: "08.3_Church_and_Religion" }
            ListElement { txt: "08.4_School_and_Education" }
            ListElement { txt: "09.1_City_Town_and_Village" }
            ListElement { txt: "09.2_Landscape" }
            ListElement { txt: "09.3_Nature-_General" }
            ListElement { txt: "09.4_Animals" }
            ListElement { txt: "09.5_Plants" }
            ListElement { txt: "09.6_Weather_and_Climate" }
            ListElement { txt: "10.1_Technology" }
            ListElement { txt: "10.2_Materials" }
            ListElement { txt: "11.1_Travel" }
            ListElement { txt: "11.2_StreetTraffic" }
            ListElement { txt: "11.3_Vehicles" }
            ListElement { txt: "11.4_Rail_Plane_Ship" }
            ListElement { txt: "12.1_Geographical_Names" }
            ListElement { txt: "12.2_Languages_etc." }
            ListElement { txt: "13.1_Divisions_of_the_Year" }
            ListElement { txt: "13.2_The_Names_of_the_Months" }
            ListElement { txt: "13.3_Weekdays" }
            ListElement { txt: "13.4_Times_of_Day" }
            ListElement { txt: "13.5_Clock_Time" }
            ListElement { txt: "13.6.1_Time-_Nouns" }
            ListElement { txt: "13.6.2_Time-_Verbs" }
            ListElement { txt: "13.6.3_Time-_Adjectives" }
            ListElement { txt: "13.6.4_Time-_Adverbs" }
            ListElement { txt: "14.1_Spacial_Concepts-_Nouns" }
            ListElement { txt: "14.2_Spacial_Concepts-_Adj." }
            ListElement { txt: "14.3_Spacial_Concepts-_Adv." }
            ListElement { txt: "15.1_Concepts_of_Quantity" }
            ListElement { txt: "15.2_Cardinal_Numbers" }
            ListElement { txt: "15.3_Measurements_and_Weights" }
            ListElement { txt: "16.1_Order_Division" }
            ListElement { txt: "16.2_Ordinal_Numbers" }
            ListElement { txt: "17.1_Ways_and_Methods" }
            ListElement { txt: "17.2_Degree_Comparison" }
            ListElement { txt: "18_Colors" }
            ListElement { txt: "19_Forms" }
            ListElement { txt: "20_Cause_and_Effect" }
            ListElement { txt: "21_Condition_and_Change" }
            ListElement { txt: "22.5_Quest._Pron._Reltv._Pron." }
            ListElement { txt: "22.6_Indefinite_Pronouns" }
            ListElement { txt: "23_Conjunctions" }
            ListElement { txt: "24_Adverbs" }
        }

        delegate: Component {
            Item {
                width: cardSlector.width
                height: Utils.scaled(25) + 10
                Rectangle {
                    radius: 5
                    color: view.currentIndex === index? "lightgray": "transparent"
                    anchors.fill: cardTitle
                }
                Text {
                    id: cardTitle
                    text: txt

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: cardSlector.width

                    font.pixelSize: Utils.scaled(25)
                    color: "white"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            initScreen("CardSelector.qml", {"currentIndex": index})
                            var file = "qrc:/qml/models/de/" + txt + ".qml"
                            var props = {cardModel: file}
                            console.log("sending props: " + props + " (" + JSON.stringify(props) + ")")
    //                        showScreen(file)
                            initAndShowScreen("Practice.qml", props)
                        }
                    }
                }
            }
        }
    }
}

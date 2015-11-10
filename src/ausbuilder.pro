TEMPLATE = app

QT +=   qml \
        quick \
        multimedia \
        svg \

CONFIG += c++14

SOURCES += main.cpp

RESOURCES += images.qrc \
	qml.qrc \
	assets/aude/01.1_The_Body/audio.qrc

!mac: {
#RESOURCES += assets/aude/01.1_The_Body/audio.qrc
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

OTHER_FILES = main.qml \
              qml/global.js \
              qml/*.qml \
              qml/dictionaries/*.qml \
              qml/delegates/*.qml \
              qml/models/*.qml \
              qml/models/de/*.qml \
              qml/controls/*.qml \
              android/AndroidManifest.xml \
              qml/Card.qml \
              qml/CardSelector.qml \
              qml/models/MenuElement.qml

#AUDIO_FILES = $$files(assets/audio/*.mp3)

mac: {
        ICON = assets/design/logo.png
 #       data.files = $$AUDIO_FILES
        ios: {
                data.path = Documents/audio

                ios_icon.files = assets/design/logo.png
                ios_icon.path = .
        }
        !ios: {
                data.path = Contents/Resources/audio
        }
        QMAKE_BUNDLE_DATA += data ios_icon
        QMAKE_INFO_PLIST = ApplePlatforms.plist
}

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    smartconnect.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ICON = assets/design/logo.png
VERSION = "1.0.0.0"
QMAKE_TARGET_COMPANY="ausbuilder"
QMAKE_TARGET_DESCRIPTION="Vocabular Ausbuilder"
QMAKE_TARGET_COPYRIGHT="(c) 2015"
QMAKE_TARGET_PRODUCT="ausbuilder"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQuickItem>
#include <QScreen>

#include <math.h>
#include <ctgmath>

#include "smartconnect.h"

int main(int argc, char * argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("ausbuilder"));
    app.setOrganizationDomain(QStringLiteral("scnsoft.com"));
    app.setOrganizationName(QStringLiteral("ausbuilder"));

    QQuickView qmlView;
    qmlView.engine()->addImportPath("qml");
    qmlView.setResizeMode(QQuickView::SizeRootObjectToView);
#if defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_MAC)
    qmlView.resize(720, 480);
#endif

    qmlView.screen()->setOrientationUpdateMask(Qt::LandscapeOrientation | Qt::InvertedLandscapeOrientation);

    QScreen * sc = app.primaryScreen();

    qreal r = sc->logicalDotsPerInch() / 96; // sc->physicalDotsPerInch() / sc->logicalDotsPerInch();
    qmlView.engine()->rootContext()->setContextProperty("scaleRatio", r);
#if defined(Q_OS_WIN) || defined(Q_OS_MAC) || defined(Q_OS_LINUX)
    qmlView.engine()->rootContext()->setContextProperty("audioRoot", "../../assets/aude/");
#else
    qmlView.engine()->rootContext()->setContextProperty("audioRoot", "qrc:///audio/");
#endif

    // TODO : when preparing for iOS the following path should be united with audioRoot
//#if defined(Q_OS_IOS)
//    qmlView.engine()->rootContext()->setContextProperty("audioPath", QString("file://" + QFileInfo(QCoreApplication::applicationFilePath()).absoluteDir().path() + "/Documents/audio/"));
//#elif defined(Q_OS_DARWIN)
//    qmlView.engine()->rootContext()->setContextProperty("audioPath", QString(QCoreApplication::applicationFilePath() + "/../../Resources/audio/"));
//#elif defined(QT_DEBUG) && defined(Q_OS_WIN)
//    qmlView.engine()->rootContext()->setContextProperty("audioPath", QString("../../../src/assets/audio/"));
//#else
//    qmlView.engine()->rootContext()->setContextProperty("audioPath", QString("qrc:/audio/"));
//#endif

    // TODO: check macro names spelling
#if defined(QT_NO_DEBUG) || defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
    qmlView.setSource(QStringLiteral("qrc:/main.qml"));
    qmlView.engine()->rootContext()->setContextProperty("debug", QVariant(false));
#else

#if defined(Q_OS_DARWIN)
    qmlView.setSource(QStringLiteral("../../../../src/main.qml"));
#else
    qmlView.setSource(QStringLiteral("../src/main.qml"));
#endif //Q_OS_DARWIN

    qmlView.engine()->rootContext()->setContextProperty("debug", QVariant(true));

    // d-tor of SmartConnect must be called after app.exec
    SmartConnect clearCacheConnection(
                static_cast<QObject *>(qmlView.rootObject()),
                SIGNAL(clearComponentCache()),
                [&qmlView]() {qmlView.engine()->clearComponentCache();});
    Q_UNUSED(clearCacheConnection);

#endif

    qmlView.show();

    QObject::connect(qmlView.engine(), SIGNAL(quit()), &qmlView, SLOT(close()), Qt::QueuedConnection);

    return app.exec();
}

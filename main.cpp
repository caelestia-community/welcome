#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QProcessEnvironment>

int main(int argc, char *argv[])
{
    // Enable XMLHttpRequest file reading
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    QGuiApplication app(argc, argv);
    app.setApplicationName("Caelestia Welcome");
    app.setOrganizationName("Caelestia");

    QQmlApplicationEngine engine;

    // Set scheme path in QML context before registering singleton
    QString stateDir = QStandardPaths::writableLocation(QStandardPaths::GenericStateLocation);
    if (stateDir.isEmpty()) {
        stateDir = QDir::homePath() + "/.local/state";
    }
    QString schemePath = stateDir + "/caelestia/scheme.json";
    engine.rootContext()->setContextProperty("schemeFilePath", schemePath);

    // Register Colours singleton
    qmlRegisterSingletonType(QUrl("qrc:/utils/Colours.qml"), "caelestia.welcome", 1, 0, "Colours");

    // Set config path in QML context
    QString configDir = QStandardPaths::writableLocation(QStandardPaths::GenericConfigLocation);
    if (configDir.isEmpty()) {
        configDir = QDir::homePath() + "/.config";
    }
    QString configPath = configDir + "/caelestia/shell.json";
    engine.rootContext()->setContextProperty("configFilePath", configPath);

    // Register Config singleton
    qmlRegisterSingletonType(QUrl("qrc:/utils/Config.qml"), "caelestia.welcome", 1, 0, "Config");

    const QUrl url(QStringLiteral("qrc:/Main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

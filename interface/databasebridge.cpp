#include <QDebug>
#include <QDir>
#include <stdio.h>

#include "databasebridge.h"
#include "config.h"
#include "database_header.h"

DatabaseBridge::DatabaseBridge(QObject *parent) : QObject(parent) {}

bool DatabaseBridge::login(const QString &username, const QString &password) {
    QByteArray bytes = password.toUtf8();
    QByteArray client_username = username.toUtf8();

    DatabaseConnection *conn;

    conn = db_connect(CONFIG_PATH, client_username.constData(), bytes.constData());

    if(conn) {
        qDebug() << "[LOGIN DEBUG]: Login Successful";
        return true;
    } else {
        qDebug() << "[LOGIN DEBUG]: Login Failed";
        return false;
    }
}

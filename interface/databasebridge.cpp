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

    conn = db_connect(CONFIG_PATH, client_username.constData(), bytes.constData());

    if(conn) {
        qDebug() << "[LOGIN DEBUG]: Login Successful";
        return true;
    } else {
        qDebug() << "[LOGIN DEBUG]: Login Failed";
        return false;
    }
}

int DatabaseBridge::getCount(const QString &table) {
    if(!conn) {
        qDebug() << "[CONNECTION]: Not connected to the database when attempting to get table count.\n";
        return 0;
    }

    QString safeTable;
    if(table == "artisti")
        safeTable = "artisti";
    else if(table == "piese")
        safeTable = "piese";
    else if(table == "contracte")
            safeTable = "contracte";
    else {
        qDebug() << "[DATABASE]: Table not allowed for count retrieval: " << table;
        return 0;
    }


    QByteArray sql = ("SELECT count(*) FROM " + safeTable).toUtf8();

    DatabaseResult *res = database_query(conn, sql.constData());
    if(!res || res -> error) {
        qDebug() << "[DATABASE] Database querry failed on count retrieval attempt.";

        if(res)
            database_result_free(res);

        return 0;
    }

    int count = 0;
    if(res -> number_rows > 0) {
        const char *val = database_get_value(res, 0, 0);
        if(val)
            count = atoi(val);
    }


    database_result_free(res);
    return count;
}

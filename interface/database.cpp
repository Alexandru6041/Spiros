#include "database.h"
#include "config.h"

#include <QDebug>

Database::Database(QObject *parent) : QObject(parent) {}

bool Database::login(const QString &username, const QString &password) {
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

QVariantList Database::runQuery(const QByteArray &sql) {
    QVariantList rows;

    if(!conn) {
        qWarning() << "[RUN QUERY]: not connected";
        return rows;
    }

    DatabaseResult *res = database_query(conn, sql.constData());

    if(!res || res -> error) {
        if(res && res -> error)
            qWarning() << "[RUN QUERY]: " << res -> error;

        if(res)
            database_result_free(res);

        return rows;
    }

    for(int i = 0; i < res -> number_rows; i++) {
        QVariantMap row;

        for(int j = 0; j < res -> number_columns; j++) {
            const char *colName = res -> columns[j].name;
            const char *val = database_get_value(res, i, j);
            row[QString::fromUtf8(colName)] = val ? QString::fromUtf8(val) : QVariant(); /// NULL DATA / undefined
        }

        rows.append(row);
    }

    database_result_free(res);
    return rows;
}


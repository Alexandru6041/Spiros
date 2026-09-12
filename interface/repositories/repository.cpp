#include "repository.h"

Repository::Repository(QObject *parent) : QObject(parent) {}

void Repository::setDatabase(Database *db) {
    if(m_db != db) {
        m_db = db;
        emit databaseChanged();
    }
}


int Repository::countFrom(const QString &queryLocation) {
    QVariantList rows = queryRows(queryLocation);

    if(rows.isEmpty())
        return 0;

    QVariantMap row = rows.first().toMap();

    return row.value("count").toInt();
}

QVariantList Repository::queryRows(const QString &queryLocation) {
    if(!m_db) {
        return QVariantList();
    }

    QByteArray sql = m_loader.load(queryLocation);

    if(sql.isEmpty())
        return QVariantList();

    return m_db -> runQuery(sql);
}

QVariantList Repository::queryRowsParams(const QString &queryLocation, const QStringList &params) {
    if(!m_db)
        return QVariantList();

    QByteArray sql = m_loader.load(queryLocation);

    if(sql.isEmpty())
        return QVariantList();

    return m_db -> runQueryParams(sql, params);
}
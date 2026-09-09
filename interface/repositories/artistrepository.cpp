#include "artistrepository.h"

ArtistRepository::ArtistRepository(QObject *parent) : QObject(parent) {}

void ArtistRepository::setDatabase(Database *db) {
    if(m_db != db) {
        m_db = db;
        emit databaseChanged();
    }
}

QVariantList ArtistRepository::getCount() {
    if(!m_db) {
        return QVariantList();
    }

    QByteArray sql = m_loader.load("count_artisti");
    if(sql.isEmpty()) {
        return QVariantList();
    }

    return m_db -> runQuery(sql);
}
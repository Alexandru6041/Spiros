#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <QObject>
#include <QVariantList>

#include "database.h"
#include "queryloader.h"

class Repository : public QObject {
    Q_OBJECT
    Q_PROPERTY(Database *database READ database WRITE setDatabase NOTIFY databaseChanged)

    public:
        explicit Repository(QObject *parent = nullptr);

        Database *database() const {
            return m_db;
        }

        void setDatabase(Database *db);

    signals:
        void databaseChanged();

    protected:
        int countFrom(const QString &queryName);

        QVariantList queryRows(const QString &queryName);

        Database *m_db = nullptr;
        QueryLoader m_loader;
};

#endif // REPOSITORY_H

#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>
#include <QVariantList>
#include <QVariant>

#include "database_header.h"

class Database : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit Database(QObject *parent = nullptr);
        ~Database();

        Q_INVOKABLE bool login(const QString &username, const QString &password);

        bool isConnected() const {
            return conn != nullptr;
        }

        QVariantList runQuery(const QByteArray &sql);
        QVariantList runQueryParams(const QByteArray &sql, const QStringList &params);

    private:
        DatabaseConnection *conn = nullptr;
};

#endif

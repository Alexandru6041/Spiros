#ifndef DATABASEBRIDGE_H
#define DATABASEBRIDGE_H

#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>

#include "database_header.h"

class DatabaseBridge : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit DatabaseBridge(QObject *parent = nullptr);

        Q_INVOKABLE bool login(const QString &username, const QString &password);

    private:
        DatabaseConnection *conn = nullptr;
};

#endif

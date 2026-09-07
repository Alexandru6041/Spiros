#ifndef QUERYLOADER_H
#define QUERYLOADER_H

#include <QByteArray>
#include <QString>
#include <QMap>

class QueryLoader {
    public:
        QByteArray load(const QString &name);

    private:
        QMap <QString, QByteArray> cache;
};

#endif // QUERYLOADER_H

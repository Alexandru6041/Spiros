#include "queryloader.h"

#include <QFile>
#include <QDebug>

QByteArray QueryLoader::load(const QString &name) {
    if(cache.contains(name)) {
        return cache.value(name);
    }

    QFile file(":/queries/" + name + ".sql");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "QueryLoader: could not load query: " << name;
        return QByteArray();
    }

    QByteArray sql = file.readAll().trimmed();
    file.close();

    cache.insert(name, sql);
    return sql;
}



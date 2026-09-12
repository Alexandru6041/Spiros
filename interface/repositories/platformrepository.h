#ifndef PLATFORMREPOSITORY_H
#define PLATFORMREPOSITORY_H

#include <QtQml/qqmlregistration.h>

#include "repository.h"

class PlatformRepository : public Repository {
    Q_OBJECT
    QML_ELEMENT

public:
    explicit PlatformRepository(QObject *parent = nullptr) : Repository(parent) {};

    Q_INVOKABLE QVariantList getTopPlatforms() {
        return queryRows("platforme/top_platforms");
    }

};

#endif // PLATFORMREPOSITORY_H

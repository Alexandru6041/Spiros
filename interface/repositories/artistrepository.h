#ifndef ARTISTREPOSITORY_H
#define ARTISTREPOSITORY_H

#include <QtQml/qqmlregistration.h>

#include "repository.h"

class ArtistRepository : public Repository {
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit ArtistRepository(QObject *parent = nullptr) : Repository(parent) {};

        Q_INVOKABLE int getCount() {
            return countFrom("artisti/count_artisti");
        }

        Q_INVOKABLE QVariantList listColaboratori(const QString &tip, const QString &search) {
            return queryRowsParams("artisti/list_colaboratori", QStringList { tip, search });
        }

};

#endif // ARTISTREPOSITORY_H

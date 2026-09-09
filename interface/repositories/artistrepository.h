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
            return countFrom("count_artisti");
        }

};

#endif // ARTISTREPOSITORY_H

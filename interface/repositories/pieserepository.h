#ifndef PIESEREPOSITORY_H
#define PIESEREPOSITORY_H

#include <QtQml/qqmlregistration.h>

#include "repository.h"

class PieseRepository : public Repository {
    Q_OBJECT
    QML_ELEMENT

public:
    explicit PieseRepository(QObject *parent = nullptr) : Repository(parent) {};

    Q_INVOKABLE int getCount() {
        return countFrom("count_piese");
    }

};

#endif // PIESEREPOSITORY_H

#ifndef CONTRACTREPOSITORY_H
#define CONTRACTREPOSITORY_H


#include <QtQml/qqmlregistration.h>

#include "repository.h"

class ContractRepository : public Repository {
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit ContractRepository(QObject *parent = nullptr) : Repository(parent) {};

        Q_INVOKABLE int getCount() {
            return countFrom("contracte/count_contracte");
        }
};

#endif // CONTRACTREPOSITORY_H

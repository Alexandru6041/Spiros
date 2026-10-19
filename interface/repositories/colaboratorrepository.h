#ifndef COLABORATORREPOSITORY_H
#define COLABORATORREPOSITORY_H

#include <QtQml/qqmlregistration.h>

#include "repository.h"

class ColaboratorRepository : public Repository {
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit ColaboratorRepository(QObject *parent = nullptr) : Repository(parent) {};

        Q_INVOKABLE int getCount() {
            return countFrom("artisti/count_artisti");
        }

        Q_INVOKABLE QVariantList listColaboratori(const QString &tip, const QString &search, const QString &activ) {
            return queryRowsParams("artisti/list_colaboratori", QStringList { tip, search, activ });
        }

        Q_INVOKABLE QVariantList getArtistInfo(int id) {
            return queryRowsParams("artisti/artist_info", QStringList {QString::number(id)});
        }

        Q_INVOKABLE QVariantList getArtistAliases(int id) {
            return queryRowsParams("artisti/artist_aliases", QStringList {QString::number(id)});
        }

        Q_INVOKABLE QVariantList getArtistSongs(int id) {
            return queryRowsParams("artisti/artist_songs", QStringList { QString::number(id) });
        }

        Q_INVOKABLE QVariantList getArtistContracts(int id) {
            return queryRowsParams("artisti/artist_contracts", QStringList { QString::number(id) });
        }

        Q_INVOKABLE bool addAlias(int artistId, const QString &alias) {
            return executeParams("artisti/alias_add", QStringList { QString::number(artistId), alias });
        }

        Q_INVOKABLE bool deleteAlias(int artistId) {
            return executeParams("artisti/alias_delete", QStringList {QString::number(artistId)});
        }

        Q_INVOKABLE bool setInactive(int id) {
            return executeParams("artisti/artist_set_inactive", QStringList { QString::number(id) });
        }

        Q_INVOKABLE bool setActive(int id) {
            return executeParams("artisti/artist_set_active", QStringList { QString::number(id) });
        }
};

#endif

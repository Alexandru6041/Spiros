SELECT DISTINCT a.id,
                a.nume_real,
                (SELECT count(*) FROM piese_artisti pa WHERE pa.artist_id = a.id) AS nr_piese,
                (SELECT count(*) FROM contracte_artisti ca WHERE ca.artist_id = a.id) AS nr_contracte

FROM Artisti a
LEFT JOIN aliasuri al ON al.artist_id = a.id
WHERE a.activ = true AND (a.nume_real ILIKE '%' || $1 || '%' OR al.alias ILIKE '%' || $1 || '%')
ORDER BY a.nume_real
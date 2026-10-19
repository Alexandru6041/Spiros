SELECT a.id, a.alias
FROM aliasuri a
WHERE a.parti_id = $1
ORDER BY a.alias
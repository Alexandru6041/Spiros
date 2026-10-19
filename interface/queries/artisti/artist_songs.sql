SELECT DISTINCT pi.id, pi.titlu, pi.durata
FROM piese pi
JOIN piese_persoane pp ON pp.piesa_id = pi.id
WHERE pp.parti_id = $1
ORDER BY pi.titlu

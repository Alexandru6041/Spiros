SELECT p.nume,
    COUNT(DISTINCT d.piesa_id) AS distribuite,
    (SELECT COUNT(*) FROM piese) AS total

FROM Platforme p
LEFT JOIN distribuire d ON d.platforma_id = p.id
GROUP BY p.id, p.nume
ORDER BY distribuite DESC
LIMIT 3
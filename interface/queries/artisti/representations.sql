SELECT r.id, p.nume AS srl_nume, r.functie
FROM reprezentanti r
JOIN parti p ON p.id = r.firma_id
WHERE r.reprezentant_id = $1
ORDER BY p.nume

SELECT p.id, p.nume, p.cui, p.adresa, p.observatii, p.activ,
    CASE WHEN p.tip = 'srl' THEN 'SRL'
    WHEN EXISTS (SELECT 1 FROM piese_persoane pp WHERE pp.parti_id = p.id) THEN 'Artist'
    ELSE 'Colaborator' END AS tip_afisat
FROM parti p
WHERE p.id = $1
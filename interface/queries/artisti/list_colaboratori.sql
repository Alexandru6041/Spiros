SELECT p.id, p.tip, p.nume,
    CASE 
        WHEN p.tip = 'srl' THEN 'SRL'
        WHEN EXISTS (SELECT 1 FROM piese_persoane pp WHERE pp.parti_id = p.id) THEN 'Artist'
        ELSE 'Colaborator'
    END AS tip_afisat,

    (SELECT COUNT(*) FROM contracte_persoane cp WHERE cp.parti_id = p.id) AS nr_contracte,
    (SELECT COUNT(*) FROM piese_persoane pp WHERE pp.parti_id = p.id) AS nr_piese

FROM parti p
LEFT JOIN aliasuri al ON al.parti_id = p.id
WHERE p.activ = true 
    AND (
        $1 = '' OR
        CASE 
            WHEN $1 = 'srl' THEN p.tip = 'srl'
            WHEN $1 = 'artist' THEN p.tip = 'persoana' AND EXISTS(SELECT 1 FROM piese_persoane pp WHERE pp.parti_id = p.id)
            WHEN $1 = 'colaborator' THEN p.tip = 'persoana' AND NOT EXISTS(SELECT 1 FROM piese_persoane pp WHERE pp.parti_id = p.id)
            ELSE true
        END
    )
    
    AND(COALESCE(p.nume, '') ILIKE '%' || $2 || '%' OR al.alias ILIKE '%' || $2 || '%')

GROUP BY p.id, p.tip, p.nume
ORDER BY p.nume
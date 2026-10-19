SELECT DISTINCT c.id, c.numar, c.valoare, c.moneda, c.data_expirare
FROM contracte c
LEFT JOIN contracte_persoane cp ON cp.contract_id = c.id
WHERE c.semnatar_id = $1 OR cp.parti_id = $1
ORDER BY c.data_semnare DESC NULLS LAST
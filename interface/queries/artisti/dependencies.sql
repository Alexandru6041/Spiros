SELECT
	(SELECT COUNT(*) FROM piese_persoane WHERE parti_id = $1) AS nr_piese,
	(SELECT COUNT(*) FROM contracte_persoane WHERE parti_id = $1) AS nr_contracte,
	(SELECT COUNT(*) FROM contracte WHERE semnatar_id = $1) AS nr_semnate,
	(SELECT COUNT(*) FROM reprezentanti WHERE reprezentant_id = $1) as nr_reprezentari

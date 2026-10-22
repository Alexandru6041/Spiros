DELETE FROM piese
WHERE id IN (
	SELECT pp.piesa_id FROM piese_persoane pp
	WHERE pp.parti_id = $1
	GROUP BY pp.piesa_id
	HAVING COUNT(*) = 1
)

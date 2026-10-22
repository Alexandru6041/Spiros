UPDATE parti SET
	nume = $2,
	cui = NULLIF($3, ''),
	adresa = NULLIF($4, ''),
	observatii = NULLIF($5, '')
WHERE id = $1

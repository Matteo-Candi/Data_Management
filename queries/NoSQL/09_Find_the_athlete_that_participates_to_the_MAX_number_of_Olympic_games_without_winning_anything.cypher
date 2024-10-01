//9. Find the athlete that participates to the MAX number of Olympic games without winning anything 

MATCH(a:Athlete)
WITH toInteger(a.G) + toInteger(a.S) + toInteger(a.B) AS medals_number, a
WHERE medals_number = 0
RETURN a.name AS athlete, a.partecipations AS participations
ORDER BY participations DESC
LIMIT 1;
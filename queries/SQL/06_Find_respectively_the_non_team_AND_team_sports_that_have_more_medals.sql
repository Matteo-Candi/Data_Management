-- 6. Find respectively the non-team AND team sports that have more medals

SELECT discipline, COUNT(*) AS Number_of_medals
FROM medals
WHERE discipline IN (SELECT discipline
					 FROM medals
					 WHERE partecipant_type = 'Athlete'
					 GROUP BY discipline
					 ORDER BY COUNT(*) DESC LIMIT 1)
	  OR discipline IN (SELECT discipline
						FROM medals
						WHERE partecipant_type = 'GameTeam'
						GROUP BY discipline
						ORDER BY COUNT(*) DESC LIMIT 1)
GROUP BY discipline;
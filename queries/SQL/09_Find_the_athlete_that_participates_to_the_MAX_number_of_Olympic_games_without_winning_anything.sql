-- 9. Find the athlete that participates to the MAX number of Olympic games without winning anything (more than 30 sec)

SELECT a.name, a.games_partecipations
FROM athletes AS a
WHERE (a.name,a.url) NOT IN
			(SELECT *
					FROM winner)
ORDER BY games_partecipations DESC
LIMIT 1;
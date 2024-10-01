-- 4. Find the Italian athletes with the most medals (~30 sec)

SELECT DISTINCT name, gold, silver, bronze, COALESCE(gold, 0)+COALESCE(silver,0)+COALESCE(bronze,0) AS total, r.discipline
FROM athletes AS a, (SELECT DISTINCT athletes, discipline
					 FROM results) AS r
WHERE a.name IN (SELECT athlete
			 FROM medals
			 WHERE country_code = 'ITA') AND r.athletes LIKE CONCAT('%', a.name,'%')
ORDER BY total DESC
LIMIT 10;
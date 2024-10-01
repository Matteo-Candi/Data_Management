-- 7. Find the athletes who participated IN both summer AND winter games 

SELECT DISTINCT r.athletes AS athlete_and_url, winter.discipline AS winter_discipline, summer.discipline AS summer_discipline
FROM results AS r, (SELECT  r1.athletes, r1.discipline
	   FROM results AS r1 JOIN hosts AS h1 ON r1.game_slug = h1.game_slug
	   WHERE h1.season = 'Winter'AND 
			 r1.athletes IS NOT NULL AND
			 r1.athletes NOT LIKE '%#NOME?%') AS winter,
	(SELECT  r2.athletes, r2.discipline
	   FROM results AS r2 JOIN hosts AS h2 ON r2.game_slug = h2.game_slug
	   WHERE h2.season = 'Summer') AS summer
WHERE r.athletes = winter.athletes AND r.athletes = summer.athletes;
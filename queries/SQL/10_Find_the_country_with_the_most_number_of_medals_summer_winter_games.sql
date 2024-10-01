-- 10. Find the country with the most number of medals (summer + winter games)

SELECT s.country, summer_medals, winter_medals, COALESCE(summer_medals, 0)+COALESCE(winter_medals,0) AS total_medals
FROM
	(SELECT summer.country_name AS country, COUNT(summer.medal_type) AS summer_medals
	FROM medals AS summer
	WHERE summer.game_slug IN (SELECT game_slug
								FROM hosts
								WHERE season = 'Summer')
	GROUP BY summer.country_name) AS s
JOIN
	(SELECT winter.country_name AS country, COUNT(winter.medal_type) AS winter_medals
	FROM medals AS winter
	WHERE winter.game_slug IN (SELECT game_slug
							   FROM hosts
							   WHERE season = 'Winter')
	GROUP BY winter.country_name) AS w
ON s.country = w.country
ORDER BY total_medals DESC;

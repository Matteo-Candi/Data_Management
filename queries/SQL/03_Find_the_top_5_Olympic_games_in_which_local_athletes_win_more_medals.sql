-- 3. Find top 5 Olympic games IN which local athletes win more medals

SELECT	h.game_name, COUNT(*) AS number_of_medals, h.country
FROM hosts AS h JOIN (SELECT game_slug, country_name
					  FROM medals) AS m ON h.game_slug = m.game_slug
WHERE h.country = m.country_name
GROUP BY h.game_name, h.country
ORDER BY number_of_medals DESC
LIMIT 5;
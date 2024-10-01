-- 2. Find the top 10 athletes that win more medals IN a single Olympic game

SELECT athlete, COUNT(*) AS number_medals
FROM medals
WHERE athlete IS NOT NULL
GROUP BY athlete, game_slug
ORDER BY number_medals DESC, athlete
LIMIT 10;
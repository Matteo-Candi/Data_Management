-- 1. Find how many medals Italy won IN each discipline 

SELECT discipline, COUNT(medal_type) AS number_medals
FROM medals 
WHERE country_code = 'ITA'
GROUP BY discipline
ORDER BY number_medals DESC;
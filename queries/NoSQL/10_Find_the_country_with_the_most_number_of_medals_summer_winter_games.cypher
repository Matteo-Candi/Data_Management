// 10. Find the country with the most number of medals (summer + winter games)

MATCH (c:Country) <- [:NATIONALITY] - (a:Athlete) - [m:WIN_MEDAL_IN] -> (h:Host)
WITH COUNT(CASE WHEN h.season= 'Summer' THEN 1 END) AS summer,
     COUNT(CASE WHEN h.season = 'Winter' THEN 1 END) AS winter,
     c.name as country
RETURN country, summer, winter, summer+winter AS tot
ORDER BY tot DESC;
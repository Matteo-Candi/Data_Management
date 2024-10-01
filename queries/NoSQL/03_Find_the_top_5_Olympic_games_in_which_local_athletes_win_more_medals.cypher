// 3. Find the top 5 Olympic games in which local athletes win more medals

MATCH(c1:Country)<-[:NATIONALITY]-(a:Athlete)-[tot:WIN_MEDAL_IN]->(h:Host)-[:TAKE_PLACE_IN]->(c2:Country)
WHERE c1 = c2
RETURN COUNT(*) AS local_medals, h.name AS host, c1.name AS country
ORDER BY local_medals DESC LIMIT 5;
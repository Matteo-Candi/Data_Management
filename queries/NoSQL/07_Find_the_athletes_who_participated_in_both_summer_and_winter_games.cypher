// 7. Find the athletes who participated in both summer and winter games

MATCH(h1:Host)<-[p1:PARTECIPATE]-(a:Athlete)-[p2:PARTECIPATE]->(h2:Host)
WHERE h1.season = 'Winter' AND h2.season = 'Summer'
RETURN DISTINCT a.name AS athlete, p1.discipline AS winter_discipline, p2.discipline AS summer_discipline
ORDER BY athlete;
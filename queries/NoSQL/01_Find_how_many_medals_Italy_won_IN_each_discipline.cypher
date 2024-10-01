//1. Find how many medals Italy won IN each discipline 

MATCH(c:Country)-[:NATIONALITY]-(a:Athlete)-[tot:WIN_MEDAL_IN]-(h:Host)
WHERE c.name='Italy'
RETURN COUNT(tot) AS italian_medals, tot.discipline AS discipline
ORDER BY italian_medals DESC;
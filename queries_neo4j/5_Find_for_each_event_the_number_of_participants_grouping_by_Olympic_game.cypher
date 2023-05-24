// 5. Find for each event the number of participants, grouping by Olympic game

MATCH(:Athlete)-[p:PARTECIPATE]->(h:Host)
WHERE h.year >= '1986'
RETURN COUNT(p) AS participants, p.discipline AS discipline, p.event AS event, h.name AS host
ORDER BY participants DESC;
// 4. Find the Italian athletes with the most medals

MATCH (h:Host) <-[med:WIN_MEDAL_IN] - (a:Athlete)-[:NATIONALITY] -> (c:Country{name:'Italy'})
RETURN a.name as athlete, a.url as url, count(med) as num_medals
ORDER BY num_medals DESC;
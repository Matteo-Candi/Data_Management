//2. Find the top 10 athletes that win more medals IN a single Olympic game

MATCH(a:Athlete)-[med:WIN_MEDAL_IN]-(h:Host) 
RETURN a.name as athlete, a.url as url, count(med) as num_medals, h.name as game 
ORDER BY num_medals DESC LIMIT 10;
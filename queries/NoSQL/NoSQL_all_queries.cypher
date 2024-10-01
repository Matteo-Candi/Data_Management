//1. Find how many medals Italy won IN each discipline 
MATCH(c:Country)-[:NATIONALITY]-(a:Athlete)-[tot:WIN_MEDAL_IN]-(h:Host)
WHERE c.name='Italy'
RETURN COUNT(tot) AS italian_medals, tot.discipline AS discipline
ORDER BY italian_medals DESC;


//2. Find the top 10 athletes that win more medals IN a single Olympic game
MATCH(a:Athlete)-[med:WIN_MEDAL_IN]-(h:Host) 
RETURN a.name as athlete, a.url as url, count(med) as num_medals, h.name as game 
ORDER BY num_medals DESC LIMIT 10;


// 3. Find the top 5 Olympic games in which local athletes win more medals
MATCH(c1:Country)<-[:NATIONALITY]-(a:Athlete)-[tot:WIN_MEDAL_IN]->(h:Host)-[:TAKE_PLACE_IN]->(c2:Country)
WHERE c1 = c2
RETURN COUNT(*) AS local_medals, h.name AS host, c1.name AS country
ORDER BY local_medals DESC LIMIT 5;


// 4. Find the Italian athletes with the most medals
MATCH (h:Host) <-[med:WIN_MEDAL_IN] - (a:Athlete)-[:NATIONALITY] -> (c:Country{name:'Italy'})
RETURN a.name as athlete, a.url as url, count(med) as num_medals
ORDER BY num_medals DESC;


// 5. Find for each event the number of participants, grouping by Olympic game
MATCH(:Athlete)-[p:PARTECIPATE]->(h:Host)
WHERE h.year >= '1986'
RETURN COUNT(p) AS participants, p.discipline AS discipline, p.event AS event, h.name AS host
ORDER BY participants DESC;


// 6. Find respectively the non-team AND team sports that have more medals 
MATCH (h:Host) - [med:WIN_MEDAL_IN {partecipant_type:'GameTeam'}] - (a:Athlete) - [team:IN_TEAM_WITH] - (a1:Athlete)
RETURN count(*) as medals, med.discipline as discipline, med.partecipant_type as partecipant_type
ORDER BY medals DESC LIMIT 1
UNION
MATCH (h1:Host) - [med1:WIN_MEDAL_IN {partecipant_type:'Athlete'}] - (a2:Athlete) 
RETURN count(*) as medals,  med1.discipline as discipline, med1.partecipant_type as partecipant_type
ORDER BY medals DESC LIMIT 1;


// 7. Find the athletes who participated in both summer and winter games
MATCH(h1:Host)<-[p1:PARTECIPATE]-(a:Athlete)-[p2:PARTECIPATE]->(h2:Host)
WHERE h1.season = 'Winter' AND h2.season = 'Summer'
RETURN DISTINCT a.name AS athlete, p1.discipline AS winter_discipline, p2.discipline AS summer_discipline
ORDER BY athlete;


// 8.  Out of all the participants how many got medals AND how many didn't 
MATCH (a:Athlete)
WITH COUNT(CASE WHEN NOT EXISTS ((a)-[:WIN_MEDAL_IN]-()) THEN 1 END) AS losers,
     COUNT(CASE WHEN EXISTS ((a)-[:WIN_MEDAL_IN]-())  THEN 1 END) AS winners
RETURN losers, winners, losers+winners as tot;


//9. Find the athlete that participates to the MAX number of Olympic games without winning anything 
MATCH(a:Athlete)
WITH toInteger(a.G) + toInteger(a.S) + toInteger(a.B) AS medals_number, a
WHERE medals_number = 0
RETURN a.name AS athlete, a.partecipations AS participations
ORDER BY participations DESC
LIMIT 1;


// 10. Find the country with the most number of medals (summer + winter games)
MATCH (c:Country) <- [:NATIONALITY] - (a:Athlete) - [m:WIN_MEDAL_IN] -> (h:Host)
WITH COUNT(CASE WHEN h.season= 'Summer' THEN 1 END) AS summer,
     COUNT(CASE WHEN h.season = 'Winter' THEN 1 END) AS winter,
     c.name as country
RETURN country, summer, winter, summer+winter AS tot
ORDER BY tot DESC;

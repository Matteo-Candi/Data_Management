/* QUERIES */

-- 1. Find how many medals Italy won IN each discipline 

SELECT discipline, COUNT(medal_type) AS number_medals
FROM medals 
WHERE country_code = 'ITA'
GROUP BY discipline
ORDER BY number_medals DESC;



-- 2. Find the top 10 athletes that win more medals IN a single Olympic game

SELECT athlete, COUNT(*) AS number_medals
FROM medals
WHERE athlete IS NOT NULL
GROUP BY athlete, game_slug
ORDER BY number_medals DESC, athlete
LIMIT 10;


-- 3. Find top 5 Olympic games IN which local athletes win more medals

SELECT	h.game_name, COUNT(*) AS number_of_medals, h.country
FROM hosts AS h JOIN (SELECT game_slug, country_name
					  FROM medals) AS m ON h.game_slug = m.game_slug
WHERE h.country = m.country_name
GROUP BY h.game_name, h.country
ORDER BY number_of_medals DESC
LIMIT 5;


-- 4. Find the Italian athletes with the most medals (~30 sec)

SELECT DISTINCT name, gold, silver, bronze, COALESCE(gold, 0)+COALESCE(silver,0)+COALESCE(bronze,0) AS total, r.discipline
FROM athletes AS a, (SELECT DISTINCT athletes, discipline
					 FROM results) AS r
WHERE a.name IN (SELECT athlete
			 FROM medals
			 WHERE country_code = 'ITA') AND r.athletes LIKE CONCAT('%', a.name,'%')
ORDER BY total DESC
LIMIT 10;


-- 5. Find for each event the number of participants, grouping by Olympic game

SELECT r.discipline,r.event_title, h.game_name, COUNT(*) AS number_partecipants
FROM results r JOIN (SELECT game_name, game_slug
				   FROM hosts
				   WHERE year>= 1986) AS h ON r.game_slug = h.game_slug
GROUP BY r.discipline, r.event_title, h.game_name
ORDER BY number_partecipants DESC;


-- 6. Find respectively the non-team AND team sports that have more medals

SELECT discipline, COUNT(*) AS Number_of_medals
FROM medals
WHERE discipline IN (SELECT discipline
					 FROM medals
					 WHERE partecipant_type = 'Athlete'
					 GROUP BY discipline
					 ORDER BY COUNT(*) DESC LIMIT 1)
	  OR discipline IN (SELECT discipline
						FROM medals
						WHERE partecipant_type = 'GameTeam'
						GROUP BY discipline
						ORDER BY COUNT(*) DESC LIMIT 1)
GROUP BY discipline;


-- 7. Find the athletes who participated IN both summer AND winter games 

SELECT DISTINCT r.athletes AS athlete_and_url, winter.discipline AS winter_discipline, summer.discipline AS summer_discipline
FROM results AS r, (SELECT  r1.athletes, r1.discipline
	   FROM results AS r1 JOIN hosts AS h1 ON r1.game_slug = h1.game_slug
	   WHERE h1.season = 'Winter'AND 
			 r1.athletes IS NOT NULL AND
			 r1.athletes NOT LIKE '%#NOME?%') AS winter,
	(SELECT  r2.athletes, r2.discipline
	   FROM results AS r2 JOIN hosts AS h2 ON r2.game_slug = h2.game_slug
	   WHERE h2.season = 'Summer') AS summer
WHERE r.athletes = winter.athletes AND r.athletes = summer.athletes;



-- 8. Out of all the participants how many got medals AND how many didn't (more than 30 sec)

SELECT athletes_w.numb AS athletes_with_medals,
	athletes_l.numb AS athletes_without_medals,
	athletes_l.numb + athletes_w.numb AS total_number
FROM
	(SELECT COUNT(*) AS numb
		FROM athletes
		WHERE COALESCE(gold,0) + COALESCE(silver,0) + COALESCE(bronze,0) != 0) AS athletes_w,
	(SELECT COUNT(*) AS numb
		FROM athletes
		WHERE (name, url) NOT IN
				(SELECT name, url
				 FROM athletes
				 WHERE COALESCE(gold,0) + COALESCE(silver,0) + COALESCE(bronze,0) != 0)) AS athletes_l;


-- with view 

CREATE VIEW winner AS 
SELECT name, url
FROM athletes
WHERE COALESCE(gold,0) + COALESCE(silver,0) + COALESCE(bronze,0) != 0;


SELECT athletes_w.numb AS athletes_with_medals,
	athletes_l.numb AS athletes_without_medals,
	athletes_l.numb + athletes_w.numb AS total_number
FROM
	(SELECT COUNT(*) AS numb
		FROM winner) AS athletes_w,
	(SELECT COUNT(*) AS numb
		FROM athletes
		WHERE (name, url) NOT IN
				(SELECT *
					FROM winner)) AS athletes_l;			
	
	
-- 9. Find the athlete that participates to the MAX number of Olympic games without winning anything (more than 30 sec)

SELECT a.name, a.games_partecipations
FROM athletes AS a
WHERE (a.name,a.url) NOT IN
			(SELECT *
					FROM winner)
ORDER BY games_partecipations DESC
LIMIT 1;


-- 10. Find the country with the most number of medals (summer + winter games)

SELECT s.country, summer_medals, winter_medals, COALESCE(summer_medals, 0)+COALESCE(winter_medals,0) AS total_medals
FROM
	(SELECT summer.country_name AS country, COUNT(summer.medal_type) AS summer_medals
	FROM medals AS summer
	WHERE summer.game_slug IN (SELECT game_slug
								FROM hosts
								WHERE season = 'Summer')
	GROUP BY summer.country_name) AS s
JOIN
	(SELECT winter.country_name AS country, COUNT(winter.medal_type) AS winter_medals
	FROM medals AS winter
	WHERE winter.game_slug IN (SELECT game_slug
							   FROM hosts
							   WHERE season = 'Winter')
	GROUP BY winter.country_name) AS w
ON s.country = w.country
ORDER BY total_medals DESC;

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
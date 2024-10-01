-- 5. Find for each event the number of participants, grouping by Olympic game

SELECT r.discipline,r.event_title, h.game_name, COUNT(*) AS number_partecipants
FROM results r JOIN (SELECT game_name, game_slug
				   FROM hosts
				   WHERE year>= 1986) AS h ON r.game_slug = h.game_slug
GROUP BY r.discipline, r.event_title, h.game_name
ORDER BY number_partecipants DESC;
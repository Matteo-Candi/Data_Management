// 8.  Out of all the participants how many got medals AND how many didn't 

MATCH (a:Athlete)
WITH COUNT(CASE WHEN NOT EXISTS ((a)-[:WIN_MEDAL_IN]-()) THEN 1 END) AS losers,
     COUNT(CASE WHEN EXISTS ((a)-[:WIN_MEDAL_IN]-())  THEN 1 END) AS winners
RETURN losers, winners, losers+winners as tot;
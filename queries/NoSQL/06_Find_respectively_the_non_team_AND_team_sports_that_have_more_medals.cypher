// 6. Find respectively the non-team AND team sports that have more medals 

MATCH (h:Host) - [med:WIN_MEDAL_IN {partecipant_type:'GameTeam'}] - (a:Athlete) - [team:IN_TEAM_WITH] - (a1:Athlete)
RETURN count(*) as medals, med.discipline as discipline, med.partecipant_type as partecipant_type
ORDER BY medals DESC LIMIT 1
UNION
MATCH (h1:Host) - [med1:WIN_MEDAL_IN {partecipant_type:'Athlete'}] - (a2:Athlete) 
RETURN count(*) as medals,  med1.discipline as discipline, med1.partecipant_type as partecipant_type
ORDER BY medals DESC LIMIT 1;
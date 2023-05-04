// 1_Countries
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/Countries.csv' AS row1
CREATE (:Country {name:row1.name, code:row1.code});


// 2_Hosts
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/Hosts.csv' AS row2
CREATE (:Host {slug:row2.slug, end_date:datetime(row2.end_date), start_date:datetime(row2.start_date), location:row2.location, name:row2.name, season:row2.season, year:row2.year});


// 3_Athletes
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/Athletes.csv' AS row3
CREATE (:Athlete {url:row3.url, name:row3.name, partecipations:row3.partecipations, first_game:row3.first_game, birth:row3.birth, G:row3.G, S:row3.S, B:row3.B});

// Remove missing values.
MATCH (a:Athlete) WHERE a.first_game='NA' REMOVE a.first_game;
MATCH (a:Athlete) WHERE a.birth='NA' REMOVE a.birth;

// Decide if remove 0s or not.
//MATCH (a:Athlete) WHERE a.G=0 REMOVE a.G;
//MATCH (a:Athlete) WHERE a.S=0 REMOVE a.S;
//MATCH (a:Athlete) WHERE a.B=0 REMOVE a.B;


// 4_TAKE_PLACE_IN
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/TAKE_PLACE_IN.csv' AS row4
MATCH (h:Host {slug:row4.slug}), (c:Country {name:row4.location})
CREATE (h)-[:TAKE_PLACE_IN]->(c);


// 5_NATIONALITY
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/NATIONALITY.csv' AS row5
MATCH (a:Athlete {name:row5.athlete}), (c:Country {name:row5.country})
CREATE (a)-[:NATIONALITY]->(c);

// 6_WIN_MEDAL_IN
LOAD CSV WITH HEADERS FROM 'file:///C:/Users/mcm23/OneDrive/Desktop/GitHub/DataManagement_HWs/csv/6_WIN_MEDAL_IN.csv' AS row6
MATCH (a:Athlete {name:row6.athlete}), (h:Host {slug:row6.slug})
CREATE (a)-[:WIN_MEDAL_IN {discipline: row6.discipline, event:row6.event,event_gender:row6.event_gender, medal:row6.medal,partecipant_type:row6.partecipant_type}]->(h);
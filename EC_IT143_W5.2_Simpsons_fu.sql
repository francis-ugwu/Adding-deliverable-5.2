/*****************************************************************************************************************
NAME:    Simpsons Dataset
PURPOSE: To determine which episodes have the highest fan engagement on social media

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Simpsons Dataset


RUNTIME: 
Xm Xs

NOTES: 
To answer "Which episodes have the highest fan engagement on social media?" using the Simpsons dataset, 
we need to assume the dataset contains data related to:

Episodes: Details like episode titles and air dates.
Social media engagement metrics: Such as likes, shares, comments, or any form of engagement 
on platforms like Twitter, Facebook, or Instagram.
Assuming the relevant tables might be:

Episode: Contains episode info (EpisodeId, Title, AirDate).
SocialMedia: Contains social media engagement data for episodes (EpisodeId, Likes, Shares, Comments).

To determine the episodes with the highest fan engagement, we would:

Sum all engagement metrics (likes, shares, comments, etc.) for each episode.
Sort the episodes by total engagement in descending order.
 
******************************************************************************************************************/

-- Q1: Which episodes have the highest fan engagement on social media? 
-- A1: This query will return the top 10 episodes with the highest social media engagement, 
--     showing which episodes fans interacted with the most on social platforms.

SELECT 
    e.Title AS EpisodeTitle,
    SUM(s.Likes + s.Shares + s.Comments) AS TotalEngagement
FROM 
    Episode e
JOIN 
    SocialMedia s ON e.EpisodeId = s.EpisodeId
GROUP BY 
    e.Title
ORDER BY 
    TotalEngagement DESC
LIMIT 10;



/*****************************************************************************************************************
NAME:    Simpsons Dataset
PURPOSE: To determine the average rating per season

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Simpsons Dataset


RUNTIME: 
Xm Xs

NOTES: 
To answer "What is the average rating per season?" using the Simpsons dataset, we need to assume that the dataset contains:

Episodes: Details like episode titles, seasons, and their ratings.
Ratings: Data related to viewer ratings for each episode.
Assuming the relevant tables are:

Episode: Contains episode info (EpisodeId, Title, Season, Rating).
We will need to:

Group episodes by season.
Calculate the average rating for each season.
 
******************************************************************************************************************/

-- Q2: What is the average rating per season?
-- A2: This query will return the average rating for each season of The Simpsons, providing insight into how viewer ratings vary across seasons.


SELECT 
    e.Season,
    AVG(e.Rating) AS AverageRating
FROM 
    Episode e
GROUP BY 
    e.Season
ORDER BY 
    e.Season ASC;




/*****************************************************************************************************************
NAME:    Simpsons Dataset
PURPOSE: To determine which characters appear most frequently in episodes

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Simpsons Dataset


RUNTIME: 
Xm Xs

NOTES: 
To answer "Which characters appear most frequently in episodes?" using the Simpsons dataset, 
we need to assume that there is a table tracking the characters and their appearances in episodes.

Assuming the relevant tables are:

Episode: Contains episode info (EpisodeId, Title).
Character: Contains character info (CharacterId, Name).
EpisodeCharacter: A junction table that tracks which characters appear in which episodes (EpisodeId, CharacterId).
We will need to:

Join the Character and EpisodeCharacter tables.
Count the number of appearances for each character.
Sort the characters by their number of appearances in descending order.
 
******************************************************************************************************************/

-- Q3: Which characters appear most frequently in episodes?
-- A3: This query will return the top 10 characters that appear most frequently in The Simpsons episodes, 
--     giving insight into which characters are the most prominent in the show. 
--     and customer behavior can help infer which marketing strategies might be leading to the highest album sales.


SELECT 
    c.Name AS CharacterName,
    COUNT(ec.EpisodeId) AS AppearanceCount
FROM 
    Character c
JOIN 
    EpisodeCharacter ec ON c.CharacterId = ec.CharacterId
GROUP BY 
    c.Name
ORDER BY 
    AppearanceCount DESC
LIMIT 10;




/*****************************************************************************************************************
NAME:    MyFC Dataset
PURPOSE: To determine what effect does fan engagement have on player performance

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Percy Jara    1. Creating a single SQL script for MyFC Dataset


RUNTIME: 
Xm Xs

NOTES: 
To answer "What effect does fan engagement have on player performance?" using the MyFC dataset, 
we need to assume the dataset contains information on:

Player performance metrics (goals, assists, passes, etc.).
Fan engagement metrics (likes, comments, shares, etc. on social media).
A link between fan engagement and the players (e.g., fan engagement for specific players or matches).
Assuming we have the following tables:

PlayerPerformance: Contains player performance data (PlayerId, MatchId, Goals, Assists, Passes, PerformanceRating).
FanEngagement: Contains fan engagement data (MatchId, PlayerId, Likes, Shares, Comments).
Player: Contains player info (PlayerId, PlayerName).
We will calculate the correlation between fan engagement and player performance by analyzing the average performance rating 
in relation to the total fan engagement.
 
******************************************************************************************************************/

-- Q4: What effect does fan engagement have on player performance?
-- A4: The result will show the average performance rating for each player and the total fan engagement they received. 
--     You can analyze the correlation between the two by observing whether higher fan engagement corresponds with better performance.

SELECT 
    p.PlayerName,
    AVG(pp.PerformanceRating) AS AveragePerformance,
    SUM(fe.Likes + fe.Shares + fe.Comments) AS TotalFanEngagement
FROM 
    Player p
JOIN 
    PlayerPerformance pp ON p.PlayerId = pp.PlayerId
JOIN 
    FanEngagement fe ON pp.MatchId = fe.MatchId AND pp.PlayerId = fe.PlayerId
GROUP BY 
    p.PlayerName
ORDER BY 
    TotalFanEngagement DESC;




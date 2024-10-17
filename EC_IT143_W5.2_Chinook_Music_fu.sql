/*****************************************************************************************************************
NAME:    Chinook Music Dataset
PURPOSE: To return the most popular genre by total sales

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Chinook Music Dataset


RUNTIME: 
Xm Xs

NOTES: 
To determine the most popular music genre by sales in the Chinook Music dataset, we need to:

Join relevant tables to connect tracks with their genres and their sales information (invoices).
Sum the total sales for each genre.
Sort the results to find the genre with the highest sales.
 
******************************************************************************************************************/

-- Q1: what is the most popular music genre by sales?
-- A1: This query will return the most popular genre by total sales.

SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM 
    Genre g
JOIN 
    Track t ON g.GenreId = t.GenreId
JOIN 
    InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY 
    g.Name
ORDER BY 
    TotalSales DESC
LIMIT 1;


/*****************************************************************************************************************
NAME:    Chinook Music Dataset
PURPOSE: To determine which artists generate the most revenue

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Chinook Music Dataset


RUNTIME: 
Xm Xs

NOTES: 
To determine which artists generate the most revenue in the Chinook Music dataset, we need to:

Join relevant tables to connect tracks, albums, and artists with their sales (invoices).
Sum the total sales for each artist.
Sort the results to find the artists who generate the highest revenue.
 
******************************************************************************************************************/

-- Q2: Which artists generate the most revenue? 
-- A2: This query will return a list of the top artists by total revenue, showing which artists generate the most sales in the dataset.


SELECT 
    ar.Name AS Artist,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
FROM 
    Artist ar
JOIN 
    Album al ON ar.ArtistId = al.ArtistId
JOIN 
    Track t ON al.AlbumId = t.AlbumId
JOIN 
    InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY 
    ar.Name
ORDER BY 
    TotalRevenue DESC
LIMIT 10;



/*****************************************************************************************************************
NAME:    Chinook Music Dataset
PURPOSE: To estimate what might have led to the highest album sales

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Francis       1. Creating a single SQL script for Chinook Music Dataset


RUNTIME: 
Xm Xs

NOTES: 
To estimate what might have led to the highest album sales, we can analyze factors such as:

Geographic location of customers (which can indicate region-specific campaigns),
Purchase behaviors (e.g., repeat customers or high sales volumes in certain time periods),
Seasonality (to see if certain times of year generate higher sales).
 
******************************************************************************************************************/

-- Q3: What marketing strategies lead to the highest album sales?
-- A3: While the Chinook dataset lacks direct marketing strategy data, analyzing sales by customer location, time trends, 
--     and customer behavior can help infer which marketing strategies might be leading to the highest album sales.


SELECT 
    c.Country, 
    c.City,
    a.Title AS AlbumTitle,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM 
    Customer c
JOIN 
    Invoice i ON c.CustomerId = i.CustomerId
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN 
    Track t ON il.TrackId = t.TrackId
JOIN 
    Album a ON t.AlbumId = a.AlbumId
GROUP BY 
    c.Country, c.City, a.Title
ORDER BY 
    TotalSales DESC
LIMIT 10;


GROUP BY YEAR(i.InvoiceDate), a.Title
ORDER BY TotalSales DESC


SELECT c.CustomerId, COUNT(i.InvoiceId) AS PurchaseCount
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
HAVING COUNT(i.InvoiceId) > 1;



/*****************************************************************************************************************
NAME:    MyFC Dataset
PURPOSE: To determine which formations yield the most victories

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/17/2024   Percy Jara    1. Creating a single SQL script for MyFC Dataset


RUNTIME: 
Xm Xs

NOTES: 
To answer the question "Which formations yield the most victories?" using the MyFC dataset, 
we need to assume that the dataset contains information about:

Match results, including whether a team won or lost.
Formations used by the team in each match.
Teams and the number of matches they played.
Assuming the relevant tables might be:

Match: Contains match results (MatchId, TeamId, FormationId, IsVictory).
Formation: Contains formations (FormationId, FormationName).
Team: Contains team info (TeamId, TeamName).
We will need to:

Join the formations and match results.
Filter out the matches where the team won.
Group by formation and count victories.
Sort the formations by the number of victories.
 
******************************************************************************************************************/

-- Q4: Which formations yield the most victories?
-- A4: This query will return the formations that have led to the most victories in the dataset.


SELECT 
    f.FormationName,
    COUNT(m.MatchId) AS VictoryCount
FROM 
    Match m
JOIN 
    Formation f ON m.FormationId = f.FormationId
WHERE 
    m.IsVictory = 1  -- Assuming 1 indicates a win
GROUP BY 
    f.FormationName
ORDER BY 
    VictoryCount DESC
LIMIT 10;



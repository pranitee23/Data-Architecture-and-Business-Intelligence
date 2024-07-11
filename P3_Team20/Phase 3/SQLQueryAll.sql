SELECT 
  c.contribution_description,
  COUNT(f.FactorSK) AS Frequency
FROM [Project_Final].[dbo].[Fact_Factors] f
JOIN [Project_Final].[dbo].[Dim_Contributing_Factor] c ON f.ContributingFactorSK = c.ContributingFactorSK
GROUP BY c.contribution_description
ORDER BY Frequency DESC;

-- Q1 Exclude -999 rows and then sum-up the total_injured & killed
SELECT 
    SUM(CASE WHEN COALESCE(total_injured, -1) = -999 THEN 0 ELSE COALESCE(total_injured, 0) END) AS total_injured_sum,
    SUM(CASE WHEN COALESCE(total_killed, -1) = -999 THEN 0 ELSE COALESCE(total_killed, 0) END) AS total_killed_sum,
    COUNT(*) AS collision_count
FROM 
    Fact_Collision
WHERE 
    COALESCE(total_injured, -1) <> -999 AND COALESCE(total_killed, -1) <> -999;

-- Q3 Overall Accidents Resulting in Just Injuries
SELECT 
  COUNT(*) AS Total_Injury_Only_Accidents
FROM [Project_Final].[dbo].[Fact_Collision]
WHERE total_injured >= 0;

-- Q4 Overall Pedestrian Involvement in Accidents Count
SELECT 
  COUNT(*) AS Total_Accidents_With_Pedestrians
FROM [Project_Final].[dbo].[Fact_Collision]
WHERE no_of_pedestrains_injured >= 0 OR no_of_pedestrains_killed >= 0;

-- Q4b Overall Pedestrian Involvement in Accidents with Injury & Killed Count
SELECT 
    COUNT(*) AS Total_Accidents_With_Pedestrians,
    SUM(no_of_pedestrains_injured) AS Total_Pedestrians_Injured,
    SUM(no_of_pedestrains_killed) AS Total_Pedestrians_Killed
FROM [Project_Final].[dbo].[Fact_Collision]
WHERE no_of_pedestrains_injured >= 0 OR no_of_pedestrains_killed >= 0;

--Q5 Seasonality Report Numbers
SELECT 
  d.season,
  COUNT(f.collision_id) AS Total_Accidents
FROM [Project_Final].[dbo].[Fact_Collision] f
JOIN [Project_Final].[dbo].[Dim_Date] d ON f.DateSK = d.DateSK
GROUP BY d.season
ORDER BY Total_Accidents DESC;


-- Q6 Overall Motorist Casualties
SELECT 
    COUNT(*) AS Total_Accidents_With_Motorists,
    SUM(CASE WHEN no_of_motorist_injured >= 0 THEN no_of_motorist_injured ELSE 0 END) AS Total_Motorists_Injured,
    SUM(CASE WHEN no_of_motorist_killed >= 0 THEN no_of_motorist_killed ELSE 0 END) AS Total_Motorists_Killed
FROM [Project_Final].[dbo].[Fact_Collision]
WHERE no_of_motorist_injured >= 0 OR no_of_motorist_killed >= 0;




SELECT 
  t.time_of_day,
  COUNT(f.collision_id) AS Total_Accidents
FROM [Project_Final].[dbo].[Fact_Collision] f
JOIN [Project_Final].[dbo].[Dim_Time] t ON f.TimeSK = t.TimeSK
GROUP BY t.time_of_day
ORDER BY t.time_of_day;


-- Q9 Fatality Comparison Between Pedestrains/Motorist/Cyclist
SELECT 
  SUM(CASE WHEN no_of_pedestrains_killed != -999 THEN no_of_pedestrains_killed ELSE 0 END) AS Pedestrians_Killed,
  SUM(CASE WHEN no_of_motorist_killed != -999 THEN no_of_motorist_killed ELSE 0 END) AS Motorists_Killed,
  SUM(CASE WHEN no_of_cyclist_killed != -999 THEN no_of_cyclist_killed ELSE 0 END) AS Cyclists_Killed
FROM [Project_Final].[dbo].[Fact_Collision]
WHERE no_of_pedestrains_killed != -999
  AND no_of_motorist_killed != -999
  AND no_of_cyclist_killed != -999;

-- Q10 Fetch Common Contributing Factors
 SELECT 
 c.contribution_description,
 COUNT(f.FactorSK) AS Frequency
FROM [Project_Final].[dbo].[Fact_Factors] f
JOIN [Project_Final].[dbo].[Dim_Contributing_Factor] c ON f.ContributingFactorSK = c.ContributingFactorSK
GROUP BY c.contribution_description
HAVING contribution_description != 'NA' AND contribution_description != 'UNABLE TO DETERMINE'
ORDER BY Frequency DESC;








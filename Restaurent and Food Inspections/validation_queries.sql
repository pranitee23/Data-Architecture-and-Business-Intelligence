--1st 
SELECT COUNT(f.inspection_id_sk) 
FROM fact_inspections f 
INNER JOIN dim_inspectiontype d ON f.inspection_sk = d.inspection_sk 
GROUP BY d.inspectiontype;


---2nd
SELECT d.inspectiontype, COUNT(f.inspection_id_sk) AS cnt 
FROM fact_inspections f INNER JOIN dim_inspectiontype d ON f.inspection_sk = d.inspection_sk 
GROUP BY d.inspectiontype ORDER BY cnt DESC;

--3rd 
SELECT f.total_violation_result, COUNT(f.violation_sk) AS cnt
FROM fact_violations f
GROUP BY f.total_violation_result
ORDER BY cnt DESC;

--4rd
SELECT f.total_violation_result, d.ZipCode AS zip, COUNT(f.violation_sk) AS cnt
FROM fact_violations f
INNER JOIN fact_Inspections f1 ON f.RestaurantID_SK = f1.RestaurantID_SK
INNER JOIN dim_location d ON f1.LocationID_SK = d.LocationID_SK
GROUP BY f.total_violation_result, d.ZipCode
ORDER BY cnt DESC;

-- 5th
SELECT d.risk_category, COUNT(f.inspection_id_sk) cnt
FROM fact_inspections f 
INNER JOIN dim_risk d ON f.risk_sk= d.risk_sk 
GROUP BY d.risk_category
ORDER BY cnt DESC;



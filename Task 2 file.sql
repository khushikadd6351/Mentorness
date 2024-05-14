SELECT * FROM Corona_virus_dataset;

#1
SELECT * FROM Corona_virus_dataset
WHERE 'Province' is NULL
   OR 'Country_Region' is NULL
   OR 'Latitude' is NULL
   OR 'Longitude' is NULL
   OR 'Date' is NULL
   OR 'Confirmed' is NULL
   OR 'Deaths' is NULL
   OR 'Recovered' is NULL;

#2
UPDATE Corona_virus_dataSET 
SET Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0)
WHERE Confirmed IS NULL
   AND Deaths IS NULL
   AND Recovered IS NULL;

#3
SELECT
  COUNT(*) AS Total_rows
FROM
  Corona_virus_dataset;
  
#4
SELECT
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM
    Corona_virus_dataset;

#5
SELECT 
    COUNT(DISTINCT EXTRACT(MONTH FROM str_to_date(Date, '%d-%m-%Y'))) AS num_months
FROM 
	Corona_virus_dataset;    

#6
SELECT
  EXTRACT(Month FROM str_to_date(Date, '%d-%m-%Y')) AS Month,
  EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,
  AVG(Confirmed) AS Avg_Confirmed,
  AVG(Deaths) AS Avg_Deaths,
  AVG(Recovered) AS Avg_Recovered
FROM
  Corona_virus_dataset
GROUP BY
  Month, Year;
  
#7
SELECT
  EXTRACT(Month FROM str_to_date(Date, '%d-%m-%Y')) AS Month,
  EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,
  SUBSTRING_INDEX(GROUP_CONCAT(Confirmed ORDER BY Confirmed DESC), ',', 1) AS Most_frequent_confirmed,
  SUBSTRING_INDEX(GROUP_CONCAT(Deaths ORDER BY Deaths DESC), ',', 1) AS Most_frequent_deaths,
  SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY Recovered DESC), ',', 1) AS Most_frequent_recovered
FROM
  Corona_virus_dataset
GROUP BY
  Year, Month
ORDER BY 
  Year, Month;

#8
SELECT
  EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,
  MIN(Confirmed) AS Min_Confirmed,
  MIN(Deaths) AS Min_Deaths,
  MIN(Recovered) AS Min_Recovered
FROM
  Corona_virus_dataset
GROUP BY Year
ORDER BY Year;

#9
SELECT
  EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,
  MAX(Confirmed) AS Max_Confirmed,
  MAX(Deaths) AS Max_Deaths,
  MAX(Recovered) AS Max_Recovered
FROM
  Corona_virus_dataset
GROUP BY Year
ORDER BY Year;

#10
SELECT
  EXTRACT(Month FROM str_to_date(Date, '%d-%m-%Y')) AS Month,
  EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,
  SUM(Confirmed) AS Total_Confirmed,
  SUM(Deaths) AS Total_Deaths,
  SUM(Recovered) AS Total_Recovered
FROM
  Corona_virus_dataset
GROUP BY
  Year, Month
ORDER BY 
  Year, Month;
  
#11
SELECT
   EXTRACT(Month FROM str_to_date(Date, '%d-%m-%Y')) AS Month,
   EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year, 
   SUM(Confirmed) AS Total_confirmed_cases,
   AVG(Confirmed) AS Avg_confirmed_cases,
   VARIANCE(Confirmed) AS Variance_confirmed_cases,
   STDDEV(Confirmed) AS Stdev_confirmed_cases
FROM Corona_virus_dataset
GROUP BY
  Year, Month
ORDER BY 
  Year, Month;

#12
SELECT
   EXTRACT(Month FROM str_to_date(Date, '%d-%m-%Y')) AS Month,
   EXTRACT(Year FROM str_to_date(Date, '%d-%m-%Y')) AS Year,  
   SUM(Deaths) AS Total_death_cases,
   AVG(Deaths) AS Avg_death_cases,
   VARIANCE(Deaths) AS Variance_death_cases,
   STDDEV(Deaths) AS Stdev_death_cases
FROM Corona_virus_dataset
GROUP BY
  Year, Month
ORDER BY 
  Year, Month;


#13
SELECT 
   SUM(Recovered) AS Total_recovered_cases,
   AVG(Recovered) AS Avg_recovered_cases,
   VARIANCE(Recovered) AS Variance_recovered_cases,
   STDDEV(Recovered) AS Stdev_recovered_cases
FROM Corona_virus_dataset;

#14
SELECT
    Country_Region, SUM(Confirmed) AS Total_confirmed_cases
FROM
    Corona_virus_dataset
GROUP BY Country_Region
ORDER BY Total_confirmed_cases DESC
LIMIT 1;
    
#15
WITH rankingCountry AS (
   SELECT
       Country_Region,
       Sum(Deaths) AS Total_death_cases,
       RANK() OVER(ORDER BY SUM(Deaths) ASC) AS rank_no
   FROM
       Corona_virus_dataset
   GROUP BY 
	   Country_Region
)
SELECT 
	Country_Region, Total_death_cases
FROM
    rankingCountry
WHERE
    rank_no = 1;

#16
SELECT Country_Region, SUM(Recovered) AS Total_Recovered
FROM Corona_virus_dataset
GROUP BY Country_Region
ORDER BY Total_Recovered DESC
LIMIT 5;











   



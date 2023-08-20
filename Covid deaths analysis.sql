-- some editing
use covid_data;
describe coviddeath;
DELETE FROM coviddeath 
WHERE
    total_cases = '';
DELETE FROM coviddeath 
WHERE
    totaldeaths = '';
DELETE FROM coviddeath 
WHERE
    reproduction_rate = '';
DELETE FROM coviddeath 
WHERE
    icu_patients = '';
UPDATE coviddeath 
SET 
    hosp_patients = 0
WHERE
    hosp_patients = '';
alter table coviddeath modify column hosp_patients int;
alter table coviddeath modify column date date;
alter table coviddeath modify column totaldeaths int;
alter table coviddeath modify column total_cases int;
alter table coviddeath modify column reproduction_rate int;
alter table coviddeath modify column icu_patients int;
SELECT 
    *
FROM
    coviddeath; 
SELECT 
    location,
    MAX(total_cases),
    population,
    MAX(total_cases / population) * 100
FROM
    coviddeath
WHERE
    location LIKE 'Andorra'
GROUP BY location, population;


-- Select data that we are going to be using
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    coviddeath
ORDER BY 1 , 2; 

-- looking at the total cases vs total deaths 
-- shows the likelihood of dying by covid in India
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS death_perc
FROM
    coviddeath
WHERE
    location LIKE 'India'
ORDER BY 1, 2;

-- total cases vs population
-- shows the percentage of the population that got affected by covid
SELECT 
    location,
    date,
    total_cases,
    population,
    (total_cases / population) * 100 AS covid_perc
FROM
    coviddeath
ORDER BY 1, 2;

-- highest infection rate countries compared to the population
SELECT 
    location,
    MAX(total_cases) AS 'Highest Infection Count',
    population,
    MAX((total_cases / population)) * 100 AS 'Percentage of population affected'
FROM
    coviddeath
GROUP BY location, population
ORDER BY MAX((total_cases / population)) * 100 DESC;

-- countries with the highest death count per population
SELECT 
    location, MAX(totaldeaths) AS 'Total Death Count'
FROM
    coviddeath
GROUP BY location
ORDER BY MAX(totaldeaths) DESC;

-- group by continent
SELECT 
    continent, MAX(totaldeaths) AS 'Total Death Count'
FROM
    coviddeath
GROUP BY continent
ORDER BY MAX(totaldeaths) DESC;

-- global numbers
SELECT 
    date,
    SUM(total_cases) AS total__cases,
    SUM(new_deaths) AS total__deaths,
    (SUM(new_deaths) / SUM(total_cases)) * 100 AS death_percentage
FROM
    coviddeath
GROUP BY date
ORDER BY 1, 2;

use covid_data;

CREATE TABLE covidvaccinations (
    iso_code VARCHAR(50),
    continent VARCHAR(50),
    location VARCHAR(50),
    date VARCHAR(50),
    total_tests VARCHAR(50),
    new_tests VARCHAR(50),
    total_tests_per_thousand VARCHAR(50),
    new_tests_per_thousand VARCHAR(50),
    new_tests_smoothed VARCHAR(50),
    new_tests_smoothed_per_thousand VARCHAR(50),
    positive_rate VARCHAR(50),
    tests_per_case VARCHAR(50),
    tests_units VARCHAR(50),
    total_vaccinations VARCHAR(50),
    people_vaccinated VARCHAR(50),
    people_fully_vaccinated VARCHAR(50),
    total_boosters VARCHAR(50),
    new_vaccinations VARCHAR(50),
    new_vaccinations_smoothed VARCHAR(50),
    total_vaccinations_per_hundred VARCHAR(50),
    people_vaccinated_per_hundred VARCHAR(50),
    people_fully_vaccinated_per_hundred VARCHAR(50),
    total_boosters_per_hundred VARCHAR(50),
    new_vaccinations_smoothed_per_million VARCHAR(50),
    new_people_vaccinated_smoothed VARCHAR(50),
    new_people_vaccinated_smoothed_per_hundred VARCHAR(50),
    stringency_index VARCHAR(50),
    population_density VARCHAR(50),
    median_age VARCHAR(50),
    aged_65_older VARCHAR(50),
    aged_70_older VARCHAR(50),
    gdp_per_capita VARCHAR(50),
    extreme_poverty VARCHAR(50),
    cardiovasc_death_rate VARCHAR(50),
    diabetes_prevalence VARCHAR(50),
    female_smokers VARCHAR(50),
    male_smokers VARCHAR(50),
    handwashing_facilities VARCHAR(50),
    hospital_beds_per_thousand VARCHAR(50),
    life_expectancy VARCHAR(50),
    human_development_index VARCHAR(50),
    excess_mortality_cumulative_absolute VARCHAR(50),
    excess_mortality_cumulative VARCHAR(50),
    excess_mortality VARCHAR(50),
    excess_mortality_cumulative_per_million VARCHAR(50)
);

load data infile 'CovidVaccinations.csv' into table covidvaccinations fields terminated by ',' ignore 1 lines;

-- SHOW variables LIKE "secure-file-priv";

SELECT 
    *
FROM
    covidvaccinations;

describe covidvaccinations;

UPDATE covidvaccinations 
SET 
    total_tests = 0
WHERE
    total_tests = '';

alter table covidvaccinations modify column total_tests bigint;

UPDATE covidvaccinations 
SET 
    new_tests = 0
WHERE
    new_tests = '';

alter table covidvaccinations modify column new_tests bigint;

-- join the two tables
SELECT 
    *
FROM
    coviddeaths cd
        JOIN
    covidvaccinations cv ON cd.date = cv.date
        AND cd.location = cv.location;
        
-- total population vs vaccinations
SELECT 
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations
    -- sum(cv.new 
FROM
    coviddeaths cd
        JOIN
    covidvaccinations cv ON cd.date = cv.date
        AND cd.location = cv.location
        where cd.continent <> '' and cd.location like "canada"
ORDER BY 2 , 3;
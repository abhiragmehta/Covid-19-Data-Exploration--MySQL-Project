/* 
Covid 19 Data Exploration Project
Skills Used : Wildcard characters,Comparison Operators, Aggregate Functions, Creating Views etc.
*/

# using project1 database
use project1;


# select all data from covid_deaths table
SELECT 
    *
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 3 , 4;



#select data that we are going to start with
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;




# Total cases vs Total deaths
# shows likelihood of dying if you contract covid in your country
# if we want know specifically about India then add code where location like '%india%'
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS death_percentage
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;



# Total Cases vs Population
# Shows what percentage of population infected with Covid
SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases / population) * 100 AS percent_population_infected
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;




# Countries with Highest Infection Rate compared to Population
SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_Count,
    MAX((total_cases / population)) * 100 AS percent_population_infected
FROM
    covid_deaths
GROUP BY location , population
ORDER BY percent_population_infected DESC;



# Countries with Highest Death Count per Population
SELECT 
    location, MAX(total_deaths) AS total_death_count
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY Location
ORDER BY total_death_count DESC;



# BREAKING THINGS DOWN BY CONTINENT
# Showing contintents with the highest death count per population
SELECT 
    continent, MAX(total_deaths) AS total_death_count
FROM
    covid_deaths
WHERE
    continent IS not  NULL
GROUP BY continent
ORDER BY total_death_count DESC;



#GLOBAL NUMBERS
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    (SUM(new_deaths) / SUM(new_cases)) * 100 AS death_percentage
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 ,2;



# create view to store data for later visualizations
create view global_numbers as
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    (SUM(new_deaths) / SUM(new_cases)) * 100 AS death_percentage
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 ,2;
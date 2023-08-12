--Preview the whole Covid_deaths table to get familiar with the data 
--SELECT *
--FROM covid_death

-- Compute to determine the percentage of cases that resulted to death 
--SELECT location, cast(date as date), total_cases, total_deaths,(total_deaths * 100.0)/nullif(total_cases,0) AS Death_percentage
--FROM covid_death
--ORDER BY  1, 2

--Further explore the death rate of individuals diagnozed with covid 19 disease in your country
--SELECT location,date, population, total_cases, total_deaths,(total_deaths * 100.0)/nullif(total_cases,0) AS Death_percentage
--FROM covid_death
--where location ilike '%States'
--ORDER BY 2

--Preview what percentage of population has been diagnozed with covid 19 in your country 
--SELECT location , date,  population, total_cases, ((total_cases*1.0)/ population)*100 as Prevalence_rate
--FROM covid_death
--where location ilike '%States'
--order by location, date 
 
--Countries that witnessed high prevalence of the covid 19 disease ( Covid prevelence >8% )
SELECT location ,  population, max(total_cases)total_covid_count, max((total_cases*1.0)/ nullif(population,0)*100) as highest_covid_rate
FROM covid_death
GROUP BY location, population
HAVING max((total_cases*1.0)/ nullif(population,0)*100) >= 8
ORDER BY highest_covid_rate desc

-- Countries that witnessed high death counts due to covid
--SELECT  location, max(total_deaths) AS total_death_count
--FROM covid_death
--WHERE continent !=''
--GROUP BY continent, location 
--ORDER BY max(total_deaths) desc

--Futher explore to show Continents that witnessed high death counts due to covid
--SELECT  location as continent, max(total_deaths) AS total_death_count
--FROM covid_death
--WHERE continent = '' and location != 'World'
--GROUP BY continent, location 
--ORDER BY max(total_deaths) desc

-- Aggregate to preview number of covid cases, total death etc globally
--SELECT sum(total_cases)as total_cases, sum(total_deaths) as total_deaths
--FROM covid_death

--Joined the table to a new table containing data about vaccinations and explore to view the progress of vaccinations 
--each day in different countries
--Select d.continent, d.location, d.date , d.population, v.new_vaccinations, sum(v.new_vaccinations) 
--OVER (PARTITION BY d.location ORDER BY d.location , d.date) as VaccinatedPopulationRollingCount
--From covid_death as d
--join covid_vac as v
--on d.location = v.location 
--and d.date = cast (v.date as date)
--WHERE d.continent !=''
--ORDER BY 2,3

--Created a Common Table Expression (CTE) to further calculate the percentage of the vaccinated population
--with popvsvac (continent, location, date , population, new_vaccinations,VaccinatedPopulationRollingCount)
--as
--(
--Select d.continent, d.location, d.date , d.population, v.new_vaccinations, sum(v.new_vaccinations) 
--OVER (PARTITION BY d.location ORDER BY d.location , d.date) as VaccinatedPopulationRollingCount
--From covid_death as d
--join covid_vac as v
--on d.location = v.location 
--and d.date = cast (v.date as date)
--WHERE d.continent !=''
--)
--Select *, (VaccinatedPopulationRollingCount * 1.0/nullif(population, 0))*100 as PercentVaccinated
--From popvsvac


--Created a tempory table that can be easily reuseable to further explore percentage of the vaccinated population
--DROP TABLE IF EXISTS PercentVaccinated
--CREATE TABLE PercentVaccinated
	--(continent varchar, location varchar, date date, population bigint, new_vaccinations INT, VaccinatedPopulationRollingCount INT )
	
--INSERT INTO PercentVaccinated
	--(Select d.continent, d.location, d.date , d.population, v.new_vaccinations, sum(v.new_vaccinations) 
--OVER (PARTITION BY d.location ORDER BY d.location , d.date) as VaccinatedPopulationRollingCount
--From covid_death as d
--join covid_vac as v
--on d.location = v.location 
--and d.date = cast (v.date as date)
--WHERE d.continent !='')
	--Select *, (VaccinatedPopulationRollingCount * 1.0/nullif(population, 0))*100 as PercentVaccinated
--From PercentVaccinated
	

---Create views for some queries for later visualizations
--CREATE VIEW PercentVaccinatedview AS
--Select d.continent, d.location, d.date , d.population, v.new_vaccinations, sum(v.new_vaccinations) 
--OVER (PARTITION BY d.location ORDER BY d.location , d.date) as VaccinatedPopulationRollingCount
--From covid_death as d
--join covid_vac as v
--on d.location = v.location 
--and d.date = cast (v.date as date)
--WHERE d.continent !=''
--ORDER BY 2,3
    
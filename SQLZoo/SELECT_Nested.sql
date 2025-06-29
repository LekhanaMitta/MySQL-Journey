-- https://www.sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
--1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world 
  WHERE population > (
    SELECT population FROM world 
    WHERE name = 'Russia');

--2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT w1.name FROM world w1, World w2
  WHERE w2.name = 'United Kingdom' 
  AND w1.gdp/w1.population > w2.gdp/w2.population 
  AND w1.continent = 'Europe';

SELECT name FROM world 
  WHERE gdp/population > (
    SELECT gdp/population FROM world 
    WHERE name = 'United Kingdom') 
  AND continent = 'Europe';

--3. List the name and continent of countries in the continents containing either Argentina or Australia. 
-- Order by name of the country.
SELECT w1.name, w1.continent FROM world w1, world w2
  WHERE (w2.name = 'Argentina' AND w1.continent = w2.continent) 
  OR (w2.name = 'Argentina' AND w1.continent = w2.continent);

--4. Which country has a population that is more than United Kingdom but less than Germany? 
-- Show the name and the population.
SELECT name, population FROM world 
  WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom') 
  AND population < (SELECT population FROM world WHERE name = 'Germany');

--5. Show the name and the population of each country in Europe. 
-- Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(population*100/(SELECT population FROM world 
                                          WHERE name = 'Germany'),0),'%') 
  AS percentage FROM world 
  WHERE continent = 'Europe';

--6. Which countries have a GDP greater than every country in Europe? [Give the name only.] 
-- (Some countries may have NULL gdp values)
SELECT name FROM world 
  WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL);

SELECT name FROM world 
  WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe');

--7. Find the largest country (by area) in each continent, show the continent, the name and the area.
SELECT continent, name, area FROM world w1
  WHERE area >= (SELECT MAX(area) FROM world w2 WHERE w1.continent = w2.continent);

--8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world w1
  WHERE name LIKE (SELECT name FROM world w2
    WHERE w1.continent = w2.continent 
    ORDER BY name ASC LIMIT 1);

--9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. 
-- Show name, continent and population.
SELECT name, continent, population FROM world
  WHERE continent NOT IN 
  (SELECT DISTINCT continent FROM world w1
  WHERE population > 25000000);

--10. Some countries have populations more than three times that of all of their neighbours (in the same continent). 
-- Give the countries and continents.
SELECT name, continent FROM world w1
  WHERE population/3 >= ALL(SELECT population FROM world w2
                            WHERE w1.continent = w2.continent 
                            AND w1.name NOT LIKE w2.name);


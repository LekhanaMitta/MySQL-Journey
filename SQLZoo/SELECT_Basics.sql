-- https://www.sqlzoo.net/wiki/SELECT_basics
-- My solutions for the practice questions in the above link.

-- 1. show the population of Germany
SELECT population FROM world
WHERE name = 'Germany';

-- 2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3. Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). 
-- The example below shows countries with an area of 250,000-300,000 sq. km. 
-- Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;

-- https://www.sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial
-- 2. Show the name for the countries that have a population of at least 200 million.
SELECT name FROM world
WHERE population >= 200000000;

--3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population as Per_capita_GDP FROM world
WHERE population >= 200000000;

--4. Show the name and population in millions for the countries of the continent 'South America'. 
SELECT name, population/1000000 as Per_Million FROM world
wHERE continent = 'South America';

--5. Show the name and population for France, Germany, Italy
SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy');

--6. Show the countries which have a name that includes the word 'United'
SELECT name FROM world
WHERE name LIKE 'United%';

--7. Two ways to be big: A country is big if it has an area of more than 3 million sq km or 
-- it has a population of more than 250 million.
-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;

--8. Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or
-- big by population (more than 250 million) but not both. Show name, population and area.
-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.
SELECT name, population, area FROM world
WHERE (area > 3000000 AND population < 250000000) 
  OR (area < 3000000 AND population > 250000000);

-- 9. For Americas show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000, 2), 
  ROUND(gdp/1000000000, 2) FROM world
WHERE continent = 'South America';

--10. Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/(1000*population))*1000 FROM world
WHERE gdp >= 1000000000000;

--11. Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);

--12. Show the name and the capital where the first letters of each match. 
-- Don't include countries where the name and the capital are the same word.
SELECT name, capital FROM world 
  WHERE LEFT(name,1) = LEFT(CAPITAL,1) 
  AND name <> capital;

--13. Find the country that has all the vowels and no spaces in its name.
SELECT name FROM world
WHERE name LIKE'%a%' AND 
name LIKE '%e%' AND
name LIKE '%i%' AND
name LIKE '%o%' AND
name LIKE '%u%' AND 
name NOT LIKE '% %';

-- https://www.sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
--1. shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner FROM nobel
 WHERE yr = 1950;

--2. Show who won the 1962 prize for literature.
SELECT winner FROM nobel
 WHERE yr = 1962 AND subject = 'literature';

--3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject FROM nobel 
WHERE winner = 'Albert Einstein';

--4. Give the name of the 'peace' winners since the year 2000, including 2000.
SELECT winner FROM nobel 
WHERE subject = 'peace' AND yr >=2000;

--5. Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
SELECT yr, subject, winner FROM nobel 
  WHERE subject = 'literature' 
  AND yr BETWEEN 1980 AND 1989;

--6. Show all details of the presidential winners: Theodore Roosevelt, Thomas Woodrow Wilson, Jimmy Carter, Barack Obama
SELECT * FROM nobel 
  WHERE winner IN 
  ('Theodore Roosevelt', 'Thomas Woodrow Wilson','Jimmy Carter',  'Barack Obama');

--7. Show the winners with first name John
SELECT winner FROM nobel  
  WHERE winner LIKE 'John%';

--8. Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
SELECT yr, subject, winner FROM nobel
  WHERE (subject = 'Physics' AND yr = 1980) 
  AND (subject = 'Chemistry' AND yr= 1984);

--9. Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
SELECT yr, subject, winner FROM nobel
  WHERE yr = 1980;

--10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) 
-- together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT yr, subject, winner FROM nobel
  WHERE (yr <1910 AND subject = 'Medicine') 
  AND (yr >= 2004 AND subject = 'Literature');

--11. List the winners, year and subject where the winner starts with Sir. 
-- Show the the most recent first, then by name order.
SELECT winner, yr, subject FROM nobel 
  WHERE winner LIKE 'Sir%'
  ORDER BY yr DESC, winner ASC;

--12. Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.
SELECT winner, subject FROM nobel
  WHERE yr=1984 ORDER BY subject,winner;




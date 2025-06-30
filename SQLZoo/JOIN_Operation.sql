-- https://www.sqlzoo.net/wiki/Old_JOIN_Tutorial

-- ttms Table
-- games	color	  who	        country
-- 1988	  gold	  Yoo Nam-Kyu	KOR
-- 1988	  silver	Kim Ki Taik	KOR

-- country table
-- id	  name
-- ALG	Algeria
-- ARG	Argentina

-- ttws table
-- games	color	  who	        country
-- 1988	  gold	  Jing Chen	  CHN
-- 1988	  silver	Li Hui-Fen	CHN

-- games table
-- yr	  city	    country
-- 1988	Seoul	    KOR
-- 1992	Barcelona	ESP

-- ttmd table
-- games	color	  team	country
-- 1988	  gold	  1	    CHN
-- 1988	  silver	2	    YUG

-- team table
-- id	name
-- 1	Long-Can Chen
-- 1	Qing-Guang Wei
-- 2	Ilija Lupulesku
-- 2	Zoran Primorac

--1. Show the athelete (who) and the country name for medal winners in 2000.
SELECT who, name 
  FROM ttms JOIN country ON id = country
  WHERE games = 2000;

--2. Show the who and the color of the medal for the medal winners from 'Sweden'.
SELECT who, color 
  FROM ttms JOIN country ON id = country
  WHERE name = 'Sweden';

--3. Show the years in which 'China' won a 'gold' medal.
SELECT games 
  FROM ttms JOIN country ON id = country
  WHERE name = 'China' AND color = 'Gold';

--4. Show who won medals in the 'Barcelona' games.
SELECT who 
  FROM ttws JOIN games on games.yr = ttws.games
  WHERE city = 'Barcelona';

--5. Show which city 'Jing Chen' won medals. Show the city and the medal color.
SELECT city, color 
  FROM ttws JOIN games ON yr = games 
  WHERE who = 'Jing Chen';

--6. Show who won the gold medal and the city.
SELECT who, city 
  FROM ttws JOIN games ON yr = games 
  WHERE color = 'Gold';

--7. Show the games and color of the medal won by the team that includes 'Yan Sen'.
SELECT games, color 
  FROM ttmd JOIN team ON id = team 
  WHERE name = 'Yan sen';

--8. Show the 'gold' medal winners in 2004.
SELECT name 
  FROM team JOIN ttmd ON team = id 
  WHERE color = 'Gold' AND games = 2004;

--9. Show the name of each medal winner country 'FRA'.
SELECT name 
  FROM team JOIN ttmd ON team = id 
  WHERE country = 'FRA';

-- https://www.sqlzoo.net/wiki/The_JOIN_operation

-- game Table
-- id	  mdate	        stadium	                  team1	team2
-- 1001	8 June 2012  	National Stadium, Warsaw	POL  	GRE
-- 1002	8 June 2012	  Stadion Miejski (Wroclaw)	RUS  	CZE
-- 1003	12 June 2012	Stadion Miejski (Wroclaw)	GRE  	CZE
-- 1004	12 June 2012	National Stadium, Warsaw	POL  	RUS

-- goal Table
-- matchid	teamid	player	              gtime
-- 1001	    POL	    Robert Lewandowski	  17
-- 1001	    GRE	    Dimitris Salpingidis	51
-- 1002	    RUS	    Alan Dzagoev	        15
-- 1002	    RUS	    Roman Pavlyuchenko	  82

-- eteam Table
-- id	teamname	      coach
-- POL	Poland	        Franciszek Smuda
-- RUS	Russia	        Dick Advocaat
-- CZE	Czech Republic	Michal Bilek
-- GRE	Greece	        Fernando Santos

--1. Modify it to show the matchid and player name for all goals scored by Germany. 
-- To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal
  WHERE teamid = 'GER';

--2. Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2 FROM game
  WHERE id = 1012;

--3. show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON id=matchid
  WHERE teamid = 'GER';

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
  FROM game JOIN goal ON id=matchid
  WHERE player LIKE 'Mario%';

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime 
  FROM goal JOIN eteam ON teamid = id WHERE gtime <= 10;

--6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT game.mdate, eteam.teamname 
  FROM game JOIN eteam ON game.team1 = eteam.id
  WHERE eteam.coach = 'Fernando Santos';

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player 
  FROM game JOIN goal on id = matchid
  WHERE stadium = 'National Stadium, Warsaw';

--8. show the name of all players who scored a goal against Germany.
SELECT DISTINCT player 
  FROM game JOIN goal ON id = matchid
  WHERE (game.team1 = goal.teamid AND game.team2 = 'GER')
  OR (game.team2 = goal.teamid AND game.team1 = 'GER');

--9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(teamname) 
  FROM eteam JOIN goal ON goal.teamid = eteam.id
  GROUP BY teamname;

--10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) 
  FROM game JOIN goal ON id = matchid
  GROUP BY stadium;

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(matchid) 
  FROM game INNER JOIN goal ON matchid = id 
  WHERE team1 = 'POL' OR team2 = 'POL'
  GROUP BY matchid, mdate;

--12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(teamid) 
  FROM goal JOIN game ON game.id = goal.matchid 
  WHERE teamid = 'GER' 
  GROUP BY teamid, matchid, mdate;

--13. List every match with the goals scored by each team, Sort your result by mdate, matchid, team1 and team2.
SELECT game.mdate, game.team1,
  SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) score1,
  game.team2, SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON goal.matchid = game.id
  GROUP BY game.mdate, game.id, game.team1, game.team2;

-- https://www.sqlzoo.net/wiki/More_JOIN_operations
-- movie table - (id, title,	yr, director, budget, gross)
-- actor table - (id, name)
-- casting table - (movieid, actorid, ord)

--1. List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie
 WHERE yr=1962;

--2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
  WHERE title = 'Citizen Kane';

--3. List all of the Star Trek movies, include the id, title and yr 
-- (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr FROM movie
  WHERE title LIKE 'Star Trek%'
  ORDER BY yr;

--4. What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
  WHERE name = 'Glenn Close';

--5. What is the id of the film 'Casablanca'
SELECT DISTINCT id 
  FROM movie JOIN casting ON id = movieid
  WHERE title = 'Casablanca';

--6. Obtain the cast list for 'Casablanca'.
SELECT name 
  FROM actor JOIN casting ON actorid = id
  WHERE movieid = (SELECT DISTINCT id 
                    FROM movie JOIN casting ON id = movieid
                    WHERE title = 'Casablanca');

--7. Obtain the cast list for the film 'Alien'
SELECT name 
  from actor JOIN casting ON actorid = id
  WHERE movieid = (SELECT DISTINCT id 
                    FROM movie JOIN casting ON movieid = id
                    WHERE title = 'Alien');

--8. List the films in which 'Harrison Ford' has appeared
SELECT title 
  FROM movie JOIN casting ON movieid = id 
  WHERE actorid = (SELECT DISTINCT id FROM actor
                    WHERE name = 'Harrison Ford');

--9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title 
  FROM movie JOIN casting ON movieid = id
  WHERE actorid = (SELECT id FROM actor 
                    WHERE name = 'Harrison Ford') 
  AND ord > 1;

--10. List the films together with the leading star for all 1962 films.
SELECT title, name 
  FROM movie JOIN casting ON movieid = movie.id
  JOIN actor ON actor.id = actorid
  WHERE yr = 1962 AND ord = 1;

--11. Which were the busiest years for 'Rock Hudson', 
-- show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(*) 
  FROM movie LEFT JOIN casting ON movieid = movie.id 
  LEFT JOIN actor ON actor.id = actorid
  WHERE name = 'Rock Hudson'
  GROUP BY yr HAVING count(*) > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Get the movie ids of Julie Andrews acted, for those movie ids select title and name of actors who are lead roles
SELECT title, name 
  FROM movie JOIN casting ON movieid = movie.id
  JOIN actor ON actor.id = actorid
  WHERE movie.id IN (SELECT movieid 
                      FROM casting JOIN actor ON actor.id = actorid
                      WHERE name = 'Julie Andrews') 
  AND ORD = 1;

--13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name 
  FROM actor JOIN casting ON actorid = actor.id
  WHERE ord = 1
  GROUP BY name, actorid HAVING COUNT(*) >= 15
  ORDER BY name ASC;

--14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) 
  FROM movie JOIN casting ON movieid = movie.id
  WHERE yr = 1978
  GROUP BY movieid, title
  ORDER BY COUNT(actorid) DESC, title;

--15. List all the people who have worked with 'Art Garfunkel'.
SELECT name 
  FROM actor JOIN casting ON actorid = actor.id
  WHERE movieid IN (SELECT movieid 
                    FROM casting JOIN actor ON actor.id = casting.actorid
                    WHERE actor.name = 'Art Garfunkel') 
  AND name NOT LIKE 'Art Garfunkel';

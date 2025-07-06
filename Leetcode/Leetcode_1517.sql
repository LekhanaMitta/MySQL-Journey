# Write your MySQL query statement below
-- SELECT * FROM Users
-- WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9\._\-]*@leetcode(\\?com)?\\.com' ;

SELECT * FROM Users
WHERE regexp_like(mail, '^[a-zA-Z]+[a-zA-Z0-9\.\_\-]*@leetcode(\\?com)?\\.com$', 'c');

-- Explanation:
-- Approach - 1:
-- Using REGEXP and regular expression where
-- '^' - beginning of the expression
-- [] - accepted characters in the grammar are written
-- a-z - lower case alphabets
-- A-Z - upper case alphabets
-- 0-9 - numeric values
-- * - the expression can be repeated or not
-- + - the expression is repeated at least once.
-- \ - to give literal character for special characters
-- '.' - a full stop (.)
-- '' - a underscore ()
-- '-' - a dash (-)
-- '\?' - engine sees '?' which means optional (whether the set can be in the expression)
-- '\\?'(double backslash) - engine sees '\?' which is literal '?'
-- '$' - end of the expression. '^[a-zA-Z][a-zA-Z0-9\._\-]@leetcode(\\?com)?\\.com' 
-- Here, 
-- 1. ^[a-zA-Z] - make sure beginning of expression starts with an alphabet. 
-- 2. [a-zA-Z0-9\._\-] - the rest of the email can only contain alphanumeric and (., -, _) 
-- 3. '@leetcode(\\?com)?\\.com - will make sure '?' can't be used instead of '.' so the expression '(\\?com)' make sures of this and end the expression. 

-- Approach - 2:
-- Using REGEXP_LIKE and regular expression where
-- '^' - beginning of the expression
-- [] - accepted characters in the grammar are written
-- a-z - lower case alphabets
-- A-Z - upper case alphabets
-- 0-9 - numeric values
-- * - the expression can be repeated or not
-- + - the expression is repeated at least once.
-- \ - to give literal character for special characters
-- '.' - a full stop (.)
-- '' - a underscore ()
-- '-' - a dash (-)
-- '\?' - engine sees '?' which means optional (whether the set can be in the expression)
-- '\\?'(double backslash) - engine sees '\?' which is literal '?'
-- '$' - end of the expression. '^[a-zA-Z][a-zA-Z0-9\._\-]@leetcode(\\?com)?\\.com$' 
-- Here, 
-- 1. ^[a-zA-Z] - make sure beginning of expression starts with an alphabet. 
-- 2. [a-zA-Z0-9\._\-] - the rest of the email can only contain alphanumeric and (., -, _) 
-- 3. '@leetcode(\\?com)?\\.com - will make sure '?' can't be used instead of '.' so the expression '(\\?com)' make sures of this and end the expression. 
-- 4. 'c' make sures the expression is case sensitive.

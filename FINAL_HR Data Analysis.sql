CREATE SCHEMA proj_hrdata;

USE proj_hrdata;

SELECT *
FROM hr1;

DESCRIBE hr1;

-- change column name and data type

ALTER TABLE hr1
CHANGE COLUMN ï»¿id emp_id VARCHAR(20);


-- check date formats


SELECT
	birthdate
FROM hr1;


SELECT
	MIN(birthdate) AS earliest,
    MAX(birthdate) AS latest
FROM hr1;

-- from initial check, there are 2 formats : '%-%' or '%/%' while the earliest date is 01-01-2000 and latest date is 09-30-2001
-- fix birthdate formats

UPDATE hr1
SET birthdate = CASE
	WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- for safe update mode error, use SET  SQL_SAFE_UPDATES = 0;

SET  SQL_SAFE_UPDATES = 0;

-- change birthdate column type

ALTER TABLE hr1
MODIFY COLUMN birthdate DATE;

-- re-check results of birthdate column

SELECT
	birthdate
FROM hr1;


SELECT
	MIN(birthdate) AS earliest,
    MAX(birthdate) AS latest
FROM hr1;

-- since after change the earliest birthdat is now 1965-10-16 and latest is 2069-12-12 there has been a conversion error
-- find outliers by assuming a recent date as a point of reference to run search of outliers in birthdate
-- e.g., for current YEAR of 2024, and assuming a minimum age of 18, then the latest birthdate should be in 2006, therefore, use YEAR 2006 as reference


SELECT
	MIN(birthdate) as earliest,
    MAX(birthdate) as latest
FROM hr1
WHERE birthdate > '2006-01-01';

SELECT
	MIN(birthdate) as earliest,
    MAX(birthdate) as latest
FROM hr1
WHERE birthdate < '2006-01-01';

SELECT
	COUNT(birthdate) AS outliers
FROM hr1
WHERE birthdate > '2006-01-01';

SELECT
	COUNT(birthdate) AS normal
FROM hr1
WHERE birthdate < '2006-01-01';

-- this resulted in finding out birthdate outliers from 2065-11-01 until 2069-12-12, which will now need to be converted to normal YEAR range
-- run DATE_SUB(birthdate, INTERVAL 100 YEAR) for years 2065-2069

UPDATE hr1
SET birthdate = DATE_SUB(birthdate, INTERVAL 100 YEAR)
WHERE birthdate >= '2065-01-01' and birthdate <='2070-01-01';

-- run check

SELECT
	birthdate
FROM hr1;


SELECT
	MIN(birthdate) AS earliest,
    MAX(birthdate) AS latest
FROM hr1;

-- move to hire_date column

SELECT 
	hire_date
FROM hr1;

SELECT
	MIN(hire_date) as earliest,
    MAX(hire_date) as latest
FROM hr1;

UPDATE hr1
SET hire_date = CASE
	WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr1
MODIFY COLUMN hire_date DATE;


-- check on termdate

SELECT 
	termdate
FROM hr1;

UPDATE hr1
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != "";


ALTER TABLE hr1
MODIFY COLUMN termdate DATE;

SELECT
	MIN(termdate) as earliest,
    MAX(termdate) as latest
FROM hr1
WHERE termdate IS NOT NULL;

SELECT
	COUNT(termdate)
FROM hr1
WHERE termdate IS NOT NULL;


-- add age column

ALTER TABLE hr1
ADD COLUMN age INT;

UPDATE hr1
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT
	MIN(age) as earliest,
    MAX(age) as latest
FROM hr1;

-- add job tenure

ALTER TABLE hr1
ADD COLUMN job_tenure INT;

UPDATE hr1
SET job_tenure = timestampdiff(YEAR, hire_date, termdate);


-- run final check

SELECT
	COUNT(emp_id)
FROM hr1
WHERE termdate IS NOT NULL and termdate <= CURDATE();

SELECT
	COUNT(emp_id)
FROM hr1
WHERE termdate IS NULL OR termdate > CURDATE();

SELECT *
FROM hr1;	

DESCRIBE hr1;

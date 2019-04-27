DROP TABLE IF EXISTS dim_date;

CREATE TABLE	Dim_Date
	(	DateKey INT PRIMARY KEY AUTO_INCREMENT, 
		DATE DATETIME,
		DAYOFMONTH VARCHAR(2), -- Field will hold day number of Month
		DAYNAME VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		DayOfWeekInMonth VARCHAR(2), -- 1st Monday or 2nd Monday in Month
		DayOfWeekInYear VARCHAR(2),
		DayOfQuarter VARCHAR(3),
		DAYOFYEAR VARCHAR(3),
		WeekOfMonth VARCHAR(1), -- Week Number of Month 
		WeekOfQuarter VARCHAR(2), -- Week Number of the Quarter
		WEEKOFYEAR VARCHAR(2), -- Week Number of the Year
		MONTH VARCHAR(2), -- Number of the Month 1 to 12
		MONTHNAME VARCHAR(9), -- January, February etc
		QUARTER CHAR(1),
		QuarterName VARCHAR(9), -- First,Second..
		YEAR CHAR(4) -- Year value of Date stored in Row

	);
	
	/* Adapted from Tom Cunningham's 'Data Warehousing with MySql' (www.meansandends.com/mysql-data-warehouse) */ 
 
 ###### small-numbers table 
 DROP TABLE IF EXISTS numbers_small; 
 CREATE TABLE numbers_small (number INT); 
 INSERT INTO numbers_small VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9); 
 
 
 ###### main numbers table 
 DROP TABLE IF EXISTS numbers; 
 CREATE TABLE numbers (number BIGINT); 
 INSERT INTO numbers 
 SELECT thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number 
   FROM numbers_small thousands, numbers_small hundreds, numbers_small tens, numbers_small ones 
 LIMIT 1000000; 
 

 ###### date table 
 DROP TABLE IF EXISTS dates; 
 CREATE TABLE dates ( 
   date_id          BIGINT PRIMARY KEY,  
   DATE             DATE NOT NULL, 
   TIMESTAMP        BIGINT ,  
   weekend          CHAR(10) NOT NULL DEFAULT "Weekday", 
   day_of_week      CHAR(10) , 
   MONTH            CHAR(10) , 
   month_day        INT ,  
   YEAR             INT , 
   week_starting_monday CHAR(2) , 
   UNIQUE KEY `date` (`date`), 
   KEY `year_week` (`year`,`week_starting_monday`) 
 ); 
 

 ###### populate it with days 
 INSERT INTO dates (date_id, DATE) 
 SELECT number, DATE_ADD( '2010-01-01', INTERVAL number DAY ) 
   FROM numbers 
   WHERE DATE_ADD( '2010-01-01', INTERVAL number DAY ) BETWEEN '2010-01-01' AND '2020-01-01' 
   ORDER BY number; 
 

 ###### fill in other rows 
 UPDATE dates SET 
   TIMESTAMP =   UNIX_TIMESTAMP(DATE), 
   day_of_week = DATE_FORMAT( DATE, "%W" ), 
   weekend =     IF( DATE_FORMAT( DATE, "%W" ) IN ('Saturday','Sunday'), 'Weekend', 'Weekday'), 
   MONTH =       DATE_FORMAT( DATE, "%M"), 
   YEAR =        DATE_FORMAT( DATE, "%Y" ), 
   month_day =   DATE_FORMAT( DATE, "%d" ); 
 

 UPDATE dates SET week_starting_monday = DATE_FORMAT(DATE,'%v'); 
 
INSERT INTO dim_date (DATE, DAYOFMONTH, YEAR, DAYNAME, MONTHNAME)
	SELECT DATE, month_day, YEAR, day_of_week, MONTH FROM dates;
	
UPDATE dim_date SET 
   MONTH = MONTH(DATE),
   QUARTER = QUARTER(DATE),
   DAYOFYEAR = DAYOFYEAR(DATE),
   WEEKOFYEAR = WEEKOFYEAR(DATE);
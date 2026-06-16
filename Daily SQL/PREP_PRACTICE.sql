-- Query the total population of all cities in CITY where District is California.

SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Query the average population of all cities in CITY where District is California.

SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Query the average population for all cities in CITY, rounded down to the nearest integer.

SELECT FLOOR(AVG(POPULATION))
FROM CITY;

-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';	

-- Show first name, last name, and gender of patients whose gender is 'M'

SELECT
		first_name,
		last_name,
		gender
FROM patients
where gender = 'M';

-- Show first name and last name of patients who does not have allergies. (null)

select
		first_name,
		last_name
from patients
where allergies is NULL;

-- Show first name of patients that start with the letter 'C'

select 
		first_name
FROM patients
WHERE first_name LIKE 'c%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT
		first_name,
		last_name
FROM patients
WHERE weight between 100 AND 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
		SET allergies = 'NKA'
WHERE allergies IS NULL;

-- Show first name and last name concatinated into one column to show their full name.

SELECT
		concat(first_name,' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'

select
		first_name,
		last_name,
		province_name
from patients p
JOIN province_names pn
ON pn.province_id = p.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year.

select 
		count(*) as total_patients
from patients
where year(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.

select
      first_name,
      last_name,
      height
from patients
where height = (select max(height) 
                from patients);

-- Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000

select *
from patients
where patient_id in (1, 45, 534, 879, 1000);

-- Show the total number of admissions

select
		count(*) as total_admission
from admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

select *
from admissions
where admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.

select 
		patient_id,
		count(*) as total_admission
from admissions
where patient_id = 579;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.

select distinct (city) as unique_cities
from patients
where province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

select 
		first_name,
		last_name,
		birth_date
from patients
where height > 160 and weight > 70;

-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

select 
		first_name,
		last_name,
		allergies
from patients
where allergies is not NULL and city = 'Hamilton';

-- Show how many patients have a birth_date with 2010 as the birth year.

select count(*) as total_patients
from patients
where year(birth_date) = 2010;

-- Show unique birth years from patients and order them by ascending.

select 
distinct YEar(birth_date) as birth_year
from patients
order by birth_year;

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
-- If only 1 person is named 'Leo' then include them in the output.

select first_name
from patients
group by first_name
having count(first_name) = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

select
      patient_id,
      first_name
from patients
where first_name like 's%____%s';

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.

select
      p.patient_id,
      first_name,
      last_name
from patients p
join admissions a
on a.patient_id = p.patient_id
where diagnosis = 'Dementia';

-- Display every patient's first_name.
-- Order the list by the length of each name and then by alphabetically.

select first_name
from patients
order by 
		len(first_name), 
		first_name;
        
-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

-- Display every patient's first_name.
-- Order the list by the length of each name and then by alphabetically.

select 
      first_name
from patients
order by
      LEN(first_name) asc,
      first_name asc;
      
-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
-- Show results ordered ascending by allergies then by first_name then by last_name.

select 
      first_name,
      last_name,
      allergies
from patients
where allergies IN ('Penicillin','Morphine')
Order by
      allergies asc,
      first_name asc,
      last_name asc;

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT
      patient_id,
      diagnosis
FROM admissions
group by patient_id,
		 diagnosis
having count(*) > 1;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

select 
         city,
         count(patient_id) as num_patients
from patients
group by city
order by num_patients desc, 
		 city asc;
         
-- Show all allergies ordered by popularity. Remove NULL values from query.

select 
      allergies,
      count(allergies) AS total_diagnosis
from patients
where allergies is not NULL
group by allergies
order by total_diagnosis desc;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

select
        first_name,
        last_name,
        birth_date
from patients
where year(birth_date) between 1970 AND 1979
ORDER BY birth_date ASC;

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane

select CONCAT(UPPER(last_name),
			  ',',
			  LOWER(first_name)) 
              AS new_name_format
        
FROM patients
order by first_name desc;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
         
select province_id,
	   sum(height) AS sum_height
        
FROM patients
group by province_id
having sum_height >= 7000;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

select 
	(MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
where last_name = 'Maroni';

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select
		day(admission_date) as day_number,
        count(patient_id) AS number_of_admissions
from admissions
group by day_number
Order by number_of_admissions DESC;

-- Show all columns for patient_id 542's most recent admission_date.

SELECT
		patient_id,
        admission_date,
        discharge_date,
        diagnosis,
        attending_doctor_id
FROM admissions
WHERE patient_id = 542
order by admission_date desc
LIMIT 1;

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECt
		patient_id,
        attending_doctor_id,
        diagnosis

from admissions

Where (patient_id % 2 != 0 AND attending_doctor_id IN (1, 5, 19))
OR    (attending_doctor_id LIKE '%2%'AND LEN(patient_id) = 3);

-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.

SELECt
		d.first_name,
        d.last_name,
        COUNT(a.patient_id) as admissions_total
     
from doctors d
join admissions a
on d.doctor_id = a.attending_doctor_id

group by first_name,
		 last_name,
         doctor_id;
         
-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select 
        day(admission_date) as day_number,
		count(patient_id) as number_of_admissions

from admissions

group by day_number
order by number_of_admissions DESC;

-- For each doctor, display their id, full name, and the first and last admission date they attended.

select

        d.doctor_id,
        concat(first_name,' ',last_name) AS full_name,
        MIN(a.admission_date) as first_admission_date,
        MAX(a.admission_date) As last_admission_date

from doctors d

JOIN admissions a
ON d.doctor_id = a.attending_doctor_id

GROup by doctor_id

order by d.doctor_id asc;

-- Display the total amount of patients for each province. Order by descending.
         
select
        pn.province_name,
        count(patient_id) as patient_count

from patients p

join province_names pn
On p.province_id = pn.province_id

group by pn.province_name
order by patient_count desc;

-- Display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.

select
      first_name,
      last_name,
      count(*) AS num_of_duplicates
from patients
group by first_name,
		 last_name
HAVING count(*) > 1;

-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

select
      concat(first_name,' ',last_name) as patient_name,
      ROUND(height/30.48,1) as 'height"Feet',
      ROUND(weight*2.205,0) AS 'weight"Pound',
      birth_date,
      CASE WHEN gender = 'M' THEN 'MALE' ELSE 'FEMALE' END AS 'gender_type'

from patients;

-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

select
		patients.patient_id,
        first_name,
        last_name
        
FROM patients

where patients.patient_id not in
	  (select admissions.patient_id
       from admissions);


-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. 
-- Average is rounded to 2 decimal places.

select 
        max(number_of_visits) as max_visits, 
        min(number_of_visits) as min_visits, 
        round(avg(number_of_visits),2) as average_visits 

from (select admission_date,
      count(*) as number_of_visits 
      from admissions
      group by admission_date);

-- Display every patient that has at least one admission and show their most recent admission along with the patient and doctor's full name.

select
        concat(p.first_name,' ',p.last_name) as patient_name,
        a.admission_date,
        concat(d.first_name,' ',d.last_name) as doctors_name
  
from patients p

join admissions a on a.patient_id = p.patient_id
JOIn doctors d on a.attending_doctor_id = d.doctor_id

WHERE a.admission_date = (SELECT MAX(a2.admission_date)
                          FROM admissions a2
                          WHERE a2.patient_id = p.patient_id);
                          
-- We define an employee's total earnings to be their monthly salary X months worked, 
-- and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
-- Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.

SELECT 
        (months * salary), 
        COUNT(*)
FROM Employee
GROUP BY (months * salary)
ORDER BY (months * salary) DESC
LIMIT 1;

-- Query the following two values from the STATION table:
-- The sum of all values in LAT_N rounded to a scale of  decimal places.
-- The sum of all values in LONG_W rounded to a scale of  decimal places.

select
        round(sum(lat_n),2) as lat,
        round(sum(long_w),2) as lon
from station;

-- Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to  decimal places.

select
        round(sum(lat_n),4)
from station
where lat_n > 38.7880 and lat_n < 137.2345;

-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to  decimal places.

select 
        round(max(lat_n),4)
from station
where lat_n < 137.2345;

-- OR 

SELECT 
        ROUND(lat_n, 4) 
FROM station 
WHERE lat_n < 137.2345 
ORDER BY lat_n DESC
LIMIT 1;

-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
-- Round your answer to  decimal places.

select 
        round(long_w,4)
from station
where lat_n < 137.2345
order by lat_n desc
limit 1;

-- Generate the following two result sets:
-- Query an alphabetically ordered list of all names in OCCUPATIONS, 
-- immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
-- For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
-- Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
-- There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is 
-- the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

select
        concat(name,'(',left(occupation,1),')')
from occupations
order by name;

select
        concat('There are a total of ',count(*),' ',lower(occupation),'s.')
from occupations
group by occupation
order by count(*),occupation;

-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.
-- The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.
-- Note: Print NULL when there are no more names corresponding to an occupation.

SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
    
FROM (SELECT Name, Occupation,
      ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) 
      AS row_num
      FROM OCCUPATIONS)
    
AS numbered_occupations
GROUP BY row_num;

-- You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
-- Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
-- Root: If node is root node.
-- Leaf: If node is leaf node.
-- Inner: If node is neither root nor leaf node.

select n,
        case
        when p is null then 'Root'
        when n not in (select p from bst where p is not null) then 'Leaf'
        else 'Inner'
        end
        
from bst
order by n;

-- Show first name, last name, and gender of patients whose gender is 'M'

select
      first_name,
      last_name,
      gender
from patients
where gender = "M";

-- Show first name and last name of patients who does not have allergies. (null)

select
	first_name,
	last_name
from patients
where allergies is null;

-- Show first name of patients that start with the letter 'C'

select
    first_name
FROM patients
WHERE first_name LIKE "C%";

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

select
    first_name,
    last_name
from patients
where weight between 100 and 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

update ptients
set allergies = 'NKA'
where allergies is null;

-- Show first name and last name concatinated into one column to show their full name.

select 
	concat(first_name," ", last_name)
from patients;

-- Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'

select
	first_name,
    last_name,
    province_name
from patients p

join province_names pn
on pn.province_id = p.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year.

select 
	count(*) as total_patients
from patients
where year(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.

select
      first_name,
      last_name,
      MAX(height)
from patients;

-- OR

select
      first_name,
      last_name,
      height
from patients
WHERE height = (SELECT MAX(height)
                from patients);

-- Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000

select *
from patients
where 
	patient_id IN ('1', '45', '534', '879', '1000');
    
-- Show the total number of admissions
 
select
	count(*) as total_admissions
from admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

select *
from admissions
where admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.

select 
	patient_id,
    count(*)
from admissions
where patient_id = 579;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.

SELECT distinct(city)
from patients
where province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

select
      first_name,
      last_name,
      birth_date
FROM patients

WHERE height > 160 AND weight > 70;

-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

select
      first_name,
      last_name,
      allergies
FROM patients
WHERE allergies is NOT null 
	  and city = 'Hamilton';

-- Show unique birth years from patients and order them by ascending.

select
		distinct year(birth_date) as birth_year
from patients
order by birth_year;

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
-- If only 1 person is named 'Leo' then include them in the output.

select 
		first_name
from patients
group by first_name
having count(first_name) = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

select
		patient_id,
        first_name
from patients
where first_name like "s%____%s";



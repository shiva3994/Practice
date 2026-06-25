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

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
-- If only 1 person is named 'Leo' then include them in the output.

select
		first_name
from patients
group by first_name
having COUNT(first_name) = 1;

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

select
		first_name
from patients
order by len(first_name),
		 first_name;
         
-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

select 
		(select count(*) from patients where gender = 'M') AS male_count,
        (select count(*) from patients where gender = 'F') AS female_count;

-- OR

select 
  SUM(Gender = 'M') AS male_count, 
  SUM(Gender = 'F') AS female_count
from patients;

-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

select 
		(select count(gender) from patients where gender = 'M') as male_count,
        (select count(gender) from patients where gender = 'F') as female_count;

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
-- Show results ordered ascending by allergies then by first_name then by last_name.

select
      first_name,
      last_name,
      allergies
from patients

where allergies IN ('Penicillin','Morphine')

order by allergies ASC,
		 first_name, 
		 last_name;
         
-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

select
        patient_id,
        diagnosis
from admissions

group by patient_id,
		 diagnosis

having count(diagnosis) > 1;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

SELECT
  city,
  COUNT(*) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC, city asc;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

select
      city,
      COUNT(*) AS num_patients
from patients

group by city
ORDER BY num_patients desc, city;

-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"

SELECT first_name, 
	   last_name, 
       'Patient' as role 
FROM patients

union all

select first_name, 
	   last_name, 
       'Doctor' from doctors;

-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"

select
		first_name,
        last_name,
        'Patient' as role
from patients        
        
union all

select
		first_name,
        last_name,
        'Doctor' as role
from doctors;

-- Show all allergies ordered by popularity. Remove NULL values from query.

select 
	allergies,
	count(*) as total_diagnosis

from patients
where allergies is not null

group by allergies
order by total_diagnosis desc;
 
-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

select
		first_name,
        last_name,
        birth_date
        
FROM patients

WHERE year(birth_date) between 1970 and 1979

order by birth_date;

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters.
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane

SELECT
		concat(upper(last_name),',',lower(first_name))
from patients
order by first_name desc;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT
		province_id,
        sum(height) as sum_height
        
from patients
group by province_id
having sum_height > 7000;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' 

select
		max(weight) - min(weight) as weight_difference
from patients
where last_name = 'Maroni';

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select
		Day(admission_date) as day_number,
        count(*) as number_of_admission
        
from admissions
group by day_number
order by number_of_admission desc;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT
		province_id,
        sum(height) as sum_height
from patients
group by province_id
having sum_height > 7000;

-- Show all columns for patient_id 542's most recent admission_date.

select * from admissions
where patient_id = 542
order by admission_date desc
limit 1;

-- OR 

SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
	   admission_date = MAX(admission_date);

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    attending_doctor_id IN (1, 5, 19)
    AND patient_id % 2 != 0
  )
  OR 
  (
    attending_doctor_id LIKE '%2%'
    AND len(patient_id) = 3;
  )

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

select 
		patient_id,
        attending_doctor_id,
        diagnosis
from admissions

Where ( attending_doctor_id in (1,5,19) 
       and patient_id % 2 != 0)
       
       or
       
       (attending_doctor_id like '%2%'
        AND len(patient_id) = 3);
        
-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.

select	
		d.first_name,
        d.last_name,
        count(*) as admissions_total
        
from admissions a
join doctors d
on a.attending_doctor_id = d.doctor_id
group by doctor_id;

-- Display the total amount of patients for each province. Order by descending.

select 
		province_name,
        count(*) as patient_count
from patients p
join province_names pn
on p.province_id = pn.province_id
group by province_name
order by patient_count desc;

-- For each doctor, display their id, full name, and the first and last admission date they attended.

select
		d.doctor_id,
        concat(d.first_name,' ',d.last_name) as full_name,
        min(a.admission_date) as first_admission_date,
        Max(a.admission_date) as last_admission_date
from admissions a
join doctors d
on a.attending_doctor_id = d.doctor_id
group by doctor_id;

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

select
		concat(p.first_name,' ',p.last_name) as patient_name,
        diagnosis,
        concat(d.first_name,' ',d.last_name) AS doctor_name

from patients p
join admissions a
on p.patient_id = a.patient_id
join doctors d
on a.attending_doctor_id = d.doctor_id;

-- display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.

select
		first_name,
        last_name,
        count(*) AS num_of_duplicate
from patients
group by first_name, 
		 last_name
having count(*) > 1;

-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

select
		concat(first_name,' ',last_name) as patient_name,
        round(height/30.48,1) as height,
        round(weight*2.205,0) AS weight,
        birth_date,
        CASE
            WHEN gender = 'M' 
            THEN 'MALE' 
            ELSE 'FEMALE' END 
            AS 'gender_type'
from patients;

-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
-- (Their patient_id does not exist in any admissions.patient_id rows.)

select
		p.patient_id,
        first_name,
        last_name
from patients p
where p.patient_id not in (select admissions.patient_id
                           from admissions);

-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select
		count(*) as patients_in_group,
        floor(weight/10)*10 as weight_group
from patients
group by weight_group
order by weight_group desc;









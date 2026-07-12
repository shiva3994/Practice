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
from patients ;

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


-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

SELECT 
		concat(first_name,' ',last_name) as full_name,
        round(height/30.48,1) as height,
        round(weight*2.205,0) as weight,
        birth_date,
        case
        	when gender = "M"
            then "Male"
            else "Female"
            End as gender_type
from patients;

-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
-- (Their patient_id does not exist in any admissions.patient_id rows.)

select 
		patients.patient_id,
        first_name,
        last_name
from patients
where patient_id not in (select admissions.patient_id
                         from admissions);
                         
-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. 
-- Average is rounded to 2 decimal places.

select
		max(no_of_visits) as max_visits,
        min(no_of_visits) as min_visits,
        round(avg(no_of_visits),2) as average_visits
from(select
             admission_date,
             count(*) as no_of_visits      
      from admissions
      group by admission_date);

-- Display every patient that has at least one admission and show their most recent admission along with the patient and doctor's full name.     
      
select
		concat(p.first_name,' ',p.last_name) as patient_name,
        max(admission_date),
        concat(d.first_name,' ',d.last_name) as doctor_name
from patients p
join admissions a
on p.patient_id = a.patient_id
join doctors d
on a.attending_doctor_id = d.doctor_id
group by p.patient_id;

-- OR

select
		concat(p.first_name,' ',p.last_name) as patient_name,
        a.admission_date,
        concat(d.first_name,' ',d.last_name) as doctor_name
        
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.admission_date = (SELECT 
                          		MAX(a2.admission_date)
    					  FROM admissions a2
    					  WHERE a2.patient_id = p.patient_id);

-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select
		count(*) as patients_in_group,
        floor(weight/10)* 10 as weight_group
        
from patients
group by weight_group
order by weight_group desc;

-- Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1.
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.

SELECT 
		patient_id,
        weight,
        height, 
  		(CASE 
         		WHEN weight/(POWER(height/100.0,2)) >= 30
         		THEN 1	
         		ELSE 0
      			END) AS isObese
FROM patients;

-- If you divide an int by an int you will get an int. Dividing an int by a float will return a float.
-- That's why you have to divide by 100.0 and not 100.
-- Use CAST(variable_name AS FLOAT) function if you are dividing by two variables.

-- ************************************************************************************************ --

-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select
        floor(weight/10)*10 as weight_group,
        count(*) as patients_in_group
from patients
group by weight_group
order by weight_group desc;

-- Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1.
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.

select
		patient_id,
        weight,
        height,
        CASE
        	when weight/(Power(height/100.00,2)) >= 30
            then 1
            else 0
            end as isObese
from patients;

-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
-- Check patients, admissions, and doctors tables for required information.

select
		p.patient_id,
        p.first_name as patients_first_name,
        p.last_name as patients_last_name,
        d.specialty as attending_doctor_speciality

from patients p

join admissions a
on p.patient_id = a.patient_id

join doctors d
on a.attending_doctor_id = d.doctor_id

where diagnosis = 'Epilepsy' and d.first_name = 'Lisa';

-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission.
-- Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT
      	DISTINCT P.patient_id,
        CONCAT(P.patient_id,
              LEN(last_name),
              YEAR(birth_date))
              as temp_password
  
FROM patients P
JOIN admissions A ON A.patient_id = P.patient_id;

-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 
        CASE WHEN patient_id % 2 = 0 Then 
            'Yes'
        ELSE 
            'No' END 
        as has_insurance,
        
        SUM(CASE WHEN patient_id % 2 = 0 Then 
            10
        ELSE 
            50 END)
        as cost_after_insurance
        
FROM admissions 
GROUP BY has_insurance;

-- All patients who have gone through admissions, can see their medical documents on our site. 
-- Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT 
		p.patient_id,
		concat(p.patient_id,
               len(p.last_name),
               year(p.birth_date))
               as temp_password

FROM patients p
join admissions a
on p.patient_id = a.patient_id
group by p.patient_id;

-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT
		CASE
        when patient_id % 2 = 0
        then "Yes"
        else "No"
        end as has_insurance,
		
	SUM(case
        when patient_id % 2 = 0
        then 10
        else 50
        end) as cost_after_insurance
            
from admissions
group by has_insurance;

-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

Select
		pn.province_name
        
from patients p
join province_names pn
on p.province_id = pn.province_id

group by pn.province_name
having 
	sum(gender = 'M') > sum(gender = 'F');
    
-- OR

select
		province_name
from (SELECT
              province_name,
              SUM(gender = 'M') AS n_male,
              SUM(gender = 'F') AS n_female
        FROM patients pa
        JOIN province_names pr ON pa.province_id = pr.province_id
        GROUP BY province_name)
        
where n_male > n_female;
    
-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
    
select 
		province_name

from (Select
		pn.province_name,
        sum(gender = 'M') as num_male,
        sum(gender = 'F') as num_female
      	from patients p
        join province_names pn on p.province_id = pn.province_id
        group by pn.province_name)
        
where num_male > num_female;

-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- - First_name contains an 'r' after the first two letters.
-- - Identifies their gender as 'F'
-- - Born in February, May, or December
-- - Their weight would be between 60kg and 80kg
-- - Their patient_id is an odd number
-- - They are from the city 'Kingston'

select *        
from patients

where first_name like '%__R%'
	  And gender = 'F'
      and month(birth_date) in ( 2, 5, 12)
      and weight between 60 and 80
      and patient_id % 2 != 0
      and city = 'Kingston';
      
-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT 
   		CONCAT(
        	   ROUND(
                     SUM(gender = 'M') / CAST(COUNT(*) AS float),4) * 100, '%') as percent_of_male_patients
FROM patients;

-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

SELECT 
		admission_date,
        count(*) as admission_day,
        count(admission_date) - lag(count(admission_date)) 
        over(order by admission_date) as admission_count_change

from admissions
group by admission_date

-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

select
	concat
    (round(sum(gender = 'M')/ cast(count(*)as float),4) * 100,'%')
    As Percent_of_male_patient
from patients;
      
-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

SELECT 
		admission_date,
        count(*) as admissions_per_day,
        count(admission_date) - lag(count(admission_date)) over(order by admission_date) as admissions_count_change
from admissions
group by admission_date;

-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

select province_name
from province_names
order by
        (not province_name = 'Ontario'),
        province_name;

-- We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

SELECT
		doctor_id,
        concat(first_name," ",last_name) as doctor_name,
        specialty,
        year(admission_date) as selected_year,
        count(*) as total_admission        
        
from admissions a
join doctors d
on a.attending_doctor_id = d.doctor_id

group by doctor_id,
		 selected_year

order by doctor_id,
		 selected_year;
         
-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.         
         
SELECT 
		admission_date,
        count(admission_date) as admission_day,
        count(admission_date) - lag(count(admission_date)) over(order by admission_date) as admission_difference
from admissions
group by admission_date;

-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

select province_name
from province_names
order by
  (not province_name = 'Ontario'),
  province_name;

-- Invoices per Country
-- A business is analyzing data by country. For each country, display the country name, total number of invoices, and their average amount. 
-- Format the average as a floating-point number with 6 decimal places. 
-- Return only those countries where their average invoice amount is greater than the average invoice amount over all invoices.
  
SELECT 
    co.country_name, 
    COUNT(inv.invoice_number) AS total_invoices, 
    ROUND(AVG(inv.total_price), 6) AS avg_amount
FROM country co
JOIN city ci ON co.id = ci.country_id
JOIN customer cu ON ci.id = cu.city_id
JOIN invoice inv ON cu.id = inv.customer_id
GROUP BY co.country_name
HAVING AVG(inv.total_price) > (SELECT AVG(total_price) FROM invoice);

-- Show first name and last name of patients who does not have allergies. (null)

select
		first_name,
        last_name
from patients
where allergies is NULL;

-- Show first name of patients that start with the letter 'C'

select
		first_name
from patients
where first_name like "C%";

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

select
		first_name,
        last_name
from patients
where weight between 100 and 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

update patients
set allergies = 'NKA'
where allergies is null;

-- Show first name and last name concatinated into one column to show their full name.

select
		concat(first_name," ",last_name) as full_name
from patients;

-- Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'

select
		first_name,
        last_name,
        pn.province_name
from patients p
join province_names pn
on p.province_id = pn.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year.

select
		count(birth_date) as total_patients
from patients
where year(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.

select
		first_name,
        last_name,
        height
from patients
where (select
       		max(height)
       from patients)
order by height desc
limit 1;

-- Show all columns for patients who have one of the following patient_ids:
-- 1,45,534,879,1000

select *
from patients
where patient_id IN (1,45,534,879,1000);

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

select distinct (city) as unique_city
from patients
where province_id = 'NS';




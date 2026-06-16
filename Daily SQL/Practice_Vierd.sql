-- CREATE database employees;
-- USE employees;

-- -- create a table employees
-- CREATE TABLE employee(
-- emp_id INTEGER PRIMARY KEY,
-- emp_name TEXT,
-- dept_name TEXT,
-- salary REAL,
-- joining_date TEXT
-- );

-- -- add additional employee column use alter 
-- ALTER TABLE employee 
-- ADD COLUMN Eemail TEXT;

-- -- REMOVE the employee table
-- -- DROP table employee;
-- -- TRUNCATE table employees

-- SELECT * FROM employee;

-- ############################## DML ##############################
-- -- insert values in table --

-- INSERT INTO employee 
-- VALUES (001, 'Shiva', 'DA', 120000, '2020-01-26', 'shiva@gmail.com');

-- -- insert multiple values --
--  INSERT INTO employee 
-- VALUES (002,'Rahul','DS',130000,'2019-02-13','rk@gmail.com'),
-- (003,'Sudheer','DS',130000,'2019-02-13','sk@gmail.com'),
-- (005,'Akshaj','DA',130000,'2019-02-13','ak@gmail.com'),
-- (007,'Anvi','DS',300000,'2020-04-3','ank@gmail.com'),
-- (006,'Kanishk','IT',130000,'2006-02-01','kk@gmail.com'),
-- (009,'Manas','DS',130000,'2019-02-13','mk@gmail.com'),
-- (004,'Garv','DS',130000,'2019-02-13','gk@gmail.com')
-- ;

-- -- show the employee whose salary is less than 125000
-- SELECT * FROM employee
-- WHERE salary < 125000;

-- -- update sudheer salary to 135000
-- UPDATE employee
-- SET salary = 135000
-- WHERE emp_id = 3;

-- -- delete the record for someone from the table
-- DELETE FROM employee
-- WHERE emp_name = 'Manas';

-- SELECT * FROM employee;

-- Question 1 Reterive courses created in or after 2023-05-01

-- SELECT
-- course_id,
-- course_name,
-- created_at
-- FROM courses
-- WHERE created_at >= '2023-05-01'

-- Question 2 list all enrollment happned in month of may 2023. display enrollment_id, user_id, course_id, enrolled_at

-- SELECT 
-- enrollment_id,
-- user_id,
-- course_id,
-- enrolled_at
-- FROM enrollments
-- WHERE enrolled_at >= '2023-05-01' AND e.enrolled_at <= '2023-05-31'

-- OR 

-- SELECT 
-- e.enrollment_id,
-- e.user_id,
-- e.course_id,
-- e.enrolled_at
-- FROM enrollments e
-- WHERE e.enrolled_at >= '2023-05-01' AND e.enrolled_at < '2023-06-01'

-- Question 3 retrieve the submission_id of all the submissions having score greater than 92. Display submission_id,score

-- SELECT
-- submission_id,
-- score
-- FROM assessment_submission
-- WHERE score > 92

-- Question 4 list all assessments_type as quiz. Display assessment_id, assessment_name

-- SELECT
-- assessment_id,
-- assessment_name
-- FROM assessments
-- WHERE assessment_type = 'quiz'

-- Question 5 list all instructors name and email. Display first_name, email

-- SELECT first_name, email
-- FROM user
-- WHERE role = 'instructor'

-- Question 6 list name of users in teh database with last name starting with J. Display fist and last name

-- SELECT
-- first_name,
-- last_name
-- FROM user
-- WHERE last_name LIKE 'j%'

-- Question 7 list name of all users in the database whose first_name contain exactly 5 letter and last_name end with n. 
-- Display firstname and lastname.

-- SELECT 
-- first_name,
-- last_name
-- FROM user
-- WHERE LENGHT(first_name) = 5
-- AND last_name LIKE '%n'

-- Question 8 find the assessment with the lowest average score. Display assessmnet_name, avg_score
-- SELECT
-- assessment_name,
-- AVG(score) AS avg_score

-- FROM assessment
-- JOIN assessment_submission
-- ON assessment_submission.assessment_id = assessment.assessment_id
-- GROUP BY assessment_name
-- ORDER BY avg_score
-- LIMIT 1
 
-- Question 9 Show all modules with their course names in alphabatic order of course name and module_name. Display course_name, module_name
-- SELECT 
-- course_name,
-- module_name
-- FROM modules
-- JOIN courses
-- ON modules.course_id = courses.course_id
-- ORDER BY course_name, module_name

-- Question 10 Show all courses along with their categories. Display course_name, category_name
-- SELECT
-- course_name,
-- category_name
-- FROM categories
-- JOIN courses
-- ON courses.category_id = categories.category_id

-- Question 11 list courses with module and content for programming category and content type video. 
-- Display course_name, module_name, title, content_type

-- SELECT
-- course_name,
-- module_name,
-- title,
-- content_type
-- FROM categories
-- JOIN courses
-- ON courses.category_id = categories.category_id
-- JOIN modules
-- ON modules.course_id = courses.course_id
-- JOIN content
-- ON content.module_id = modules.module_id
-- WHERE content_type = 'video' AND category_name = 'programming'

-- Questi 12 list name of all users in database. Display first_name,last_name
-- SELECT 
-- first_name,
-- last_name
-- FROM user

-- Question 13 list courses with less than 3 enrollment. Display course_name, enrollment
-- SELECT
-- course_name,
-- COUNT(enrollment_id) AS enrollments
-- FROM courses
-- JOIN enrollments
-- ON courses.course_id = enrollment.course_id
-- WHERE course_name HAVING COUNT(enrollments) < 3

-- Question 14 count how many steudents are enrolled per user course. Display course_name, student_count
-- SELECT
-- c.course_name,
-- COUNT(e.enrollments) AS student_count
-- FROM courses c
-- LEFT JOIN enrollments e
-- ON c.course_id = e.course_id
-- GROUP BY c.course_id

-- Question 15 find the avg submission score per assessment score per assessment. 
-- Display assessment_id, assessmement_name, avg_score, max_score
-- SELECT 
-- a.assessment_id,
-- a.assessment_name,
-- AVG(s.score) AS avg_score,
-- a.max_score
-- FROM assesments a
-- LEFT JOIN assessment_submission s
-- ON s.assessment_id = a.assessment_id
-- GROUP BY a.assessment_id

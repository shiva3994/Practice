/* Create new table called person with columns: id, person_name, birth_date and phone*/

CREATE TABLE person (
		id INT NOT NULL,
        person_name	VARCHAR(50) NOT NULL,
        birth_date DATE,
        phone VARCHAR(15) NOT NULL,
        CONSTRAINT pk_persons PRIMARY KEY (id)
        );

SELECT * FROM person;

-- Add new column called email to the persons table

ALTER TABLE person
ADD email VARCHAR(50) NOT NULL;

SELECT * FROM person; 

-- Remoove the column phone from the person table

ALTER TABLE person
DROP COLUMN phone;

SELECT * FROM person;

-- Delete table person from the database

DROP TABLE person;

-- Insert data for existing table 

SELECT * FROM customers;

INSERT INTO customers(id,first_name,country,score)
VALUES  (6,'Anna','USA',NULL),
		(7,'Sam',NULL,100);
        
-- Insert data from customers into person

INSERT INTO person (id, person_name, birth_date, phone) -- format new table
SELECT -- rows in old table
		ID,
		first_name,
		NULL,
		'Unknown'
FROM customers;

SELECT * FROM person;

-- Change customer no 6 score to 0

UPDATE customers
SET score = 0
WHERE id = 6;

SELECT * FROM customers;

-- Change customer no 6 score to 0 and country UK

UPDATE customers
SET 
	score = 0,
	country = 'UK'
WHERE id = 6;

SELECT * FROM customers;

-- Change customer no 7 score to 10 and country India

UPDATE customers
SET score = 10,
	country = 'India'
WHERE id = 7;

SELECT * FROM customers;




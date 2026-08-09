CREATE TABLE employee(
						employee_id SERIAL PRIMARY KEY,
						name VARCHAR(100) NOT NULL,
						position VARCHAR(100),
						department VARCHAR(50),
						hiring_date DATE,
						salary NUMERIC(10,2)
);

SELCT 
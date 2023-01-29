SELECT *
FROM customer;

--adding a column to table
ALTER TABLE customer
ADD phone_number VARCHAR(15);

ALTER TABLE order_
ADD order_quantity INTEGER,
ADD staff_first VARCHAR(50),
ADD staff_last VARCHAR(100),
ADD price INTEGER;

SELECT *
FROM order_;

--changing the type of a column
ALTER TABLE order_
ALTER COLUMN price TYPE NUMERIC(8,2);

--rename column
-- ALTER TABLE
-- RENAME COLUMN cost_of_product TO price;

--updating existing data
UPDATE customer
SET phone_number = '773-202-LUNA'
WHERE first_name = 'George' AND last_name = 'Washington';

SELECT *
FROM customer;

UPDATE customer
SET email = 'iprobablysucked@us.gov'
WHERE customer_id = 3;

--update existing data in order_
UPDATE order_
SET order_quantity = 4,
staff_first = 'Rod',
staff_last = 'Kimble',
price = 250.00
WHERE order_id = 1;

SELECT *
FROM customer;

SELECT *
FROM order_;

UPDATE order_
SET order_quantity = 5,
staff_first = 'Kevin',
staff_last = 'Kimble',
price = amount * order_quantity,
WHERE order_id = 3;

SELECT *
FROM order_;

CREATE TABLE staff(
	staff_name SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100)
);

ALTER TABLE staff
DROP COLUMN email;

ALTER TABLE staff
DROP COLUMN staff_id CASCADE; --remove dependencies associated with that column in other tables

DROP TABLE staff CASCADE;



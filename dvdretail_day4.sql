--check out data inside of payment
SELECT *
FROM payment;

--stored procedure
--simu;;ate a late fee charge

CREATE OR REPLACE PROCEDURE lateFEE(
	customer_late INTEGER,--customer_id
	payment_late INTEGER,--payment_id
	lateFeeAmount DECIMAL(4,2)--amount for late fee
)
LANGUAGE plpgsql
AS $$ --body of procedure, using literal sting quoting to store procedure
BEGIN
	--add a late fee to customer payment amount
	UPDATE payment
	SET amount = amount + lateFeeAmount
	WHERE customer_id = customer_late AND payment_id = payment_late;
	
	--commit the able statement inside of the transaction
	COMMIT;
END;
$$

--DROP PROCEDURE lateFee;

--procedure are stored in the left column inside of schemas

--calling a store procedure
CALL lateFee(341, 17503, 5.00);

SELECT *
FROM payment
WHERE payment_id = 17503;


SELECT *
FROM rental;

ALTER TABLE rental
ADD COLUMN renturn_interval INTERVAL;

UPDATE rental
SET renturn_interval = return_date - rental_date;

SELECT *
FROM rental
WHERE return_date IS NULL;

ALTER TABLE rental
DROP COLUMN renturn_interval;

--add a return column that will track the amount of days a customer had a rental
ALTER TABLE rental
ADD COLUMN rental_duration INTERVAL;

--check that column was successfully added
SELECT *
FROM rental;

CREATE OR REPLACE PROCEDURE days_rented(
	right_now TIMESTAMP WITHOUT TIME ZONE
)
LANGUAGE plpgsql
AS $$
BEGIN
	--populate rental_duration column with an interval
	UPDATE rental
	SET rental_duration = return_date - rental_date
	WHERE return_date IS NOT NULL;
	
	UPDATE rental
	SET rental_duration = right_now - rental_date
	WHERE return_date IS NULL;
	
	COMMIT;
END;
$$

--DROP PROCEDURE days_rented;

CALL days_rented();


--stored function examples
--stored function to insert data into actor table
CREATE OR REPLACE FUNCTION add_actor(
	_actor_id INTEGER,
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_last_update TIMESTAMP WITHOUT TIME ZONE
)
RETURNS void --can return data time but in this case we're just inserting into a table
AS $MAIN$ --naming the string literal that is called with the function
BEGIN
	INSERT INTO actor
	VALUES (_actor_id, _first_name, _last_name, _last_update);
END;
$MAIN$
LANGUAGE plpgsql;

--calling a stored function
--bad wrong badong way to call a function
--CALL add_actor(arguments) <--NO!

--super cool way to call a function
SELECT add_actor(201, 'Orlando', 'Bloom', NOW()::timestamp);

SELECT *
FROM actor
WHERE actor_id = 201;

--function to return the sum of payments from all rentals
CREATE FUNCTION get_total_rentals()
RETURNS INTEGER
AS $$
	BEGIN
		RETURN (SELECT SUM(amount) FROM payment);
	END;
$$
LANGUAGE plpgsql;

DROP FUNCTION get_total_rentals();

SELECT get_total_rentals();

CREATE OR REPLACE FUNCTION add_actor2(--as long as there is not a not NULL constraint on the column
	_actor_id INTEGER,
	_first_name VARCHAR(50),

)
RETURNS void --can return data time but in this case we're just inserting into a table
AS $MAIN$ --naming the string literal that is called with the function
BEGIN
	INSERT INTO actor
	VALUES (_actor_id, _first_name,);
END;
$MAIN$
LANGUAGE plpgsql;

--can call a function inside of a procedure but cannot call a procedure inside a function

CREATE FUNCTION get_discount(price NUMERIC, percentage INTEGER)
RETURNS INTEGER
AS $$
    BEGIN
        RETURN (price * percentage/100);
    END;
$$ LANGUAGE plpgsql;


CREATE PROCEDURE apply_discount(percentage INTEGER, _payment_id INTEGER)
AS $$
    BEGIN
        UPDATE payment
        SET amount = get_discount(payment.amount, percentage)
        WHERE payment_id = _payment_id;
    END;
$$ LANGUAGE plpgsql;

SELECT *
FROM payment;

CALL apply_discount(75, 17505);
SELECT *
FROM payment
WHERE payment_id = 17505;
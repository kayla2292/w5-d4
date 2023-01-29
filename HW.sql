UPDATE rental
SET rental_duration = return_date - rental_date;

CREATE OR REPLACE PROCEDURE lateFEE(
	lateFeeAmount DECIMAL(4,2)--amount for late fee
)
LANGUAGE plpgsql
AS $$ --body of procedure, using literal sting quoting to store procedure
BEGIN
	--add a late fee to customer payment amount
	UPDATE payment
	SET amount = amount + lateFeeAmount
	WHERE rental_duration > 7;

	--commit the able statement inside of the transaction
	COMMIT;
END;
$$

CALL lateFEE(5.00);



ALTER TABLE customer
ADD COLUMN platinum_member BOOLEAN;

CREATE OR REPLACE PROCEDURE platinum(
	spent NUMERIC(6,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	--populate rental_duration column with an interval
	UPDATE customer
	SET  spent = SUM(amount) AND platinum_member = plat_mem
	WHERE spent >= 200 = plat_mem TRUE;
	
	UPDATE customer
	SET  spent = SUM(amount) AND platinum_member = plat_mem
	WHERE spent < 200 = plat_mem False;
	
	COMMIT;
END;
$$




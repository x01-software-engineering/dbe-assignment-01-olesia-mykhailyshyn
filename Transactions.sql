-- PROCEDURES FOR TRANSACTION 

-- procedure for checking employee availability
DROP PROCEDURE IF EXISTS CheckEmployeeAvailability;
CREATE PROCEDURE CheckEmployeeAvailability(
    IN employee_id INT,
    OUT is_available BOOLEAN
)
BEGIN
    DECLARE available_count INT;

    -- checking if the employee has any appointments
    SELECT COUNT(1)
    INTO available_count
    FROM appointment
    WHERE employee_id = employee_id
      AND status = 'Confirmed';

    IF available_count = 0 THEN
        SET is_available = TRUE;
    ELSE
        SET is_available = FALSE;
    END IF;
END;

-- procedure for scheduling a service
DROP PROCEDURE IF EXISTS ScheduleService;
CREATE PROCEDURE ScheduleService(
    IN customer_name TEXT,
    IN service_name TEXT,
    IN employee_name TEXT,
    IN date DATE,
    IN time TIME,
    OUT message TEXT
)
BEGIN
    DECLARE customer_id INT;
    DECLARE service_id INT;
    DECLARE employee_id INT;
    DECLARE available BOOLEAN;

    -- check if the customer exists, and if not, add them
    SELECT customer.customer_id INTO customer_id FROM customer WHERE name = customer_name LIMIT 1;
    IF customer_id IS NULL THEN
        -- if the customer does not exist, add them to the database
        INSERT INTO customer (name) VALUES (customer_name);
        SELECT LAST_INSERT_ID() INTO customer_id; -- LAST_INSERT_ID() --> get the auto-generated customer_id
    END IF;

    SELECT service.service_id INTO service_id FROM service WHERE name = service_name LIMIT 1;
    SELECT employee.employee_id INTO employee_id FROM employee WHERE name = employee_name LIMIT 1;


    START TRANSACTION;
    CALL CheckEmployeeAvailability(employee_id, available);
    IF NOT available THEN
        SET message = 'Employee is already booked for another service.';
        ROLLBACK;
    ELSE
        INSERT INTO appointment (customer_id, service_id, employee_id, date, time, status)
        VALUES (customer_id, service_id, employee_id, date, time, 'Confirmed');
        SET message = 'Service scheduled successfully.';
        COMMIT;
    END IF;
END;

-- procedure for adding a new customer
DROP PROCEDURE IF EXISTS NewCustomer;
CREATE PROCEDURE NewCustomer(
    IN customer_name TEXT,
    IN customer_email TEXT,
    IN customer_phone BIGINT,
    OUT message TEXT
)
BEGIN
    DECLARE customer_id INT;

    -- check if the customer already exists
    SELECT customer_id INTO customer_id FROM customer WHERE name = customer_name LIMIT 1;

    START TRANSACTION;
    IF customer_id IS NULL THEN
        INSERT INTO customer (name, email, phone_number)
        VALUES (customer_name, customer_email, customer_phone);
        SET message = 'Customer added successfully.';
    ELSE
        SET message = 'Customer already exists.';
        ROLLBACK;
    END IF;
    COMMIT;
END;


-- testing the transaction procedure
CALL NewCustomer('Tobias Eaton', 'customer66@example.com', '1234567890', @message);
SELECT @message;
CALL ScheduleService('Tobias Eaton', 'Haircut', 'Alice Johnson', '2024-02-25', '10:00:00', @message);
SELECT @message;


-- QUERY FOR GETTING APPOINTMENT DETAILS
SELECT a.employee_id,
       e.name AS employee_name,
       c.name AS customer_name
FROM appointment a
         JOIN
     employee e ON a.employee_id = e.employee_id
         JOIN
     customer c ON a.customer_id = c.customer_id
WHERE a.employee_id IN (SELECT employee_id FROM employee WHERE name = 'Alice Johnson')
  AND a.date = '2024-02-25'
  AND a.time = '10:00:00';
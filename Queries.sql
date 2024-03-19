-- SELECT queries:

-- = with non-correlated
-- Find employees with the position "Stylist" and a salary of at least 3000.00 
-- who provide services with a duration of 60 minutes
SELECT e.*
FROM employee e
WHERE e.position = 'Stylist'
  AND e.salary >= 3000.00
  AND e.employee_id IN (SELECT es.employee_id
                        FROM employee_service es
                                 INNER JOIN service s ON es.service_id = s.service_id
                        WHERE s.duration = 60);

-- IN with non-correlated
-- Services contained in records of confirmed service appointments
SELECT s.*
FROM service s
WHERE s.service_id IN (SELECT DISTINCT service_id
                       FROM appointment
                       WHERE status = 'Confirmed'
                         AND service_id IN (SELECT service_id
                                            FROM appointment
                                            WHERE status = 'Confirmed'));

-- NOT IN with non-correlated
-- Services not contained in records of confirmed service appointments
SELECT s.*
FROM service s
WHERE s.service_id NOT IN (SELECT service_id
                           FROM appointment
                           WHERE status = 'Confirmed'
                             AND service_id IN (SELECT service_id
                                                FROM appointment
                                                WHERE status = 'Confirmed'));

-- EXISTS with non-correlated 
-- Employees with a salary of at least 3000.00 who provide services with a duration of 60 minutes
SELECT e.name, e.position, e.salary
FROM employee e
WHERE e.salary >= 3000.00
  AND EXISTS (SELECT *
              FROM service
              WHERE duration = 60);

-- NOT EXISTS with non-correlated
-- Employees who do not have confirmed service appointments
SELECT e.name, e.position, e.salary
FROM employee e
WHERE NOT EXISTS (SELECT *
                  FROM appointment a
                           JOIN service s ON a.service_id = s.service_id
                  WHERE a.status = 'Confirmed');

-- = with correlated 
-- retrieve services that have appointments confirmed with the same service and employee
SELECT *
FROM service s
WHERE s.service_id = (SELECT a.service_id
                      FROM appointment a
                      WHERE a.service_id = s.service_id
                        AND a.employee_id = s.service_id
                        AND a.status = 'Confirmed');

-- IN with correlated
-- retrieve services where at least one appointment is confirmed with the same employee
SELECT *
FROM service s
WHERE s.service_id IN (SELECT a.service_id
                       FROM appointment a
                       WHERE a.employee_id = s.service_id
                         AND a.status = 'Confirmed');

-- NOT IN with correlated
-- retrieve services where no appointments are confirmed with the same employee
SELECT *
FROM service s
WHERE s.service_id NOT IN (SELECT a.service_id
                           FROM appointment a
                           WHERE a.employee_id = s.service_id
                             AND a.status = 'Confirmed');

-- EXISTS with correlated
-- retrieve services with confirmed appointments by the same employee and current or future date
SELECT *
FROM service s
WHERE EXISTS (SELECT *
              FROM appointment a
              WHERE a.service_id = s.service_id
                AND a.employee_id = s.service_id
                AND a.status = 'Confirmed'
                AND a.date >= CURRENT_DATE());

-- NOT EXISTS with correlated
-- retrieve services without confirmed appointments by the same employee and current or future date
SELECT *
FROM service s
WHERE NOT EXISTS (SELECT *
                  FROM appointment a
                  WHERE a.service_id = s.service_id
                    AND a.employee_id = s.service_id
                    AND a.status = 'Confirmed'
                    AND a.date >= CURRENT_DATE());

-- UPDATE queries:

-- = with non-correlated
-- Update query setting the price of services based on the maximum confirmed appointment price
UPDATE service
SET price = 40.00
WHERE service_id = (SELECT a.service_id
                    FROM appointment a
                    WHERE a.appointment_id = (SELECT MAX(appointment_id)
                                              FROM appointment
                                              WHERE status = 'Confirmed'));

-- IN with non-correlated
-- -- Update query setting the price of services based on the average price of confirmed appointments
UPDATE service
SET price = 40.00
WHERE service_id IN (SELECT DISTINCT service_id
                     FROM appointment
                     WHERE status = 'Confirmed'
                       AND service_id IN (SELECT service_id
                                          FROM appointment
                                          WHERE status = 'Confirmed'));

-- NOT IN with non-correlated
-- Update query setting the price of services based on a condition related to appointment status and price
UPDATE service
SET price = 40.00
WHERE service_id NOT IN (SELECT service_id
                         FROM appointment
                         WHERE status = 'Confirmed'
                           AND service_id IN (SELECT service_id
                                              FROM appointment
                                              WHERE status = 'Confirmed'));

-- EXISTS with non-correlated
-- Update query adjusting the salary of employees based on their position and the existence of appointments
UPDATE employee
SET salary = salary * 1.1
WHERE EXISTS (SELECT *
              FROM appointment
              WHERE appointment.employee_id = employee.employee_id)
  AND position = 'Stylist';

-- NOT EXISTS with non-correlated 
-- Update query changing the position of employees to 'Senior Stylist' based on their salary and lack of confirmed appointments
UPDATE employee
SET position = 'Senior Stylist'
WHERE salary > 3500
  AND NOT EXISTS (SELECT *
                  FROM appointment
                  WHERE appointment.employee_id = employee.employee_id
                    AND appointment.status = 'Confirmed');

-- = with correlated
-- Update query setting the price of services based on a condition related to appointment status and price
UPDATE service s
SET price = 40.00
WHERE s.service_id = (SELECT a.service_id
                      FROM appointment a
                      WHERE a.employee_id = s.service_id
                        AND a.status = 'Not Confirmed');

-- IN with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 40.00
WHERE s.service_id IN (SELECT service_id
                       FROM appointment
                       WHERE employee_id = s.service_id
                         AND status = 'Confirmed');

-- NOT IN with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 100.00
WHERE s.service_id NOT IN (SELECT service_id
                           FROM appointment
                           WHERE employee_id = s.service_id
                             AND status = 'Confirmed');

-- EXISTS with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 40.00
WHERE EXISTS (SELECT *
              FROM appointment
              WHERE employee_id = s.service_id
                AND status = 'Confirmed');

-- NOT EXISTS with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 50.00
WHERE NOT EXISTS (SELECT *
                  FROM appointment
                  WHERE employee_id = s.service_id
                    AND status = 'Not Confirmed');

-- DELETE queries:

-- = with non-correlated
-- Deletes appointments where the service ID matches the minimum service ID for the 'Haircut' service
DELETE
FROM appointment
WHERE service_id = (SELECT MIN(service_id)
                    FROM service
                    WHERE name = 'Haircut');

-- IN with non-correlated
-- Deletes appointments where the service ID matches the average price of services being greater than 50
DELETE
FROM appointment
WHERE service_id IN (SELECT service_id
                     FROM service
                     GROUP BY service_id
                     HAVING AVG(price) > 50.00);

-- NOT IN with non-correlated
-- Deletes appointments where the service ID does not match the criteria specified in the subquery,
-- and the customer ID matches certain payment methods
DELETE
FROM appointment
WHERE service_id NOT IN (SELECT service_id
                         FROM service
                         WHERE duration = 60
                            OR price = 30.00)
  AND customer_id IN (SELECT DISTINCT customer_id
                      FROM payment
                      WHERE method = 'Credit Card')
  AND customer_id IN (SELECT DISTINCT customer_id
                      FROM payment
                      WHERE method = 'Cash');

-- EXISTS with non-correlated
-- Selects employee names and positions where appointments exist for them with status 'Confirmed'
SELECT e.name, e.position
FROM employee e
WHERE EXISTS (SELECT *
              FROM appointment a
              WHERE a.employee_id = e.employee_id
                AND a.status = 'Confirmed');


-- NOT EXISTS with non-correlated
-- Deletes employees with the position 'Stylist' who have no appointments with status 'Confirmed'
DELETE
FROM employee
WHERE position = 'Stylist'
  AND NOT EXISTS (SELECT *
                  FROM appointment a
                  WHERE a.employee_id = employee.employee_id
                    AND a.status = 'Confirmed');

-- = with correlated
-- Deletes appointments where the service ID matches a service with a price of 30.00
DELETE
FROM appointment
WHERE service_id = (SELECT service_id
                    FROM service
                    WHERE price = 30.00
                      AND service_id = appointment.service_id
                    ORDER BY service_id
                    LIMIT 1);

-- IN with correlated
-- Deletes services where the service ID matches appointments with status 'Confirmed'
-- and those appointments are paid with the 'Cash' method
DELETE
FROM service
WHERE service_id IN (SELECT DISTINCT service_id
                     FROM appointment
                     WHERE status = 'Confirmed'
                       AND service_id IN (SELECT DISTINCT service_id
                                          FROM appointment_employee ae
                                          WHERE ae.appointment_id IN (SELECT DISTINCT appointment_id
                                                                      FROM payment
                                                                      WHERE method = 'Cash')));


-- NOT IN with correlated
-- Delete appointments where the service ID does not correspond to services associated with stylists
DELETE
FROM appointment a
WHERE a.service_id NOT IN (SELECT DISTINCT service_id
                           FROM appointment_employee ae
                                    INNER JOIN employee e ON ae.employee_id = e.employee_id
                           WHERE e.position = 'Stylist');

-- EXISTS with correlated
-- Deletes appointments where the service duration exceeds the average duration of all services
DELETE
FROM appointment
WHERE EXISTS (SELECT *
              FROM service s
              WHERE s.service_id = appointment.service_id
                AND s.duration > (SELECT AVG(duration)
                                  FROM service));

-- NOT EXISTS with correlated
-- Deletes appointments where there are no payments made with the 'Cash' method for the corresponding customer
DELETE
FROM appointment AS a
WHERE NOT EXISTS (SELECT *
                  FROM payment AS p
                  WHERE p.customer_id = a.customer_id
                    AND p.method = 'Cash');


--  Four SELECT queries that include the clause UNION / UNION ALL / INTERSECT / EXCEPT

-- Retrieves services with a price greater than 50,
-- and products associated with services having a price greater than 20.
-- It combines results from both tables, removing duplicates.
(SELECT s.service_id, s.name, s.price
 FROM service s
 WHERE s.price > 50)
UNION
(SELECT p.service_id, p.name, p.price
 FROM product p
          JOIN service_product sp ON p.service_id = sp.service_id
 WHERE p.price > 20);

-- Retrieves services with a price greater than 50,
-- and products associated with services having a price greater than 20.
-- It includes all rows from both tables, including duplicates.
(SELECT s.service_id, s.name, s.price
 FROM service s
 WHERE s.price > 50)
UNION ALL
(SELECT p.service_id, p.name, p.price
 FROM product p
          JOIN service_product sp ON p.service_id = sp.service_id
 WHERE p.price > 20
   AND p.quantity > 0);

-- Retrieves services with a price greater than 50
-- that intersect with products associated with services having a price greater than 20.
-- It returns only rows that appear in both result sets.
(SELECT s.service_id, s.name, s.price
 FROM service s
 WHERE s.price > 50)
INTERSECT
(SELECT p.service_id, p.name, p.price
 FROM product p
          JOIN service_product sp ON p.service_id = sp.service_id
 WHERE p.price > 20);

-- Retrieves services with a price greater than 50
-- that do not have corresponding products with a price less than 30.
-- It returns rows from the first set that are not found in the second set.
(SELECT s.service_id, s.name, s.price
 FROM service s
 WHERE s.price > 50)
EXCEPT
(SELECT p.service_id, p.name, p.price
 FROM product p
          JOIN service_product sp ON p.service_id = sp.service_id
 WHERE p.price < 30);
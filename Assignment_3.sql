CREATE DATABASE IF NOT EXISTS beauty_salon_department;
USE beauty_salon_department;

CREATE TABLE service
(
    service_id  INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(256) NOT NULL,
    description VARCHAR(256),
    duration    INT,
    price       INT          NOT NULL
);

CREATE TABLE product
(
    product_id  INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    service_id  INT          NOT NULL,
    name        VARCHAR(256) NOT NULL,
    description VARCHAR(256),
    quantity    INT,
    price       INT          NOT NULL,
    FOREIGN KEY (service_id) REFERENCES service (service_id) ON DELETE CASCADE
);

CREATE TABLE customer
(
    customer_id  INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(256) NOT NULL,
    phone_number VARCHAR(32)  NOT NULL,
    email        VARCHAR(256),
    address      VARCHAR(256)
);

CREATE TABLE employee
(
    employee_id  INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(256) NOT NULL,
    phone_number VARCHAR(32)  NOT NULL,
    email        VARCHAR(256) NOT NULL,
    position     VARCHAR(256) NOT NULL,
    salary       INT          NOT NULL
);

-- In Appointment table one-to-many relationship with the Payment table is created using primary and foreign keys:
CREATE TABLE appointment
(
    appointment_id INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id    INT  NOT NULL,
    service_id     INT  NOT NULL,
    employee_id    INT  NOT NULL,
    date           DATE NOT NULL,
    time           TIME,
    status         VARCHAR(256),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES service (service_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id) ON DELETE CASCADE
);

CREATE TABLE payment
(
    payment_id     INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT          NOT NULL,
    customer_id    INT          NOT NULL,
    amount         INT          NOT NULL,
    method         VARCHAR(256) NOT NULL,
    date           DATE         NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id) ON DELETE CASCADE
);

-- Create a many-to-many relationship between Services and Products:
CREATE TABLE service_product
(
    service_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (service_id, product_id),
    FOREIGN KEY (service_id) REFERENCES service (service_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
);

-- Create a many-to-many relationship between Employees and Services:
CREATE TABLE employee_service
(
    employee_id INT NOT NULL,
    service_id  INT NOT NULL,
    PRIMARY KEY (employee_id, service_id),
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES service (service_id) ON DELETE CASCADE
);

-- Create a many-to-many relationship between Appointments and Employees:
CREATE TABLE appointment_employee
(
    appointment_id INT NOT NULL,
    employee_id    INT NOT NULL,
    PRIMARY KEY (appointment_id, employee_id),
    FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id) ON DELETE CASCADE
);

INSERT INTO service (name, description, duration, price)
VALUES ('Haircut', 'Trimming and styling hair', 60, 30.00),
       ('Manicure', 'Nail care and polish', 45, 25.00),
       ('Massage', 'Body relaxation therapy', 90, 60.00),
       ('Pedicure', 'Foot care and polish', 60, 35.00),
       ('Waxing', 'Hair removal using wax', 45, 40.00),
       ('Facial', 'Skin care and treatment', 60, 50.00),
       ('Makeup', 'Cosmetic application', 30, 40.00),
       ('Hair Coloring', 'Professional hair coloring service', 90, 50.00),
       ('Eyebrow Threading', 'Precision eyebrow shaping using threading technique', 15, 20.00),
       ('Hair Extensions', 'Adding length or volume to hair using extensions', 120, 80.00),
       ('Hair Straightening', 'Chemical hair straightening treatment', 120, 70.00),
       ('Hair Styling', 'Professional hair styling for special occasions', 60, 40.00),
       ('Hair Treatment', 'Hair care and treatment for damaged hair', 45, 35.00),
       ('Hair Wash', 'Hair washing and conditioning service', 30, 20.00),
       ('Haircut', 'Trimming and styling hair', 60, 30.00),
       ('Makeup', 'Cosmetic application', 30, 40.00),
       ('Eyelash Extensions', 'Enhance the length, curliness, fullness, and thickness of natural eyelashes', 90, 70.00),
       ('Body Scrub', 'Exfoliation treatment to remove dead skin cells and rejuvenate the skin', 60, 45.00),
       ('Hair Straightening', 'Professional treatment to make curly or wavy hair straight and sleek', 120, 80.00),
       ('Nail Art', 'Creative nail designs and decorations applied on manicured nails', 30, 25.00),
       ('Deep Tissue Massage', 'Intense massage technique focused on releasing muscle tension and knots', 60, 70.00),
       ('Hot Stone Massage', 'Massage therapy using heated stones to relax muscles and improve circulation', 75, 65.00),
       ('HydraFacial', 'Hydrating facial treatment that cleanses, exfoliates, and hydrates the skin', 45, 55.00),
       ('Laser Hair Removal', 'Permanent hair removal using laser technology', 60, 100.00),
       ('Microblading', 'Semi-permanent eyebrow tattooing technique', 90, 90.00),
       ('Eyebrow Threading', 'Precision eyebrow shaping using threading technique', 15, 20.00),
       ('Hair Extensions', 'Adding length or volume to hair using extensions', 120, 80.00),
       ('Eyelash Extensions', 'Enhance the length, curliness, fullness, and thickness of natural eyelashes', 90, 70.00),
       ('Body Scrub', 'Exfoliation treatment to remove dead skin cells and rejuvenate the skin', 60, 45.00),
       ('Hair Straightening', 'Professional treatment to make curly or wavy hair straight and sleek', 120, 80.00),
       ('Nail Art', 'Creative nail designs and decorations applied on manicured nails', 30, 25.00),
       ('Deep Tissue Massage', 'Intense massage technique focused on releasing muscle tension and knots', 60, 70.00),
       ('Hot Stone Massage', 'Massage therapy using heated stones to relax muscles and improve circulation', 75, 65.00),
       ('HydraFacial', 'Hydrating facial treatment that cleanses, exfoliates, and hydrates the skin', 45, 55.00),
       ('Aromatherapy Massage', 'Massage using essential oils to promote relaxation and well-being', 60, 60.00),
       ('Prenatal Massage', 'Gentle massage for expectant mothers to relieve pregnancy-related discomfort', 60, 65.00),
       ('Brazilian Waxing', 'Hair removal from the bikini area using warm wax', 30, 40.00),
       ('Microdermabrasion', 'Skin exfoliation technique to improve skin tone and texture', 45, 75.00),
       ('Gel Manicure', 'Manicure with long-lasting gel polish', 60, 35.00),
       ('Spray Tanning', 'Safe and sunless tanning method using a spray solution', 30, 50.00),
       ('Ear Piercing', 'Professional ear piercing using sterile techniques', 15, 25.00),
       ('Reflexology', 'Massage technique involving applying pressure to specific points on the feet', 45, 55.00),
       ('Keratin Treatment', 'Hair treatment to smooth and straighten frizzy or curly hair', 90, 100.00),
       ('Teeth Whitening', 'Professional treatment to lighten and brighten teeth', 60, 120.00),
       ('Couples Massage', 'Massage therapy for two people performed in the same room', 60, 130.00),
       ('Henna Tattoo', 'Temporary tattoo using natural henna dye', 30, 35.00),
       ('Balayage', 'Hair coloring technique for natural-looking highlights', 120, 90.00),
       ('Eyebrow Tinting', 'Coloring or darkening the eyebrows using a semi-permanent dye', 15, 20.00),
       ('Thai Massage', 'Ancient healing system combining acupressure and assisted yoga postures', 90, 75.00),
       ('Chemical Peel', 'Skin treatment to improve skin texture and reduce blemishes', 45, 85.00),
       ('Paraffin Wax Treatment', 'Moisturizing treatment for hands and feet using warm paraffin wax', 30, 40.00),
       ('Permanent Makeup', 'Cosmetic tattooing for permanent eyebrows, eyeliner, or lip color', 120, 200.00),
       ('Bridal Makeup', 'Professional makeup application for brides on their wedding day', 60, 150.00),
       ('Scalp Massage', 'Massage focused on the scalp to relieve tension and promote relaxation', 30, 35.00),
       ('Foot Reflexology', 'Massage technique focusing on reflex points in the feet to improve overall health', 45,
        50.00),
       ('Threading and Waxing Combo', 'Eyebrow shaping and facial hair removal using threading and waxing', 45, 40.00),
       ('Collagen Facial', 'Facial treatment to boost collagen production and improve skin elasticity', 60, 70.00),
       ('Microblading', 'Semi-permanent makeup technique for natural-looking eyebrow enhancement', 120, 250.00),
       ('Lash Lift and Tint', 'Treatment to lift and tint natural eyelashes for a longer and darker appearance', 60,
        60.00),
       ('Gentlemen''s Facial', 'Tailored facial treatment designed for men''s skin needs', 45, 50.00),
       ('Dermaplaning', 'Exfoliation technique to remove dead skin cells and fine facial hair', 30, 55.00),
       ('Caviar Facial', 'Luxurious facial treatment using caviar extracts for skin nourishment', 60, 80.00),
       ('Shiatsu Massage', 'Japanese massage technique using finger pressure to promote relaxation and balance', 60,
        65.00),
       ('Lymphatic Drainage Massage',
        'Gentle massage technique to stimulate the lymphatic system and detoxify the body', 75, 80.00),
       ('Ombre Hair Coloring', 'Hair coloring technique blending two or more colors for a gradient effect', 120, 95.00),
       ('Maternity Massage', 'Gentle massage therapy for pregnant women to relieve discomfort and promote relaxation',
        60, 70.00),
       ('Dermapen Microneedling',
        'Skin rejuvenation treatment using microneedling technology to improve skin texture and tone', 60, 120.00),
       ('Sports Massage', 'Massage therapy tailored to athletes to enhance performance and prevent injuries', 60,
        75.00),
       ('Silk Press', 'Hair straightening technique for natural hair using a flat iron for smooth and shiny results',
        90, 60.00),
       ('Hyaluronic Acid Facial', 'Facial treatment using hyaluronic acid to hydrate and plump the skin', 45, 65.00),
       ('Russian Volume Lashes', 'Eyelash extension technique to create fuller and more voluminous lashes', 120, 90.00),
       ('LED Light Therapy', 'Skin treatment using LED lights to address various skin concerns such as acne and aging',
        30, 50.00);

INSERT INTO product (service_id, name, description, quantity, price)
VALUES (1, 'Shampoo', 'Hair cleaning product', 50, 15.00),
       (2, 'Nail Polish', 'Variety of nail colors', 100, 10.00),
       (3, 'Massage Oil', 'Oil for massage therapy', 20, 20.00),
       (4, 'Foot Cream', 'Moisturizing foot cream', 30, 12.00),
       (5, 'Wax Strips', 'Strips for hair removal', 40, 25.00),
       (6, 'Face Mask', 'Skin care product', 60, 30.00),
       (7, 'Lipstick', 'Cosmetic product', 80, 18.00),
       (7, 'Foundation', 'Cosmetic product', 70, 25.00),
       (7, 'Eyeliner', 'Cosmetic product', 90, 15.00),
       (7, 'Mascara', 'Cosmetic product', 100, 20.00);

INSERT INTO employee (name, phone_number, email, position, salary)
VALUES ('Alice Johnson', '11123333', 'alice@example.com', 'Stylist', 3000.00),
       ('Bob Smith', '44455566', 'bob@example.com', 'Massage Therapist', 3500.00),
       ('David Miller', '67778888', 'david@example.com', 'Stylist', 3200.00),
       ('Emma White', '89990000', 'emma@example.com', 'Manicurist', 2800.00),
       ('James Taylor', '90001111', 'james@example.com', 'Massage Therapist', 3700.00),
       ('Sarah Brown', '12345678', 'sarah@example.com', 'Esthetician', 2900.00),
       ('John Doe', '23456789', 'john@example.com', 'Barber', 3100.00),
       ('Emily Wilson', '34567890', 'emily@example.com', 'Manicurist', 2800.00),
       ('Michael Clark', '45678901', 'michael@example.com', 'Stylist', 3000.00),
       ('Jennifer Lee', '56789012', 'jennifer@example.com', 'Massage Therapist', 3500.00),
       ('Daniel Brown', '67890123', 'daniel@example.com', 'Esthetician', 2900.00),
       ('Jessica Davis', '78901234', 'jessica@example.com', 'Barber', 3100.00),
       ('Lames Wilson', '89012345', 'james@example.com', 'Manicurist', 2800.00),
       ('Michelle Garcia', '90123456', 'michelle@example.com', 'Stylist', 3000.00),
       ('William Johnson', '01234567', 'william@example.com', 'Massage Therapist', 3500.00),
       ('Amanda Smith', '13579024', 'amanda@example.com', 'Esthetician', 2900.00),
       ('Christopher Taylor', '24680135', 'christopher@example.com', 'Barber', 3100.00),
       ('Nicole Brown', '35791246', 'nicole@example.com', 'Manicurist', 2800.00),
       ('Ryan Martinez', '46802357', 'ryan@example.com', 'Stylist', 3000.00),
       ('Stephanie Anderson', '57913468', 'stephanie@example.com', 'Massage Therapist', 3500.00),
       ('Kevin Wilson', '68012453', 'kevin@example.com', 'Esthetician', 2900.00),
       ('Melissa Thompson', '79123564', 'melissa@example.com', 'Barber', 3100.00),
       ('Brian Roberts', '80234675', 'brian@example.com', 'Manicurist', 2800.00),
       ('Samantha Harris', '91345786', 'samantha@example.com', 'Stylist', 3000.00),
       ('Tyler Turner', '02456897', 'tyler@example.com', 'Massage Therapist', 3500.00),
       ('Rachel Jackson', '13567980', 'rachel@example.com', 'Esthetician', 2900.00),
       ('Jason Davis', '24679012', 'jason@example.com', 'Barber', 3100.00),
       ('Laura Garcia', '35780123', 'laura@example.com', 'Manicurist', 2800.00),
       ('Brandon Thomas', '46891234', 'brandon@example.com', 'Stylist', 3000.00),
       ('Kimberly Wilson', '57902345', 'kimberly@example.com', 'Massage Therapist', 3500.00);

INSERT INTO appointment (appointment_id, customer_id, service_id, employee_id, date, time, status)
VALUES (1, 1, 1, 1, '2024-02-25', '10:00:00', 'Confirmed'),
       (2, 2, 2, 2, '2024-02-24', '11:00:00', 'Confirmed'),
       (3, 3, 3, 3, '2024-02-26', '12:00:00', 'Confirmed'),
       (4, 4, 4, 4, '2024-02-27', '13:00:00', 'Confirmed'),
       (5, 5, 5, 5, '2024-02-28', '14:00:00', 'Confirmed'),
       (6, 6, 6, 6, '2024-02-29', '15:00:00', 'Confirmed');

INSERT INTO service_product (service_id, product_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (7, 8),
       (7, 9),
       (7, 10);

INSERT INTO employee_service (employee_id, service_id)
VALUES (1, 1),
       (3, 1),
       (2, 3),
       (5, 3),
       (4, 2),
       (1, 6),
       (3, 6),
       (2, 4);

ALTER TABLE customer
    MODIFY COLUMN phone_number BIGINT NOT NULL;

INSERT INTO payment (payment_id, appointment_id, customer_id, amount, method, date)
VALUES (1, 1, 1, 30, 'Credit Card', '2024-02-25'),
       (2, 2, 2034, 25, 'Debit Card', '2024-02-24'),
       (3, 3, 1761, 60, 'Cash', '2024-02-26'),
       (4, 4, 13721, 35, 'Credit Card', '2024-02-27'),
       (5, 5, 2005, 40, 'Debit Card', '2024-02-28'),
       (6, 6, 13769, 50, 'Cash', '2024-02-29');

INSERT INTO appointment_employee (appointment_id, employee_id)
VALUES (1, 3),
       (2, 5),
       (3, 2),
       (4, 4),
       (5, 1),
       (6, 6);

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
  AND EXISTS (SELECT 1
              FROM service
              WHERE duration = 60);


-- NOT EXISTS with non-correlated
-- Employees who do not have confirmed service appointments
SELECT e.name, e.position, e.salary
FROM employee e
WHERE NOT EXISTS (SELECT 1
                  FROM appointment a
                           JOIN service s ON a.service_id = s.service_id
                  WHERE a.employee_id = e.employee_id
                    AND a.status = 'Confirmed');

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
WHERE EXISTS (SELECT 1
              FROM appointment a
              WHERE a.service_id = s.service_id
                AND a.employee_id = s.service_id
                AND a.status = 'Confirmed'
                AND a.date >= CURRENT_DATE());

-- NOT EXISTS with correlated
-- retrieve services without confirmed appointments by the same employee and current or future date
SELECT *
FROM service s
WHERE NOT EXISTS (SELECT 1
                  FROM appointment a
                  WHERE a.service_id = s.service_id
                    AND a.employee_id = s.service_id
                    AND a.status = 'Confirmed'
                    AND a.date >= CURRENT_DATE());


-- UPDATE queries:

-- = with non-correlated
-- -- Update query setting the price of services based on the maximum confirmed appointment price
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
WHERE EXISTS (SELECT 1
              FROM appointment
              WHERE appointment.employee_id = employee.employee_id)
  AND position = 'Stylist';


-- NOT EXISTS with non-correlated 
-- Update query changing the position of employees to 'Senior Stylist' based on their salary and lack of confirmed appointments
UPDATE employee
SET position = 'Senior Stylist'
WHERE salary > 3500
  AND NOT EXISTS (SELECT 1
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
SET price = 40.00
WHERE s.service_id NOT IN (SELECT service_id
                           FROM appointment
                           WHERE employee_id = s.service_id
                             AND status = 'Confirmed');

-- EXISTS with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 40.00
WHERE EXISTS (SELECT 1
              FROM appointment
              WHERE employee_id = s.service_id
                AND status = 'Confirmed');

-- NOT EXISTS with correlated
-- Update query setting the price of services based on a condition related to appointment status and service ID
UPDATE service s
SET price = 50.00
WHERE NOT EXISTS (SELECT 1
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
WHERE EXISTS (SELECT 1
              FROM appointment a
              WHERE a.employee_id = e.employee_id
                AND a.status = 'Confirmed');


-- NOT EXISTS with non-correlated
-- Deletes employees with the position 'Stylist' who have no appointments with status 'Confirmed'
DELETE
FROM employee
WHERE position = 'Stylist'
  AND NOT EXISTS (SELECT 1
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
WHERE EXISTS (SELECT 1
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
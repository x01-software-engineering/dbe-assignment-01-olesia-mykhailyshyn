CREATE DATABASE IF NOT EXISTS BEAUTY_SALON_Department;
USE BEAUTY_SALON_Department;

CREATE TABLE Services (
                          service_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(256) NOT NULL,
                          description VARCHAR(256),
                          duration INT,
                          price INT NOT NULL
);

CREATE TABLE Products (
                          product_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          service_id INT NOT NULL,
                          name VARCHAR(256) NOT NULL,
                          description VARCHAR(256),
                          quantity INT,
                          price INT NOT NULL,
                          FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

CREATE TABLE Customers (
                           customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(256) NOT NULL,
                           phone_number VARCHAR(32) NOT NULL,
                           email VARCHAR(256),
                           address VARCHAR(256)
);

CREATE TABLE Payments (
                          payment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          customer_id INT NOT NULL,
                          amount INT NOT NULL,
                          method VARCHAR(256) NOT NULL,
                          date DATE NOT NULL,
                          FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Employees (
                           employee_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(256) NOT NULL,
                           phone_number VARCHAR(32) NOT NULL,
                           email VARCHAR(256) NOT NULL,
                           position VARCHAR(256) NOT NULL,
                           salary INT NOT NULL
);

CREATE TABLE Appointments (
                              appointment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                              customer_id INT NOT NULL,
                              service_id INT NOT NULL,
                              employee_id INT NOT NULL,
                              date DATE NOT NULL,
                              time TIME,
                              status VARCHAR(256),
                              FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
                              FOREIGN KEY (service_id) REFERENCES Services(service_id),
                              FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Services (name, description, duration, price)
VALUES
    ('Haircut', 'Trimming and styling hair', 60, 30.00),
    ('Manicure', 'Nail care and polish', 45, 25.00),
    ('Massage', 'Body relaxation therapy', 90, 60.00),
    ('Pedicure', 'Foot care and polish', 60, 35.00),
    ('Waxing', 'Hair removal using wax', 45, 40.00),
    ('Facial', 'Skin care and treatment', 60, 50.00),
    ('Makeup', 'Cosmetic application', 30, 40.00);

INSERT INTO Products (service_id, name, description, quantity, price)
VALUES
    (1, 'Shampoo', 'Hair cleaning product', 50, 15.00),
    (2, 'Nail Polish', 'Variety of nail colors', 100, 10.00),
    (3, 'Massage Oil', 'Oil for massage therapy', 20, 20.00),
    (4, 'Foot Cream', 'Moisturizing foot cream', 30, 12.00),
    (5, 'Wax Strips', 'Strips for hair removal', 40, 25.00),
    (6, 'Face Mask', 'Skin care product', 60, 30.00),
    (7, 'Lipstick', 'Cosmetic product', 80, 18.00),
    (7, 'Foundation', 'Cosmetic product', 70, 25.00),
    (7, 'Eyeliner', 'Cosmetic product', 90, 15.00),
    (7, 'Mascara', 'Cosmetic product', 100, 20.00);

INSERT INTO Customers (name, phone_number, email, address)
VALUES
    ('John Doe', '12345670', 'john@example.com', '123 Main St'),
    ('Jane Smith', '98765430', 'jane@example.com', '456 Oak Ave'),
    ('Michael Brown', '22233344', 'michael@example.com', '567 Pine Ave'),
    ('Sarah Wilson', '78889999', 'sarah@example.com', '890 Maple Blvd'),
    ('David Lee', '55667777', 'davy@example.com', '789 Elm St'),
    ('Emily Davis', '44456666', 'emmmi@example.com', '678 Birch Ave');

INSERT INTO Payments (customer_id, amount, method, date)
VALUES
    (1, 50.00, 'Credit Card', '2024-02-21'),
    (2, 40.00, 'Cash', '2024-02-20'),
    (1, 30.00, 'Credit Card', '2024-02-19'),
    (3, 60.00, 'Credit Card', '2024-02-18'),
    (4, 25.00, 'Cash', '2024-02-17'),
    (5, 35.00, 'Credit Card', '2024-02-16');

INSERT INTO Employees (name, phone_number, email, position, salary)
VALUES
    ('Alice Johnson', '11123333', 'alice@example.com', 'Stylist', 3000.00),
    ('Bob Smith', '44455566', 'bob@example.com', 'Massage Therapist', 3500.00),
    ('David Miller', '67778888', 'david@example.com', 'Stylist', 3200.00),
    ('Emma White', '89990000', 'emma@example.com', 'Manicurist', 2800.00),
    ('James Taylor', '90001111', 'james@example.com', 'Massage Therapist', 3700.00);

INSERT INTO Appointments (customer_id, service_id, employee_id, date, time, status)
VALUES
    (1, 1, 1, '2024-02-25', '10:00:00', 'Scheduled'),
    (2, 2, 2, '2024-02-24', '14:00:00', 'Completed'),
    (1, 3, 2, '2024-02-26', '11:00:00', 'Scheduled'),
    (3, 4, 3, '2024-02-27', '15:00:00', 'Completed'),
    (4, 5, 4, '2024-02-28', '12:00:00', 'Scheduled'),
    (5, 6, 5, '2024-02-29', '13:00:00', 'Completed');

-- Find the top 3 customers with the highest total amount spent
SELECT c.name, SUM(p.amount) AS total_amount
FROM Customers c
         JOIN Payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_amount DESC
LIMIT 3;

-- Find customers who have made card payments and spent more than 30 currency units
SELECT c.name, SUM(p.amount) AS total_amount
FROM Customers c
         JOIN Payments p ON c.customer_id = p.customer_id
WHERE p.method = 'Credit Card'
GROUP BY c.customer_id
HAVING total_amount > 30;

-- Find the total revenue generated by each service offered by the salon
SELECT s.name AS service_name, SUM(p.amount) AS total_revenue
FROM Services s
         JOIN Appointments a ON s.service_id = a.service_id
         JOIN Payments p ON a.appointment_id = p.customer_id
GROUP BY s.service_id
ORDER BY total_revenue DESC;
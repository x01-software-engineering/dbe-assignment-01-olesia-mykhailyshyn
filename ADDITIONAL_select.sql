-- EMPLOYEE METRICS QUERY 

CREATE INDEX idx_appointment_employee ON appointment_employee (employee_id, appointment_id);
CREATE INDEX idx_appointment_appointment_id ON appointment (appointment_id);
CREATE INDEX idx_appointment_employee_id ON appointment (employee_id);
CREATE INDEX idx_payment_appointment_id ON payment (appointment_id);
CREATE INDEX idx_employee_employee_id ON employee (employee_id);

-- select query to fetch employee metrics
SELECT e.name AS employee_name,
       appointment_metrics.total_appointments,
       appointment_metrics.total_revenue,
       service_metrics.total_assigned_appointments,
       service_metrics.avg_service_price,
       service_metrics.max_service_price,
       service_metrics.min_service_price,
       payment_metrics.total_paid_appointments
FROM employee e
         -- join with subqueries to calculate appointment metrics for each employee
         LEFT JOIN (SELECT ae.employee_id,
                           COUNT(DISTINCT a.appointment_id) AS total_appointments,
                           SUM(p.amount)                    AS total_revenue
                    FROM appointment_employee ae
                             LEFT JOIN
                         appointment a ON ae.appointment_id = a.appointment_id
                             LEFT JOIN
                         payment p ON a.appointment_id = p.appointment_id
                    GROUP BY ae.employee_id) AS appointment_metrics ON e.employee_id = appointment_metrics.employee_id
    -- join with subqueries to calculate service metrics for each employee
         LEFT JOIN (SELECT e.employee_id,
                           COUNT(1)     AS total_assigned_appointments,
                           AVG(s.price) AS avg_service_price,
                           MAX(s.price) AS max_service_price,
                           MIN(s.price) AS min_service_price
                    FROM employee e
                             LEFT JOIN
                         appointment_employee ae ON e.employee_id = ae.employee_id
                             LEFT JOIN
                         appointment a ON ae.appointment_id = a.appointment_id
                             LEFT JOIN
                         service s ON a.service_id = s.service_id
                    GROUP BY e.employee_id) AS service_metrics ON e.employee_id = service_metrics.employee_id
    -- join with subqueries to calculate payment metrics for each employee
         LEFT JOIN (SELECT e.employee_id,
                           COUNT(1) AS total_paid_appointments
                    FROM employee e
                             LEFT JOIN
                         appointment_employee ae ON e.employee_id = ae.employee_id
                             LEFT JOIN
                         appointment a ON ae.appointment_id = a.appointment_id
                             LEFT JOIN
                         payment p ON a.appointment_id = p.appointment_id
                    GROUP BY e.employee_id) AS payment_metrics ON e.employee_id = payment_metrics.employee_id
-- filter out rows with NULL values
WHERE appointment_metrics.total_appointments IS NOT NULL
  AND appointment_metrics.total_revenue IS NOT NULL
  AND service_metrics.total_assigned_appointments IS NOT NULL
  AND service_metrics.avg_service_price IS NOT NULL
  AND service_metrics.max_service_price IS NOT NULL
  AND service_metrics.min_service_price IS NOT NULL
  AND payment_metrics.total_paid_appointments IS NOT NULL
-- order by total revenue and total appointments in descending order
ORDER BY appointment_metrics.total_revenue DESC, appointment_metrics.total_appointments DESC;
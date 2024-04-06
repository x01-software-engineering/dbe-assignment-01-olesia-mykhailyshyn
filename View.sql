CREATE INDEX idx_appointment_employee_id ON appointment (employee_id);
CREATE INDEX idx_appointment_service_id ON appointment (service_id);
CREATE INDEX idx_employee_employee_id ON employee (employee_id);
CREATE INDEX idx_service_service_id ON service (service_id);
CREATE INDEX idx_appointment_date ON appointment (date);

-- Recreate the view with optimized indexing
DROP VIEW IF EXISTS employee_schedule_day;
CREATE VIEW employee_schedule_day AS
SELECT e.name                                                             AS employee_name,
       GROUP_CONCAT(DISTINCT s.name)                                      AS services_provided_by_employee,
       CONCAT(a.time, '-', ADDTIME(a.time, SEC_TO_TIME(s.duration * 60))) AS time_slot, -- start_time - end_time
       s.name                                                             AS service_name,
       COUNT(a.appointment_id)                                            AS appointment_count
FROM appointment a
         JOIN employee e ON a.employee_id = e.employee_id
         JOIN service s ON a.service_id = s.service_id
WHERE DATE(a.date) = '2024-02-25' -- CURDATE()
GROUP BY e.employee_id, a.time, s.duration, s.name
ORDER BY appointment_count DESC;

SELECT *
FROM employee_schedule_day;
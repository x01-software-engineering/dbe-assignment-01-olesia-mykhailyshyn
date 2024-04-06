DROP VIEW IF EXISTS employee_schedule_day;
CREATE VIEW employee_schedule_day AS
SELECT e.name                                                             AS employee_name,
       GROUP_CONCAT(DISTINCT s.name)                                      AS services_provided_by_employee,
       CONCAT(a.time, '-', ADDTIME(a.time, SEC_TO_TIME(s.duration * 60))) AS time_slot, -- start_time - end_time
       s.name                                                             AS service_name
FROM appointment a
         JOIN
     employee e ON a.employee_id = e.employee_id
         JOIN
     service s ON a.service_id = s.service_id
WHERE DATE(a.date) = '2024-02-25' -- CURDATE()
GROUP BY e.employee_id, a.time, s.duration, s.name;

SELECT *
FROM employee_schedule_day;
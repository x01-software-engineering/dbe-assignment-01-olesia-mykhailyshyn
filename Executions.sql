-- testing the stored procedures
CALL CountEmployeesByPosition('Stylist');

CALL CalculateEmployeeRevenue('Alice Johnson', 2, 2024, @employee_name, @revenue);
SELECT @employee_name AS EmployeeName, @revenue AS TotalRevenue;

SET @department_name = 'Stylist';
CALL CalculateDepartmentAverageSalary(@department_name, 2, 2024, @average_salary);
SELECT @department_name AS DepartmentName, @average_salary AS AverageSalary;
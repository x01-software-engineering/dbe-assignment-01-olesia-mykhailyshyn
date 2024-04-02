import mysql.connector

database = mysql.connector.connect(
    host="localhost",
    user="root",
    password="my-secret-pw",
    database="beauty_salon_department",
    port='3307'
)

# Create cursor
cursor = database.cursor()

# Procedure for checking employee availability
def check_employee_availability(employee_id):
    cursor.callproc('CheckEmployeeAvailability', args=(employee_id,))
    for result in cursor.stored_results():
        return result.fetchone()[0]

# Procedure for scheduling a service
def schedule_service(customer_name, service_name, employee_name, date, time):
    message = ""
    try:
        cursor.callproc('ScheduleService', args=(customer_name, service_name, employee_name, date, time, message))
        print(message)
        database.commit()
    except mysql.connector.Error as err:
        print("Error:", err)
        database.rollback()

# Procedure for adding a new customer
def new_customer(customer_name, customer_email, customer_phone):
    message = ""
    try:
        cursor.callproc('NewCustomer', args=(customer_name, customer_email, customer_phone, message))
        print(message)
        database.commit()
    except mysql.connector.Error as err:
        print("Error:", err)
        database.rollback()

# Test the procedures
new_customer('Tobias Eaton', 'customer66@example.com', 1234567890)
schedule_service('Tobias Eaton', 'Haircut', 'Alice Johnson', '2024-02-25', '10:00:00')

# Close cursor and connection
cursor.close()
database.close()

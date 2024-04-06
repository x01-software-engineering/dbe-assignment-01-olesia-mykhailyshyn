import mysql.connector

database = mysql.connector.connect(
    host="localhost",
    user="root",
    password="my-secret-pw",
    database="beauty_salon_department",
    port='3307'
)


def schedule_service(customer_name, service_name, employee_name, date, time):
    try:
        with database.cursor() as cursor:
            # call procedure to check employee availability
            cursor.callproc("CheckEmployeeAvailability", (employee_name, '@is_available'))
            for result in cursor.stored_results():
                availability = result.fetchone()[0] # fetchone() --> True or False. receive the first row of the result. the result of the procedure

            if availability:
                # call procedure to schedule the service
                cursor.callproc("ScheduleService", (customer_name, service_name, employee_name, date, time, '@message'))
                for result in cursor.stored_results():
                    message = result.fetchone()[0]
                print(message)
            else:
                print("Service scheduled successfully.")

    except mysql.connector.Error:
        print("Employee is already booked for another service.")
        database.rollback()
    finally:
        database.close()


schedule_service('Tobias Eaton', 'Haircut', 'Alice Johnson', '2024-02-25', '10:00:00')
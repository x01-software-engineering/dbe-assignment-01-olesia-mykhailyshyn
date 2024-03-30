import mysql.connector

database = mysql.connector.connect(
    host="localhost",
    user="root",
    password="my-secret-pw",
    database="beauty_salon_department",
    port='3307'
)


# CRUD = insert, select, update, delete

def select_query(query):
    cursor = database.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    return result


# for insert, update, and delete

def execute_query(query):
    cursor = database.cursor()
    cursor.execute(query)
    database.commit()
    print("Query executed successfully.")


def insert_record(table, columns, values):
    query = f"INSERT INTO {table} ({columns}) VALUES ({values})"
    execute_query(query)


def select_records_by_name(table, name):
    query = f"SELECT * FROM {table} WHERE name LIKE '%{name}%'"
    return select_query(query)


def update_record(table, set_values, condition):
    query = f"UPDATE {table} SET {set_values} WHERE {condition}"
    execute_query(query)


def delete_record(table, name):
    query = f"DELETE FROM {table} WHERE name = '{name}'"
    execute_query(query)


# using

#insert
insert_record("employee", "name, phone_number, email, position, salary",
              "'Tris Prior', '09718658', 'tris@example.com', 'Massage Therapist', '3000'")


#select
results = select_records_by_name("employee", "Tris")
for record in results:
    print(record)

#update
update_record("employee",
              "name='Kimberly Wilson'",
              "name='Kimberly Smith'")

#delete
delete_record("employee",
              'Tris Prior')
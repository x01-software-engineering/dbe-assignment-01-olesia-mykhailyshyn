import mysql.connector

# Connect to the MySQL server
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="my-secret-pw",
    database="beauty_salon_department"
)

mycursor = db.cursor()

# Corrected SQL query to create the distributor table
distributor_table = """
CREATE TABLE distributor (
    distributor_id INT NOT NULL AUTO_INCREMENT, 
    name VARCHAR(52), 
    tel_number INT NOT NULL, 
    country VARCHAR(256) NOT NULL, 
    city VARCHAR(256), 
    address VARCHAR(256), 
    PRIMARY KEY (distributor_id),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
)
"""

# Execute the SQL query to create the distributor table
mycursor.execute(distributor_table)

# Insert data into the distributor table
distributor_table_insert = """INSERT INTO distributor (
name,
tel_number,
country, 
city
)
VALUES (%s, %s, %s, %s)"""

data = [
    ("Distributor1", "123456789", "USA", "New York"),
    ("Distributor2", "987654321", "UK", "London"),
    ("Distributor3", "456123789", "Canada", "Toronto"),
    ("Distributor4", "789456123", "France", "Paris"),
    ("Distributor5", "321654987", "Germany", "Berlin"),
    ("Distributor6", "654987321", "Australia", "Sydney")
]

mycursor.executemany(distributor_table_insert, data)
db.commit()

# Select all data from the distributor table
distributor_table_select = """SELECT * FROM distributor"""
mycursor.execute(distributor_table_select)
result = mycursor.fetchall()

# Print the selected data from the distributor table
print("Distributor Table:")
for row in result:
    print(row)

# Update data in the distributor table
distributor_table_update = """
UPDATE distributor 
SET tel_number = %s 
WHERE name = %s
"""

update_data = [
    ("111111111", "Distributor1"),
    ("222222222", "Distributor2"),
]

mycursor.executemany(distributor_table_update, update_data)
db.commit()

# Select all data from the distributor table after the update
mycursor.execute(distributor_table_select)
result_after_update = mycursor.fetchall()

# Print the selected data from the distributor table after the update
print("\nDistributor Table after Update:")
for row in result_after_update:
    print(row)

# Delete data from the distributor table
distributor_table_delete = """
DELETE FROM distributor 
WHERE name = %s
"""

delete_data = [
    ("Distributor3",),
    ("Distributor6",)
]

mycursor.executemany(distributor_table_delete, delete_data)
db.commit()

# Select all data from the distributor table after delete
mycursor.execute(distributor_table_select)
result_after_delete = mycursor.fetchall()

# Print the selected data from the distributor table after delete
print("\nDistributor Table after Delete:")
for row in result_after_delete:
    print(row)

# Close the database connection
db.close()
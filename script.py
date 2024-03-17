 import random

# Configuration
NUM_CUSTOMERS = 1000000  # Змініть на бажану кількість клієнтів

DEFAULT_CHUNK_SIZE = 10000

def generate_customer_inserts():
    with open('insert_customers.sql', 'w') as file:
        chunk_size = DEFAULT_CHUNK_SIZE
        for chunk_start in range(1, NUM_CUSTOMERS + 1, chunk_size):
            chunk_end = min(chunk_start + chunk_size - 1, NUM_CUSTOMERS)
            file.write("INSERT INTO customer (name, phone_number, email, address) VALUES\n\t")
            for customer_id in range(chunk_start, chunk_end + 1):
                name = f"Customer{customer_id}"
                phone_number = ''.join(random.choices('0123456789', k=10))  # Згенерувати випадковий номер телефону
                email = f"customer{customer_id}@example.com"
                address = f"Address {customer_id}"
                row = f"('{name}', '{phone_number}', '{email}', '{address}')"
                file.write(row)
                if customer_id < chunk_end:
                    file.write(",\n\t") 
            file.write(";\n\n")

generate_customer_inserts()
print("Done!")

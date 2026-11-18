import psycopg2 
from Database import conn 

class Customers:

    def __int__(self):
        # self.name = name,
        # self.contact = contact
        pass

    @staticmethod
    def create_table() : 
        cur = conn.cursor()
        cur.execute(
            """CREATE TABLE IF NOT EXISTS Customers(
                id SERIAL PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                contact VARCHAR(15) NOT NULL
                )
            """
        )
        conn.commit()
        cur.close()

    @staticmethod
    def insert_customer(name,contact):
        cur = conn.cursor()
        cur.execute(
                """INSERT INTO Customers (name,contact) 
                    VALUES (%s,%s)
                """,
                (name,contact),
        )
        conn.commit()
        cur.close()

    @staticmethod
    def update_customer(customer_id,name = None,contact = None):
        cur = conn.cursor()
        cur.execute("SELECT * FROM Customers WHERE id = %s",(customer_id,))
        customer = cur.fetchone()
        if not customer :
            print("CUSTOMER NOT FOUND!!")
            cur.close()
            return 
        update_fields = []
        if name :
            update_fields.append(f"name = '{name}'")
        elif contact :
            update_fields.append(f"contact = '{contact}'")

        update_query = f"UPDATE Customers SET {','.join(update_fields)} WHERE id = %s"

        cur.execute(update_query,(customer_id,))

        conn.commit()
        cur.close()

    @staticmethod
    def delete_customer(customer_id):
    
        cur = conn.cursor()
        cur.execute(
                " DELETE FROM  Customers WHERE id = %s",(customer_id,)  )
        conn.commit()
        cur.close()

    @staticmethod
    def get_all_customers():

        cur = conn.cursor()
        cur.execute(
                " SELECT * FROM Customers",
        )

        customers = cur.fetchall()
        cur.close()
        return customers

    @staticmethod
    def customer_menu():
        
        while True :
            print("""
1. Create Table
2. Insert Customer
3. Update Customer Details
4. Delete Customer
5. View All Customers
0. To exit """)
            
            choice = input("Enter your choice => ")

            if choice == "1" :
                Customers().create_table()
                print("Customer table created!")

            elif choice == "2" :
                name = input("Enter customer name : ")
                contact = input("Enter customer contact : ")
                Customers().insert_customer(name,contact)
                print("Customer created!")

            elif choice == "3" :
                customer_id = input("Enter customer id : ")
                name = input("ENter customer name : ")
                contact = input("Enter customer contact : ")
                Customers().upadte_customer(customer_id,name,contact)
                print("Customer details updated!")

            elif choice =="4" :
                customer_id = input("Enter customer id : ")
                Customers().delete_customer(customer_id)
                print("Customer deleted Succesfully!")

            elif choice == "5" :
                customers = Customers().get_all_customers()
                print(customers)

            elif choice == "0" :
                print("Exit Customer mangement !!") 
                break
            else : 
                print("Invalid choice , please try again")

# Customers().customer_menu()
import psycopg2 
from Database import conn 

class Sales:

    def __int__(self):
        pass

    @staticmethod
    def create_table() : 
        cur = conn.cursor()
        cur.execute(
            """CREATE TABLE IF NOT EXISTS Sales(
                id SERIAL PRIMARY KEY,
                customer_id  INTEGER NOT NULL,
                date DATE NOT NULL,
                total_amount DECIMAL(20,2) NOT NULL,
                CONSTRAINT fk_sales_customers
                    FOREIGN KEY (customer_id)
                    REFERENCES Customers(id)
                    ON DELETE CASCADE
                )
            """
        )
        conn.commit()
        cur.close()

    @staticmethod
    def insert_sale(customer_id,date,total_amount):
        cur = conn.cursor()
        cur.execute(
                """INSERT INTO Sales (customer_id,date,total_amount) 
                    VALUES (%s,%s,%s)
                """,
                (customer_id,date,total_amount),
        )
        conn.commit()
        cur.close()

    @staticmethod
    def update_sale(sale_id,customer_id = None,date = None,total_amount = None):
        cur = conn.cursor()
        cur.execute("SELECT * FROM Sales WHERE id = %s",(sale_id))
        sale = cur.fetchone()
        if not sale :
            print("PRODUCT NOT FOUND!!")
            cur.close()
            return 
        update_fields = []
        if customer_id :
            update_fields.append(f"customer_id = '{customer_id}'")
        if date :
            update_fields.append(f"date = '{date}'")
        if total_amount :
                    update_fields.append(f"total_amount = '{total_amount}'")
        
        
        update_query = f"UPDATE Sales SET {','.join(update_fields)} WHERE id = %s"

        cur.execute(update_query,(sale_id))

        conn.commit()
        cur.close()

    @staticmethod
    def delete_sale(sale_id):
    
        cur = conn.cursor()
        cur.execute(
                " DELETE FROM  Sales WHERE id = %s",(sale_id)  )
        conn.commit()
        cur.close()

    @staticmethod
    def generate_bill(sale_id) :
        cur = conn.cursor()
        cur.execute(" SELECT * FROM Sales WHERE id = %s",(sale_id))

        sale_item = cur.fetchall()
        total_amount = 0
        for i in sale_item:
             total_amount += i[4]*i[3]

        cur.close()
        return total_amount
         
    @staticmethod
    def sales_by_ID(sale_id):

        cur = conn.cursor()
        cur.execute(" SELECT * FROM Sales WHERE id = %s",(sale_id))

        sale = cur.fetchone()
        cur.close()
        return sale

    @staticmethod
    def sales_list():

        cur = conn.cursor()
        cur.execute("SELECT * FROM Sales")
        sales = cur.fetchall()
        cur.close()
        return sales
        
    #Analytics query

    @staticmethod
    def sales_by_DATE(start_date ,end_date):
    
        cur = conn.cursor()
        cur.execute(""" SELECT SUM(total_amount) FROM Sales
          WHERE date between %s AND %s""",(start_date,end_date))
    
        sale = cur.fetchone()
        cur.close()
        return sale

    @staticmethod
    def sales_by_Top_selling_product():
    
        cur = conn.cursor()
        cur.execute(""" SELECT product_id, SUM(quantity) AS total_quantity_sold 
        FROM sales_item
        GROUP BY product_id
        ORDER BY total_quantity_sold DESC LIMIT 5 """)
    
        total_products = cur.fetchall()
        cur.close()
        return total_products

    @staticmethod
    def get_sales_by_customer(customer_id):
        
            cur = conn.cursor()
            cur.execute(""" SELECT * FROM Sales WHERE customer_id =%s""",(customer_id))
        
            sale_by_cus = cur.fetchall()
            cur.close()
            return sale_by_cus

    @staticmethod
    def Sale_menu():
        
        while True :
            print("""
1. Create Table
2. Insert Sale
3. Upadte Sale Details
4. Delete Sale
5. View all sales
6. View sale by ID
7. View sale by sales date
8. View sale by top selling porduct
9. View sale by customer
10. Generate bill
0. To exit """)
            
            choice = input("Enter your choice => ")

            if choice == "1" :
                Sales().create_table()
                print("Sales table created!")

            elif choice == "2" :
                customer_id = input("Enter customer_id : ")
                date = input("Enter date of the sale : ")
                total_amount = input("Enter total amount : ")
                Sales().insert_sale(customer_id,date,total_amount)
                print("Sale created!")

            elif choice == "3" :
                sale_id = input("Enter sale id : ")
                customer_id = input("Enter customer_id : ")
                date = input("Enter date of the sale : ")
                total_amount = input("Enter total amount : ")
                Sales().update_sale(sale_id,customer_id,date,total_amount)
                print("Sale details updated!")

            elif choice =="4" :
                sale_id = input("Enter sale id : ")
                Sales().delete_sale(sale_id)
                print("Sale deleted Succesfully!")

            elif choice == "5" :
                sales = Sales().sales_list()
                print(sales)

            elif choice =="6" :
                sale_id = input("Enter sale id : ")
                item = Sales().sales_by_ID(sale_id)
                print(item)

            elif choice =="7" :
                s_date = input("Enter sale start date : ")
                e_date = input("Enter sale end date : ")
                sales = Sales().sales_by_DATE(s_date,e_date)
                print(sales)

            elif choice == "8" :
                products = Sales().sales_by_Top_selling_product()
                print(products)

            elif choice == "9" :
                c_id = input("Enter customer ID : ")
                Sales().get_sales_by_customer(c_id)


            elif choice == "10" :
                s_id = input("Enetr sales ID : ")
                bill = Sales().generate_bill(s_id)
                print(bill)
                print("Bill generated successfully")

            elif choice == "0" :
                print("Exit Sales management !!") 
                break
            
            else : 
                print("Invalid choice , please try again")

# Sales().Sale_menu()
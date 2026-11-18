import psycopg2 
from Database import conn 

class Products:

    def __int__(self):
        pass

    @staticmethod
    def create_table() : 
        cur = conn.cursor()
        cur.execute(
            """CREATE TABLE IF NOT EXISTS Products(
                id SERIAL PRIMARY KEY,
                name TEXT NOT NULL,
                description TEXT NOT NULL,
                price DECIMAL(10,2) NOT NULL,
                quantity INTEGER NOT NULL
                )
            """
        )
        conn.commit()
        cur.close()

    @staticmethod
    def insert_product(name,description,price,quantity):
        cur = conn.cursor()
        cur.execute(
                """INSERT INTO Products (name, description, price , quantity) 
                    VALUES (%s,%s,%s,%s)
                """,
                (name,description, price , quantity),
        )
        conn.commit()
        cur.close()

    @staticmethod
    def update_product(product_id,name = None,description = None,price = None,quantity =None):
        cur = conn.cursor()
        cur.execute("SELECT * FROM Products WHERE id = %s",(product_id,))
        product = cur.fetchone()
        if not product :
            print("PRODUCT NOT FOUND!!")
            cur.close()
            return 
        update_fields = []
        if name :
            update_fields.append(f"name = '{name}'")
        if description :
            update_fields.append(f"description = '{description}'")
        if price :
                    update_fields.append(f"price = '{price}'")
        if quantity :
                    update_fields.append(f"quantity = '{quantity}'")
        
        
        update_query = f"UPDATE Products SET {','.join(update_fields)} WHERE id = %s"

        cur.execute(update_query,(product_id,))

        conn.commit()
        cur.close()

    @staticmethod
    def delete_product(product_id):
    
        cur = conn.cursor()
        cur.execute(
                " DELETE FROM  Products WHERE id = %s",(product_id,)  )
        conn.commit()
        cur.close()

    @staticmethod
    def products_byID(product_id):

        cur = conn.cursor()
        cur.execute(" SELECT * FROM Products WHERE id = %s",(product_id,))

        product = cur.fetchone()
        cur.close()
        return product

    @staticmethod
    def products_list():

        cur = conn.cursor()
        cur.execute("SELECT * FROM Products")
        products = cur.fetchall()
        cur.close()
        return products

    @staticmethod
    def Product_menu():
        
        while True :
            print("""
 1. Create Table
 2. Insert Product
 3. Upadte Product Details
 4. Delete Product
 5. View all products
 6. View product by ID
 0. To exit """)
            
            choice = input("Enter your choice => ")

            if choice == "1" :
                Products().create_table()
                print("Products table created!")

            elif choice == "2" :
                name = input("Enter product name : ")
                description = input("Enter description of the product : ")
                price = input("Enter price of single unit : ")
                quantity = input("Enter product quantity : ")
                Products().insert_product(name,description,price,quantity)
                print("Product created!")

            elif choice == "3" :
                product_id = input("Enter product id : ")
                name = input("Enter new product name : ")
                description = input("Enter new description of the product : ")
                price = input("Enter new price of single unit : ")
                quantity = input("Enter new product quantity : ")
                Products().update_product(product_id,name,description,price,quantity)
                print("Product details updated!")

            elif choice =="4" :
                product_id = input("Enter product id : ")
                Products().delete_product(product_id)
                print("Product deleted Succesfully!")

            elif choice == "5" :
                products = Products().products_list()
                print(products)

            elif choice =="6" :
                product_id = input("Enter product id : ")
                item = Products().products_byID(product_id)
                print(item)

            elif choice == "0" :
                print("Exit Product mangemenet !!") 
                break
            
            else : 
                print("Invalid choice , please try again")

# Products().Product_menu()
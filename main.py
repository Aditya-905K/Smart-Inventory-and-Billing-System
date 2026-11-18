import Database
from Customers import Customers
from Products import Products
from Sales import Sales

# connection() #Database connection establishment

def main_menu():
    while True :
        print("1. Customer Management")
        print("2. Product Management")
        print("3. Sales Management")
        print("0. To exit application")
        choice  = input("Enter your option : ")

        if choice == "1" :
            Customers.customer_menu()

        elif choice == "2" :
            Products.Product_menu()

        elif choice == "3" : 
            Sales.Sale_menu()
            
        elif choice == "0" :
            print("Exit application")
            break
        
        else :
            print("Invalid choice, please try again")

if __name__ == "__main__" :
    main_menu()
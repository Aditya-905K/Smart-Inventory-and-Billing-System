# Smart Inventory and Billing System

I built this as a database project to see how a small shop could keep track of its customers, stock and sales in one place. It's written in Python with a PostgreSQL database, and it has a Streamlit web dashboard on top so you don't have to live in the terminal.

The sample data is an electronics store (laptops, phones, keyboards, earbuds and so on), because that felt more realistic than "Product 1, Product 2".

## What it does

- Add, edit, delete and view **customers**
- Add, edit, delete and view **products**, with price and stock count
- Create a **sale** for a customer, add as many items as you want, then finish it to get the total
- Stock goes down automatically when you add an item to a sale
- Generate an itemised **bill** for any sale
- A few **reports**:
  - sales summary with a daily trend chart
  - sales between two dates
  - top selling products
  - low stock alert (anything under 10 units)
  - purchase history for a single customer

## Built with

- Python 3
- PostgreSQL
- psycopg2 (talks to the database)
- Streamlit (the web interface)
- python-dotenv (keeps the database password out of the code)

## How the data is organised

Four tables:

```
Customers  (id, name, contact)
Products   (id, name, description, price, quantity)
Sales      (id, customer_id, date, total_amount)
sale_items (id, sale_id, product_id, quantity, price)
```

One sale can have many items, so `sale_items` sits between `Sales` and `Products`. Deleting a sale also deletes its items (`ON DELETE CASCADE`).

## Files

```
app.py              Streamlit web app (start here)
main.py             older terminal version
Database.py         database connection
Customers.py        customer queries and terminal menu
Products.py         product queries and terminal menu
Sales.py            sales queries and terminal menu
Sales_item.py       sale_items table
data_insertion.sql  sample data
.env.example        template for your database settings
```

## Running it yourself

You'll need Python 3 and PostgreSQL installed.

**1. Get the code**

```bash
git clone https://github.com/Aditya-905K/Smart-Inventory-and-Billing-System.git
cd Smart-Inventory-and-Billing-System
```

**2. Install the packages**

```bash
pip install psycopg2-binary streamlit python-dotenv
```

**3. Create the database**

In pgAdmin or psql:

```sql
CREATE DATABASE ecommerce;
```

**4. Add your database settings**

Copy `.env.example` to a new file called `.env` and put your own details in it:

```
DB_HOST=localhost
DB_NAME=ecommerce
DB_USER=postgres
DB_PASSWORD=your_password_here
DB_PORT=5432
```

`.env` is in `.gitignore`, so your password never gets uploaded.

**5. Start the app**

```bash
streamlit run app.py
```

The tables are created automatically the first time it runs.

## Loading the sample data (optional)

Once the app has run at least once (so the tables exist), run `data_insertion.sql` in pgAdmin's Query Tool, or from the terminal:

```bash
psql -U postgres -d ecommerce -f data_insertion.sql
```

This adds 100 customers, about 90 products and 100 sales.

One thing to know: the script creates sales with a total of 0. After loading it, run this once so the totals match the items:

```sql
UPDATE Sales s
SET total_amount = (
    SELECT SUM(quantity * price)
    FROM sale_items
    WHERE sale_id = s.id
);
```

## Making a sale

1. Go to **Sales Management** and pick a customer
2. Click **Create Sale**
3. Choose a product, set the quantity and add it (repeat for more items)
4. Click **Finish Sale** to save the total
5. Open **Generate Bill** to see the final bill

## The terminal version

`main.py` was my first version, before I added the web app. It still runs with `python main.py`, but the web app is the one I actually use and keep up to date.

## Things I want to add

- Login and user roles
- Block a sale if there isn't enough stock
- Export bills as PDF
- Edit and delete for sales
- Proper tests

## About me

I'm Aditya Kumar, a B.Tech student at LNCT, Bhopal. This project helped me understand how SQL, Python and a simple UI fit together. Feedback and suggestions are welcome.

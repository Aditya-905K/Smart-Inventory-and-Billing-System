ALTER TABLE sales 
ADD CONSTRAINT fk_sales_customer
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE CASCADE ;

CREATE TABLE sale_item (
	id SERIAL PRIMARY KEY ,
	sales_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	price DECIMAL(10,2) NOT NULL
);

ALTER TABLE sale_item
ADD CONSTRAINT fk_sale_item_sales
FOREIGN KEY (sales_id)
REFERENCES sales(id)
ON DELETE CASCADE ;

ALTER TABLE sale_item
ADD CONSTRAINT fk_sale_item_product
FOREIGN KEY (product_id)
REFERENCES products(id)
ON DELETE CASCADE ;
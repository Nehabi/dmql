create table admin(admin_id char(15) PRIMARY KEY,
                   first_name varchar(255) not null,
                   last_name varchar(255),
                   email varchar(255) not null,
                   contact varchar(15),
                   constraint check_adminmob check(contact ~ '^[0-9]{10}$'));

create table manager(manager_id char(15) PRIMARY KEY,
                   first_name varchar(255) not null,
                   last_name varchar(255),
                   email varchar(255) not null,
                   contact varchar(15),
                   admin_id char(15),
                   constraint check_managermob check(contact ~ '^[0-9]{10}$'),
                   CONSTRAINT admin_id FOREIGN KEY(admin_id) REFERENCES admin(admin_id) ON DELETE CASCADE);

create table employee(employee_id char(15) PRIMARY KEY,
                   first_name varchar(255) not null,
                   last_name varchar(255),
                   email varchar(255) not null,
                   contact varchar(15),
                   manager_id char(15),
                   constraint check_employeemob check(contact ~ '^[0-9]{10}$'),
                   CONSTRAINT manager_id FOREIGN KEY(manager_id) REFERENCES manager(manager_id) ON DELETE CASCADE);

create table store_location(store_id char(15) PRIMARY KEY,
                   place varchar(255) not null,
                   contact varchar(15),
                   manager_id char(15),
                   constraint check_storemob check(contact ~ '^[0-9]{10}$'),
                   CONSTRAINT manager_id FOREIGN KEY(manager_id) REFERENCES manager(manager_id) ON DELETE CASCADE);

create table category(category_id char(15) PRIMARY KEY,
                   name varchar(255) not null);

create table subcategory(subcategory_id char(15) PRIMARY KEY,
                   name varchar(255) not null,
                   category_id char(15),
                   CONSTRAINT category_id FOREIGN KEY(category_id) REFERENCES category(category_id) ON DELETE CASCADE);

create table product(product_id char(15) PRIMARY KEY,
                   name varchar(255) not null,
                   image varchar(255),
                   brand char(100),
                   price DECIMAL(10,2),
                   subcategory_id char(15),
                   productcount int,
                   CONSTRAINT subcategory_id FOREIGN KEY(subcategory_id) REFERENCES subcategory(subcategory_id) ON DELETE CASCADE);

create table supplier_info(supplier_id char(15) PRIMARY KEY,
                   first_name varchar(255) not null,
                   last_name varchar(255),
                   email varchar(255) not null,
                   contact varchar(15),
                   constraint check_suppliermob check(contact ~ '^[0-9]{10}$'));

create table customer(customer_id char(15) PRIMARY KEY,
                   first_name varchar(255) not null,
                   last_name varchar(255),
                   email varchar(255) not null,
                   contact varchar(15),
                   constraint check_customermob check(contact ~ '^[0-9]{10}$'));

create table order_history(order_id char(15),
                   price DECIMAL(10,2),
                   product_id char(15),
                   customer_id char(15),
                   store_id char(15),
                   productcount int,
                   CONSTRAINT customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
                   CONSTRAINT store_id FOREIGN KEY(store_id) REFERENCES store_location(store_id) ON DELETE CASCADE,
                   CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
                   PRIMARY KEY(order_id, customer_id, product_id));

create table cart(cart_id char(15),
                  product_id char(15),
                  customer_id char(15),
                  productcount int,
                  CONSTRAINT customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
                  CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
                  PRIMARY KEY(cart_id, customer_id, product_id));

create table review(review_id char(15) PRIMARY KEY,
                  product_id char(15),
                  customer_id char(15),
                  rating smallint,
                  CONSTRAINT customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
                  CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
                  CONSTRAINT check_rating check(rating>=0 and rating<=5 ));

create table supplier_product(
                  supplier_id char(15),
                  product_id char(15),
                  CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
                  CONSTRAINT supplier_id FOREIGN KEY(supplier_id) REFERENCES supplier_info(supplier_id) ON DELETE CASCADE);




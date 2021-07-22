-- remove any exiting tables
drop table if exists _User;
drop table if exists Addresses;
drop table if exists Address_Type;
drop table if exists Delivery_status_code;
drop table if exists Delivery;
drop table if exists Applied_Coupon;
drop table if exists Coupon;
drop table if exists Product_Order;
drop table if exists User_Order;
drop table if exists Order_Status_Code;
drop table if exists Product_Seller;
drop table if exists Seller;
drop table if exists User_Product_Reviews;
drop table if exists Product_Discount_Coupon;
drop table if exists Product_Details;
drop table if exists User_Address;
drop table if exists Product_Property;
drop table if exists User_Payment_Modes;
drop table if exists Product_Type; 
drop table if exists Product;

-- Tables

create table _User (
    _user_id varchar(30) NOT NULL PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20),
    contact_no varchar(14) NOT NULL,
    email_id varchar(30)
);

create table Addresses (
    addesses_id varchar(25) NOT NULL PRIMARY KEY,
    flat_no int,
    building_no varchar(30),
    locality varchar(30),
    street_name varchar(30),
    city varchar(20),
    district varchar(20),
    add_state varchar(20),
    pincode int
);

create table Address_Type (
    address_type_code varchar(20) NOT NULL PRIMARY KEY,
    address_type varchar(30)
);

create table User_Address (
    address_type_code varchar(30) references Address_Type(address_type_code) ON DELETE CASCADE ON UPDATE CASCADE,
    _user_id varchar(30) references _User(_user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    address_id varchar(30) references Addresses(address_id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint User_address PRIMARY KEY (address_type_code, _user_id, address_id)
);


create table Payments_Mode (
    payment_mode_code varchar(30) PRIMARY KEY,
    payment_method_description text,
    discount_provided_by_partner_bank int check (discount_provided_by_partner_bank>=1 AND discount_provided_by_partner_bank<=99)
);

create table User_Payment_Modes (
    user_payment_mode_id varchar(30) PRIMARY KEY,
    _user_id varchar(30) references _User(_user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    payment_method_code varchar(30) references Payments_Mode(payment_mode_code) ON DELETE CASCADE ON UPDATE CASCADE,
    card_number varchar(30),
    card_expiry_date date,
    card_holder_name varchar(30)
);

create table Product_Type (
    product_type varchar(30) PRIMARY KEY,
    product_category varchar(30)

);

create table Product (
    product_id varchar(30) PRIMARY KEY,
    product_name varchar(50),
    product_type varchar(30) references Product_Type(product_type) ON DELETE CASCADE ON UPDATE CASCADE
);

create table Product_Property (
    product_property_id varchar(30) PRIMARY KEY,
    product_property_name varchar(50),
    product_property_description text
);


create table Product_Details (
    product_id varchar(20) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_property_id varchar(20) references Product_Property(product_property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    values text,
    stock int,
    constraint product_detail  PRIMARY KEY(product_id, product_property_id)
);

create table Product_Discount_Coupon (
    product_discount_coupon_code varchar(30) PRIMARY KEY,
    discount int check (discount>=1 AND discount<=99),
    vaild_from timestamp,
    vaild_upto timestamp,
    min_order_amount float check (min_order_amount>10),
    max_order_amount float check (min_order_amount>100 AND max_order_amount<20000),
    product_id varchar(30) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);


create table User_Product_Reviews (
    _user_id varchar(30) references _User(_user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id varchar(30) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    ratings int check (ratings>=0 AND ratings<=5),
    product_review text,
    time_stamp timestamp
);

create table Seller (
    seller_id varchar(30) PRIMARY KEY,
    seller_name varchar(40),
    seller_contact_no varchar(40),
    seller_email_id varchar(30),
    seller_address_id varchar(30) references Addresses(addesses_id) ON DELETE CASCADE ON UPDATE CASCADE
);
create table Delivery_status_code (
    delivered_status_code varchar(30) PRIMARY KEY, 
    delivery_status_description text
);


create table Product_Seller (
    product_id varchar(30) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    seller_id varchar(30) references Seller(seller_id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint product_seller PRIMARY KEY(product_id, seller_id)  
);

create table Order_Status_Code (
    order_status_code varchar(30) PRIMARY KEY,
    description text
);

create table User_Order(
    order_id varchar(30) PRIMARY KEY,
    _user_id varchar(30) references _User(_user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    order_timestamp timestamp,
    user_payment_mode_id varchar(30) references User_Payment_Modes(user_payment_mode_id) ON DELETE CASCADE ON UPDATE CASCADE,
    order_status_code varchar(30) references Order_Status_Code(order_status_code) ON DELETE CASCADE ON UPDATE CASCADE,
    order_placed_timestamp timestamp,
    payment_option varchar(30),
    Total_amount float check(Total_amount>=1)
);

create table Product_Order (
    order_id varchar(30) references User_Order(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id varchar(30) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    quantity int DEFAULT 1,
    constraint product_order_pk PRIMARY KEY (order_id,product_id)
);


create table order_Discount_Coupon (
    order_discount_coupon_code varchar(30) PRIMARY KEY,
    discount int check (discount>=1 AND discount<=99),
    vaild_from timestamp,
    vaild_upto timestamp,
    min_order_amount float check (min_order_amount>10),
    max_order_amount float check (min_order_amount>100 AND max_order_amount<20000),
    order_id varchar(30) references User_Order(order_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table Delivery (
    order_id varchar(30) references User_Order(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    delivery_status_code varchar(20) references Delivery_status_code(delivered_status_code) ON DELETE CASCADE ON UPDATE CASCADE,
    expected_delivery_date date,
    delivery_start_date date ,
    delivered_on timestamp,
    constraint delivery_order_pk PRIMARY KEY(order_id,delivery_status_code)
);



create table user_cart (
    _user_id varchar(30) references _User(_user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id varchar(30) references Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    quantity int DEFAULT 1,
    constraint user_cart_pk PRIMARY KEY (_user_id,product_id)
);
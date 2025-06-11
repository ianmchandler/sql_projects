CREATE DATABASE loan_database;

CREATE TABLE branch (
	branch_name varchar(50) CONSTRAINT branch_name_key PRIMARY KEY,
	branch_city varchar(50), CHECK (branch_city IN ('Brooklyn', 'Bronx', 'Manhattan', 'Yonkers')),
	assets money NOT NULL CHECK (assets>='0.00')
);


CREATE TABLE customer (
	cust_ID varchar(50) CONSTRAINT cust_ID_key PRIMARY KEY,
	customer_name varchar(50) NOT NULL,
	customer_street varchar(50) NOT NULL,
	customer_city varchar(50)

);

CREATE TABLE loan (
	loan_number varchar(50) CONSTRAINT loan_number_key PRIMARY KEY,
	branch_name varchar(50) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
	amount money NOT NULL CHECK (amount>='0.00') DEFAULT 0.00
);


CREATE TABLE borrower (
	cust_ID varchar(50) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	loan_number varchar(50) REFERENCES loan(loan_number) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT borrower_key PRIMARY KEY (cust_ID, loan_number)
);

CREATE TABLE account (
	account_number varchar(50) CONSTRAINT account_number_key PRIMARY KEY,
	branch_name varchar(50) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
	balance money NOT NULL DEFAULT 0.00
);

CREATE TABLE depositor (
	cust_ID varchar(50) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	account_number varchar(50) REFERENCES account(account_number) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT depositor_key PRIMARY KEY (cust_ID, account_number)
);

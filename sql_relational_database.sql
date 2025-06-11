CREATE DATABASE banking;

CREATE TABLE branch (
	branch_name varchar(40) CONSTRAINT branch_name_key PRIMARY KEY,
	branch_city varchar(40), CHECK (branch_city IN ('Brooklyn', 'Bronx', 'Manhattan', 'Yonkers')),
	assets money NOT NULL CHECK (assets>='0.00')
);


CREATE TABLE customer (
	cust_ID varchar(40) CONSTRAINT cust_ID_key PRIMARY KEY,
	customer_name varchar(40) NOT NULL,
	customer_street varchar(40) NOT NULL,
	customer_city varchar(40)

);

CREATE TABLE loan (
	loan_number varchar(40) CONSTRAINT loan_number_key PRIMARY KEY,
	branch_name varchar(40) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
	amount money NOT NULL CHECK (amount>='0.00') DEFAULT 0.00
);


CREATE TABLE borrower (
	cust_ID varchar(40) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	loan_number varchar(40) REFERENCES loan(loan_number) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT borrower_key PRIMARY KEY (cust_ID, loan_number)
);

CREATE TABLE account (
	account_number varchar(40) CONSTRAINT account_number_key PRIMARY KEY,
	branch_name varchar(40) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
	balance money NOT NULL DEFAULT 0.00
);

CREATE TABLE depositor (
	cust_ID varchar(40) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	account_number varchar(40) REFERENCES account(account_number) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT depositor_key PRIMARY KEY (cust_ID, account_number)
);
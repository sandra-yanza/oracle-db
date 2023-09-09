-- Sandra Isabel Yanza Hernandez

--  ###### Script to create "customers_063" table
-- DROP TABLE customer_063;
CREATE TABLE customer_063
( 
    id             NUMBER(8,0)  CONSTRAINT C_PK_CUST primary key, 
    name           VARCHAR2(30) CONSTRAINT C_DES_NN NOT NULL, 
    address        VARCHAR(20)  CONSTRAINT C_ADD_NN NOT NULL, 
    salary         NUMBER(9,2)  NOT NULL, 
    creation_date  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ;

--  ###### These statements set comments on columns for "customer_063" table.
COMMENT ON COLUMN customer_063.id IS 'Primary key in this table';
COMMENT ON COLUMN customer_063.name IS 'Customer name';
COMMENT ON COLUMN customer_063.address IS 'Customer address';
COMMENT ON COLUMN customer_063.salary IS 'Customer salary';
COMMENT ON COLUMN customer_063.creation_date IS 'Registration date and time';


--#############
--create the stored procedure to insert data to the table customer_063
--##############

CREATE OR REPLACE PROCEDURE sp_insert8063(
	   p_customerid IN customer_063.id%TYPE,
	   p_customername IN customer_063.name%TYPE,
	   p_customeraddress IN customer_063.address%TYPE,
	   p_customersalary IN customer_063.salary%TYPE)
IS
BEGIN
  INSERT INTO customer_063 ("ID", "NAME", "ADDRESS", "SALARY") 
  VALUES (p_customerid, p_customername, p_customeraddress, p_customersalary);

COMMIT;

END;


--###############################

--now call the procedure sp_insert8063

BEGIN
   sp_insert8063(063,'Sandra','Mississauga',5000);
   sp_insert8063(765,'John','Oakville',6000);
   sp_insert8063(457,'Mariana','Brampton',3000);
   sp_insert8063(923,'Marcela','Toronto',4000);
END;

SELECT * FROM customer_063;


--#############
--create the stored procedure to update data in the table customer_063
--##############

CREATE OR REPLACE PROCEDURE updateCustomer_063(
	   p_customerid IN customer_063.id%TYPE,
       p_increment IN customer_063.salary%TYPE )
IS
BEGIN
  --update customer's salary
  UPDATE customer_063
  SET salary = salary + p_increment
  WHERE id = p_customerid;
COMMIT;
END;


--###############################

--now call the procedure updateCustomer_063

BEGIN
   updateCustomer_063(63, 100);
END;

SELECT * FROM customer_063;

--###############################
--create the stored procedure to select data in the table customer_063

CREATE OR REPLACE PROCEDURE selectCustomer_063(
	   p_customerid IN customer_063.id%TYPE,
	   o_customername OUT customer_063.name%TYPE,
       o_customersalary OUT customer_063.salary%TYPE,
	   o_customeraddress OUT  customer_063.address%TYPE,
	   o_date OUT customer_063.creation_date%TYPE)
IS
BEGIN

  SELECT name, salary, address, creation_date
  INTO o_customername, o_customersalary,  o_customeraddress, o_date 
  from  customer_063 WHERE ID = p_customerid;

END;

--###############################
--call the sp
SET SERVEROUTPUT ON;
DECLARE
    o_customername  customer_063.name%TYPE;
    o_customersalary customer_063.salary%TYPE;
	o_customeraddress customer_063.address%TYPE;
	o_date customer_063.creation_date%TYPE;
BEGIN
   selectCustomer_063(63,o_customername,o_customersalary,o_customeraddress, o_date);
   
   DBMS_OUTPUT.PUT_LINE('customer name :  ' || o_customername);
   DBMS_OUTPUT.PUT_LINE('customer salary :  ' || o_customersalary);
   DBMS_OUTPUT.PUT_LINE('customer address :  ' || o_customeraddress);
   DBMS_OUTPUT.PUT_LINE('creation date :  ' || o_date);
END;


--#############
--create the stored procedure to delete data in the table customer_063
--##############

CREATE OR REPLACE PROCEDURE deleteCustomer_063(
	   p_customerid IN customer_063.id%TYPE)
IS
BEGIN
  --delete this record
  DELETE FROM customer_063
  WHERE id = p_customerid;
COMMIT;
END;


--###############################

--now call the procedure deleteCustomer_063

BEGIN
   deleteCustomer_063(63);
END;

SELECT * FROM customer_063;















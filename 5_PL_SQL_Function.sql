-- Sandra Isabel Yanza Hernandez

--  ###### Script to create "products_063" table
-- DROP TABLE products_063;
CREATE TABLE products_063
( 
    product_id       NUMBER(8,0)  CONSTRAINT C_PK_PRODUCT primary key, 
    description      VARCHAR2(30) CONSTRAINT C_DESC_NN NOT NULL, 
    category         CHAR(3)      CONSTRAINT C_CAT_NN NOT NULL, 
    price            NUMBER(9,2)  NOT NULL, 
    creation_date    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT       C_CAT_CHK    check (category in ('GEN','BLD','DSG'))
) ;

--  ###### These statements set comments on columns for "products_063" table.
COMMENT ON COLUMN products_063.product_id IS 'Primary key in this table';
COMMENT ON COLUMN products_063.description IS 'Product description';
COMMENT ON COLUMN products_063.category IS 'Product category';
COMMENT ON COLUMN products_063.price IS 'Product price';
COMMENT ON COLUMN products_063.creation_date IS 'Registration date and time';

--  ###### Now insert rows in "products_063" table.
INSERT INTO products_063(product_id, description, category, price) VALUES
      (1, 'Product #1', 'GEN', 200000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (2, 'Product #2','GEN', 300000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (3, 'Product #3', 'BLD', 480000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (4, 'Product #4',  'BLD', 1000000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (5, 'Product #5',  'BLD', 250000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (6, 'Product #6',  'DSG', 840000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (7, 'Product #7', 'DSG', 950000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (8, 'Product #8',  'DSG', 7300000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (9, 'Product #9',  'DSG', 590000);
INSERT INTO products_063(product_id, description, category, price) VALUES
      (10, 'Product #10', 'DSG', 660000);

commit;

SELECT * FROM products_063;

--  ###### Now I create the function "CalculateDiscountedPrice_063"
--     for getting the discounted price for any product in "products_063" table.
CREATE OR REPLACE FUNCTION CalculateDiscountedPrice_063
    (i_product_id products_063.product_id%TYPE,
     i_discount IN NUMBER)
RETURN NUMBER
AS
    v_discounted_price NUMBER;
BEGIN
    SELECT 
        CASE 
        WHEN i_discount between 0 and 10 
            THEN price*0.9
        WHEN i_discount between 11 and 20
            THEN price*0.8
        WHEN i_discount between 21 and 30
            THEN price*0.7
        WHEN i_discount between 31 and 100
            THEN price*0.6
        WHEN i_discount < 0 OR i_discount > 100 THEN -1
        ELSE -1 END
    INTO v_discounted_price
    FROM products_063
    WHERE product_id = i_product_id;
    
    RETURN v_discounted_price;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN RETURN -1;
    WHEN OTHERS
    THEN RETURN -1;
END;


--  ###### Now I run an anonymous block for using the function
--     "CalculateDiscountedPrice_063"
SET SERVEROUTPUT ON;
DECLARE
   v_id_product number;
   v_discount_percentage number;
   v_discounted_price number;
BEGIN
   v_id_product := &id_product;
   v_discount_percentage := &discount_percentage;
   v_discounted_price := 
        CalculateDiscountedPrice_063(v_id_product, v_discount_percentage);
   IF (v_discounted_price = -1) THEN
        DBMS_OUTPUT.PUT_LINE
        ('It is not possible to calculate the Discounted Price.');
   ELSE
        DBMS_OUTPUT.PUT_LINE
         ('For the Product_ID '  || v_id_product ||
         ' and Discount_Percentage ' || v_discount_percentage || '%' ||
         ', the Discounted Price is: $' || v_discounted_price);
    END IF;
END;
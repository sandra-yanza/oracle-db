SET SERVEROUTPUT ON
-- create the table
CREATE TABLE VEHICLERENT_063 (
 VEHICLE_ID NUMBER(8,0) PRIMARY KEY,
 MANUFACTURER VARCHAR2(75) NOT NULL,
 MODELNAME VARCHAR2(20),
 TYPE VARCHAR2(10),
 RENT_DATE DATE,
 RETURN_DATE DATE
);

-- insert the rows
INSERT INTO VEHICLERENT_063 VALUES(1, 'Honda', 'City', 'Car',TO_DATE('2018-02-
20','YYYY-MM-DD'), TO_DATE('2018-02-23','YYYY-MM-DD'));
INSERT INTO VEHICLERENT_063 VALUES(2, 'Hyundai', 'i20', 'Car',TO_DATE('2018-03-
10','YYYY-MM-DD'), TO_DATE('2018-03-13','YYYY-MM-DD'));
INSERT INTO VEHICLERENT_063 VALUES(3, 'Audi', 'A4', 'Car',TO_DATE('2020-10-
13','YYYY-MM-DD'), TO_DATE('2020-10-22','YYYY-MM-DD'));
INSERT INTO VEHICLERENT_063 VALUES(4, 'Ford', 'Shelby', 'Car',TO_DATE('2021-06-
16','YYYY-MM-DD'), TO_DATE('2021-06-21','YYYY-MM-DD'));
INSERT INTO VEHICLERENT_063 VALUES(5, 'Renault', 'Megane', 'Car',TO_DATE('2022-03-
10','YYYY-MM-DD'), TO_DATE('2022-03-18','YYYY-MM-DD'));
commit;


-- create the procedure
CREATE OR REPLACE PROCEDURE rentCalculation_063(
	   p_vehicleId IN NUMBER,
	   o_rentAmount OUT NUMBER)
IS
BEGIN
  SELECT (RETURN_DATE-RENT_DATE)*75
  INTO o_rentAmount 
  from  VEHICLERENT_063 WHERE VEHICLE_ID = p_vehicleId;
END;

SELECT *
FROM VEHICLERENT_063
WHERE VEHICLE_ID = 5;


--Call the stored procedure
DECLARE
   i_vehicleID_063 NUMBER;
   o_rent_063 NUMBER;
BEGIN

   i_vehicleID_063 := 5;
   rentCalculation_063(i_vehicleID_063,o_rent_063);
   DBMS_OUTPUT.PUT_LINE('Total rent for the Vehical Id ' || i_vehicleID_063 || ':= ' || o_rent_063);
   
END;





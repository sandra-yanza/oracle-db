/*This is a simple example of an explicit cursor, in which
define a cursor that extracts the first and last name of the student with ID 107;
the extracted data is assigned to the variables declared in the DECLARE block.*/
SET SERVEROUTPUT ON
DECLARE
    v_first_name student.first_name%TYPE;
    v_last_name  student.last_name%TYPE;

    CURSOR c_student_sandra IS 
        SELECT   first_name, last_name
        FROM     student
        WHERE    student_id = 107;
BEGIN
    OPEN c_student_sandra;  --Open the cursor.
    FETCH c_student_sandra INTO v_first_name, v_last_name; --Assign values ??to variables.
    CLOSE c_student_sandra; --Close the cursor.
    DBMS_OUTPUT.PUT_LINE( 'The student: ' || v_first_name ||' '|| v_last_name || ' has an ID of 107'); 
END;


/*This example shows how to use an explicit cursor that returns more than one
row; the cursor is iterated with the help of a simple LOOP.*/
SET SERVEROUTPUT ON
DECLARE
    v_id student.student_id%TYPE;
    v_last_name  student.last_name%TYPE;

    CURSOR c_student_sandra IS 
        SELECT student_id, last_name
        FROM student
        WHERE employer = 'Electronic Engineers';
BEGIN
    OPEN c_student_sandra;  --Open the cursor.
    DBMS_OUTPUT.PUT_LINE( '*Students associated with employer Electronic Engineers*' );  
    LOOP
         FETCH c_student_sandra INTO v_id, v_last_name; --Assign values ??to variables.
         EXIT WHEN c_student_sandra%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE( 'ID: ' || v_id ||' , Last name: '|| v_last_name);  
    END LOOP;
    CLOSE c_student_sandra; --Close the cursor.
END;

    
/*I have modified the previous example by adding more columns; 
the declared record is based on the cursor and simplifies the code, 
avoiding having to declare as many variables as columns in the SELECT.*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR c_student_sandra IS 
           SELECT  student_id, first_name, last_name, street_address
           FROM student
           WHERE salutation = 'Ms.';

    v_stud_rec   c_student_sandra%ROWTYPE;
BEGIN
    OPEN c_student_sandra;  --Open the cursor.
    DBMS_OUTPUT.PUT_LINE( '*Students with salutation Ms.*' );  
    LOOP
         FETCH c_student_sandra INTO v_stud_rec;  --Assign values ??to variable.
         EXIT WHEN c_student_sandra%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE('ID: '||v_stud_rec.student_id||', First_Name: '||v_stud_rec.first_name||
                    ', Last_Name: '||v_stud_rec.last_name || ', Street_Address: '||v_stud_rec.street_address);  
    END LOOP;
    CLOSE c_student_sandra;  --Close the cursor.
END;

/*Now I do the same example using a FOR LOOP;
It simplifies the code even more since there is no need to open, FETCH or close the cursor.*/
SET SERVEROUTPUT ON
DECLARE
   CURSOR c_student_sandra IS 
           SELECT  student_id, first_name, last_name, street_address
           FROM student
           WHERE salutation = 'Ms.';
BEGIN
      DBMS_OUTPUT.PUT_LINE( '*Students with salutation Ms.*' );  
      FOR i IN c_student_sandra LOOP
         DBMS_OUTPUT.PUT_LINE('ID: '||i.student_id||', First_Name: '||i.first_name||
                    ', Last_Name: '||i.last_name || ', Street_Address: '||i.street_address);  
      END LOOP;
END;

--IMPLICITOS
--In this example an implicit cursor is used to execute a SELECT. It retrieves only one row with a value.
SET SERVEROUTPUT ON
DECLARE
    v_student_name VARCHAR2(50);
BEGIN
    SELECT first_name || ' ' || last_name INTO v_student_name 
    FROM student 
    WHERE student_id = 142;
    DBMS_OUTPUT.PUT_LINE('The student: ' || v_student_name || ' has an ID of 142');
END;

--In this example an implicit cursor is used to execute a UPDATE statement.
BEGIN
   UPDATE student 
   SET phone = '718-555-5555'
   WHERE student_id = 212;
   DBMS_OUTPUT.PUT_LINE('Rows affected by this update: ' || SQL%ROWCOUNT);
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--rowcount
/*In this example an implicit cursor is used to execute a UPDATE statement;  
then the number of affected rows is obtained using the SQL%ROWCOUNT. */
DECLARE  
   modified_rows number(2); 
BEGIN 
   UPDATE student 
   SET street_address = '43-11 National St'
   WHERE last_name = 'Torres'; 
   IF SQL%NOTFOUND THEN 
      DBMS_OUTPUT.PUT_LINE('No student obtained.'); 
   ELSIF SQL%FOUND THEN 
      modified_rows := SQL%ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE( 'Modified rows: ' || modified_rows); 
   END IF;  
END; 


/*In this example an explicit cursor is used to execute a SELECT statement;  
The SQL@ROWCOUNT is used to control the loop and stop it when the number of rows 
matches the condition, in this case up to 5 rows, avoiding going into an infinite loop.*/
DECLARE
    CURSOR c_student_sandra IS 
        SELECT * FROM student;
    v_student c_student_sandra%ROWTYPE;
BEGIN
    OPEN c_student_sandra;
    LOOP
        FETCH c_student_sandra INTO v_student;
        EXIT WHEN c_student_sandra%ROWCOUNT>5 OR c_student_sandra%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_student.first_name|| ' ' ||v_student.last_name);
    END LOOP;
    CLOSE c_student_sandra;
END;



--FOUND
DECLARE
    CURSOR c_student_sandra IS 
        SELECT student_id, zip
        FROM student
        WHERE zip like '11%';
  
    v_stud_id   number(9,2);
    v_zip     varchar2(5);
BEGIN
    OPEN c_student_sandra;
    FETCH c_student_sandra into v_stud_id, v_zip;
    WHILE c_student_sandra%FOUND LOOP
         DBMS_OUTPUT.PUT_LINE(v_stud_id || ', ' || v_zip);
         FETCH c_student_sandra into v_stud_id, v_zip;
    END LOOP;
    CLOSE c_student_sandra;
END;

--NOTFOUND
DECLARE
	v_student_id NUMBER:=&student_id;
BEGIN
    UPDATE student
    SET    street_address = 'not available'
    WHERE student_id = v_student_id;
 
  IF SQL%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE ('No student of ID '|| v_student_id||' is found.');
  ELSE
    DBMS_OUTPUT.PUT_LINE (
      'Update succeeded for student_id: ' || v_student_id);
  END IF;
END;






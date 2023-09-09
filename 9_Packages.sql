SET SERVEROUTPUT ON
--  ###### PRACTICAL EXERCISE #10

--  ###### Script to create "fsdmstudent_063" table
-- DROP TABLE fsdmstudent_063;
CREATE TABLE fsdmstudent_063
( 
    student_id    NUMBER(8,0)  CONSTRAINT C_PK_STUDFSD primary key, 
    first_name    VARCHAR2(30) CONSTRAINT C_NAMEST_FSDM NOT NULL, 
    last_name     VARCHAR(20)  CONSTRAINT C_LAST_FSDM NOT NULL
) ;

--SELECT * FROM fsdmstudent_063;

--  ###### Script to create "student063_seq" sequence
CREATE SEQUENCE student063_seq
 START WITH     63
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
--  ###### Script to create "pkgstudent_063" package 
create or replace PACKAGE pkgstudent_063
 AS
  PROCEDURE insert_record_063
     (i_student_id IN fsdmstudent_063.student_id%TYPE,
      i_first_name IN fsdmstudent_063.first_name%TYPE,
      i_last_name IN fsdmstudent_063.last_name%TYPE
      );
  PROCEDURE delete_record_063
     (i_student_id IN fsdmstudent_063.student_id%TYPE);
  FUNCTION retrieve_record_063
      (i_student_id IN fsdmstudent_063.student_id%TYPE)
      RETURN VARCHAR2;

END pkgstudent_063;

--- Now create Package BODY
create or replace PACKAGE BODY pkgstudent_063
AS
    PROCEDURE insert_record_063
       (i_student_id IN fsdmstudent_063.student_id%TYPE,
        i_first_name IN fsdmstudent_063.first_name%TYPE,
        i_last_name IN fsdmstudent_063.last_name%TYPE)
        IS
            v_student_id  fsdmstudent_063.student_id%TYPE;
    BEGIN
        INSERT INTO fsdmstudent_063 (student_id, first_name, last_name)
        VALUES (i_student_id, i_first_name, i_last_name);
        COMMIT;
        EXCEPTION
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.PUT_LINE('Error inserting student_id: '||i_student_id);
    END insert_record_063;
    
    PROCEDURE delete_record_063
     (i_student_id IN fsdmstudent_063.student_id%TYPE)
     IS
            e_invalid_id EXCEPTION;
    BEGIN
         --delete this record
        DELETE FROM fsdmstudent_063
        WHERE student_id = i_student_id;
        
        IF SQL%NOTFOUND THEN
            RAISE e_invalid_id;
        END IF;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Student with ID: ' || i_student_id || ' was deleted.');
        EXCEPTION
            WHEN e_invalid_id
            THEN
                DBMS_OUTPUT.PUT_LINE('Exception Description: The Student '||
                i_student_id ||
                ' is not in the database');
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.PUT_LINE('Error deleting student_id: '||i_student_id);
                ROLLBACK;
    END delete_record_063;
    
    FUNCTION retrieve_record_063
        (i_student_id IN fsdmstudent_063.student_id%TYPE)
      RETURN VARCHAR2
    AS
        v_student varchar2(50);
    BEGIN
        SELECT 'The student with id:' || i_student_id || ' is: ' || first_name 
        ||' ' || last_name
        INTO v_student
        FROM fsdmstudent_063
        WHERE student_id = i_student_id;
    RETURN v_student;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RETURN('The Student is not in the database');
        WHEN OTHERS
        THEN
            RETURN('Error in running retrieve_record_063');
    END;
END pkgstudent_063;
 
 

--SELECT student063_seq.nextval FROM DUAL;
--SELECT * FROM fsdmstudent_063;

--- Now call the package: STORED PROCEDURE insert_record_063
SET SERVEROUTPUT ON;
DECLARE
  v_first_name varchar2(100);
  v_local_last_name  varchar2(100);
BEGIN
    v_first_name := &name;
    v_local_last_name := &last_name;
    pkgstudent_063.insert_record_063(student063_seq.nextval, v_first_name, v_local_last_name);
    DBMS_OUTPUT.PUT_LINE('Student was inserted. Student ID: ' || student063_seq.currval 
    || ' with First name and last name: '||v_first_name||' '|| v_local_last_name);
END; 

SELECT * FROM fsdmstudent_063;


--- Now call the package: STORED PROCEDURE delete_record_063
SET SERVEROUTPUT ON;
DECLARE
  v_id number;
BEGIN
    v_id := &student_id;
    pkgstudent_063.delete_record_063(v_id);
END; 

--- Now call the package: FUNCTION retrieve_record_063
SET SERVEROUTPUT ON;
DECLARE
  v_id number;
BEGIN
    v_id := &student_id;
    DBMS_OUTPUT.PUT_LINE(pkgstudent_063.retrieve_record_063(v_id));
END; 







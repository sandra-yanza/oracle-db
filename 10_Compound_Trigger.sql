-- ####################################
-- Sandra Isabel Yanza Hernandez
-- ####################################
-- ###### PRACTICAL EXERCISE #11

SET SERVEROUTPUT ON

--  ###### Script to create "student_063" table
-- DROP TABLE student_063;
CREATE TABLE student_063
( 
    student_id    NUMBER(8,0)  CONSTRAINT C_PK_STUDCT primary key, 
    student_name  VARCHAR2(30) CONSTRAINT C_NAMESTCT NOT NULL, 
    address       VARCHAR2(200)  CONSTRAINT C_ADDRCT NOT NULL
) ;

--SELECT * FROM student_063;

--  ###### Script to create "student63_seq" sequence
CREATE SEQUENCE student63_seq
 START WITH     63
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


--SELECT student63_seq.nextval FROM DUAL;

--Inserting two records
INSERT INTO student_063(student_id, student_name, address)
VALUES(student63_seq.nextval, 'Sandra Yanza','34 Kenninghall Boulevard');

INSERT INTO student_063(student_id, student_name, address)
VALUES(student63_seq.nextval, 'Mariana Martinez','78 Creditview Road');

COMMIT;

SELECT * FROM student_063;



--  ###### Script to create "address_change_063" table
-- DROP TABLE address_change_063;
CREATE TABLE address_change_063
( 
    student_id    NUMBER(8,0) , 
    old_address   VARCHAR2(200) NOT NULL, 
    new_address   VARCHAR2(200)  NOT NULL,
    change_date   TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
) ;

--  ###### Script to create "trg_student_address_changes_063" trigger
CREATE OR REPLACE TRIGGER trg_student_address_changes_063
FOR INSERT OR UPDATE OR DELETE ON student_063 
COMPOUND TRIGGER
    v_dml_type varchar2(10);

    BEFORE STATEMENT IS
    BEGIN
        IF inserting THEN
            v_dml_type := 'INSERT';
        ELSIF updating THEN
            v_dml_type := 'UPDATE';
        ELSIF deleting THEN
            v_dml_type := 'DELETE';
        END IF;
        dbms_output.put_line('Before statement section is executed with the '||v_dml_type ||' event!.');
    END BEFORE STATEMENT; 
    
    BEFORE EACH ROW IS
        TYPE address_log_type IS RECORD(
            student_id number,
            old_address varchar2(200),
            new_address varchar2(200),
            change_date timestamp
        );
        address_record address_log_type;
    BEGIN
        IF UPDATING('address') THEN
            address_record.student_id := :OLD.student_id;
            address_record.old_address := :OLD.address;
            address_record.new_address := :NEW.address;
            address_record.change_date := CURRENT_TIMESTAMP;
            INSERT INTO address_change_063 
            values(address_record.student_id, address_record.old_address, 
            address_record.new_address, address_record.change_date);
        END IF;
        dbms_output.put_line('Before row section is executed with the '||v_dml_type ||' event!.');
    END BEFORE EACH ROW;
    
    AFTER EACH ROW IS
    BEGIN
      dbms_output.put_line('After row section is executed with the '||v_dml_type ||' event!.');
    END AFTER EACH ROW;
    AFTER STATEMENT IS
    BEGIN
      dbms_output.put_line('After statement section is executed with the '||v_dml_type ||' event!.');
    END AFTER STATEMENT;
END;







SELECT * FROM address_change_063;

UPDATE student_063
SET address = '34 Kenninghall Boulevard'
WHERE student_id = 63;



UPDATE student_063
SET address = 'another address'
WHERE student_id = 63;
COMMIT;





























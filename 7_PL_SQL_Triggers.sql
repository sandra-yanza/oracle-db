-- Sandra Isabel Yanza Hernandez

--  ###### Script to create "students_063" table
-- DROP TABLE students_063;
CREATE TABLE students_063
( 
    studentid    NUMBER(8,0)  CONSTRAINT C_PK_STUD primary key, 
    name         VARCHAR2(30) CONSTRAINT C_NAMEST_NN NOT NULL, 
    address      VARCHAR(20)  CONSTRAINT C_ADDR_NN NOT NULL, 
    created      TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
) ;

--  ###### These statements set comments on columns for "students_063" table.
COMMENT ON COLUMN students_063.studentid IS 'Primary key in this table';
COMMENT ON COLUMN students_063.name IS 'Student name';
COMMENT ON COLUMN students_063.address IS 'Student address';
COMMENT ON COLUMN students_063.created IS 'Registration date and time';

--  ###### Script to create "students_audit_063" table
-- DROP TABLE students_audit_063;
CREATE TABLE students_audit_063
( 
    studentid     NUMBER(8,0)  CONSTRAINT C_STUDAU_NN NOT NULL, 
    name          VARCHAR2(30) CONSTRAINT C_NAMESTAU_NN NOT NULL, 
    address       VARCHAR(20)  CONSTRAINT C_ADDRAU_NN NOT NULL, 
    action_type   VARCHAR(20)  CONSTRAINT C_TYPE_NN NOT NULL, 
    created       TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
) ;

ALTER TABLE students_audit_063
ADD CONSTRAINT check_aaction_type
  CHECK (action_type IN ('UPDATE', 'DELETE'));
  
--  ###### These statements set comments on columns for "students_audit_063" table.
COMMENT ON COLUMN students_audit_063.studentid IS 'Primary key in this table';
COMMENT ON COLUMN students_audit_063.name IS 'Student name';
COMMENT ON COLUMN students_audit_063.address IS 'Student address';
COMMENT ON COLUMN students_audit_063.action_type IS 'Action Type';
COMMENT ON COLUMN students_audit_063.created IS 'Registration date and time';


--#############
--create the Row Level Trigger to fire when Update or Delete Operation is done 
--on "students_063" table. Then the table "students_audit_063" 
--should be updated automatically by the trigger.
--##############

CREATE OR REPLACE TRIGGER assign8_trigger063
AFTER UPDATE OR DELETE ON students_063
FOR EACH ROW 
DECLARE
    v_event students_audit_063.action_type%TYPE;
BEGIN
    CASE
        WHEN UPDATING THEN
            v_event := 'UPDATE';
        WHEN DELETING THEN
            v_event := 'DELETE';
    END CASE;
    INSERT INTO students_audit_063(studentid, name, address, action_type)
        VALUES(:OLD.studentid, :OLD.name, :OLD.address, v_event);
END;
    

--###############################
--DML STATEMENTS
  INSERT INTO students_063 (studentid, name, address) 
  VALUES (63, 'Sandra', 'Mississauga');
  
  INSERT INTO students_063 (studentid, name, address) 
  VALUES (123, 'John', 'Etobicoke');
  COMMIT;
  
  SELECT * FROM students_063;
  
--UPDATE STATEMENTS
  UPDATE students_063
  SET address = 'Brampton'
  WHERE studentid = 63;
  COMMIT;
  
--CHECK THE TABLE 'students_audit_063'
  SELECT * FROM students_audit_063;

--DELETE STATEMENTS
  DELETE FROM students_063
  WHERE studentid = 63;
  COMMIT;

--CHECK THE TABLE 'students_audit_063'
  SELECT * FROM students_audit_063;











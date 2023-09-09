-- ####################################
-- Sandra Isabel Yanza Hernandez
-- ####################################
-- ###### PRACTICAL EXERCISE #12

SET SERVEROUTPUT ON

--  ###### Script to create "StudentDetails_063" table
-- DROP TABLE StudentDetails_063;
CREATE TABLE StudentDetails_063
( 
    student_id    NUMBER(10,0)  CONSTRAINT C_PK_DET primary key, 
    student_name  VARCHAR2(20) CONSTRAINT C_NAME2 NOT NULL, 
    country       VARCHAR2(20)  CONSTRAINT C_COUNT2 NOT NULL
) ;
--SELECT * FROM StudentDetails_063;

--  ###### Script to create "StudentProjects_063" table
-- DROP TABLE StudentProjects_063;
CREATE TABLE StudentProjects_063
( 
    project_id         NUMBER(10,0)  CONSTRAINT C_PK_PROJ1 primary key, 
    project_name       VARCHAR2(30) CONSTRAINT C_NAME3 NOT NULL, 
    project_start_date DATE,
    student_id         NUMBER(10,0),
    CONSTRAINT fk_student_id
    FOREIGN KEY (student_id)
    REFERENCES StudentDetails_063 (student_id)
) ;
--SELECT * FROM StudentProjects_063;


-- DROP VIEW student_projects_view_063;
--Creating the VIEW
CREATE OR REPLACE VIEW student_projects_view_063 AS
SELECT stdetails.student_id, stdetails.student_name, stdetails.country,
        stprojects.project_id, stprojects.project_name, 
        stprojects.project_start_date
FROM StudentDetails_063 stdetails, StudentProjects_063 stprojects
WHERE stdetails.student_id = stprojects.student_id;
--SELECT * FROM student_projects_view_063;


--Try to enter the following record with the view:
--It generates an ERROR
INSERT INTO student_projects_view_063
VALUES (1,'Indigo Enterprise','Canada',101,'Library management',sysdate);
--Generally, I should not rely on being able to perform an insert to a view
--unless I have specifically written an INSTEAD OF trigger for it. 
--Be aware, there are also INSTEAD OF INSERT OR UPDATE triggers that can be 
--written as well to help perform inserts or updates.



--Now, I create the TRIGGER with INSTEAD OF
CREATE OR REPLACE TRIGGER student_projects_view_063_insert
    INSTEAD OF INSERT ON student_projects_view_063
    FOR EACH ROW
DECLARE
    v_student_id NUMBER;
BEGIN
    -- insert a new student
    INSERT INTO StudentDetails_063(student_id, student_name, country)
    VALUES(:NEW.student_id, :NEW.student_name, :NEW.country);
   
    -- insert a new project
    INSERT INTO StudentProjects_063(project_id, project_name, project_start_date, student_id)
    VALUES(:NEW.project_id, :NEW.project_name, :NEW.project_start_date, :NEW.student_id);
END;

--DROP TRIGGER student_projects_view_063_insert;


--Now, I try to enter the following record with the view:
--But the TRIGGER "student_projects_view_063_insert" is used
INSERT INTO student_projects_view_063
VALUES (1,'Indigo Enterprise','Canada',101,'Library management',sysdate);
commit;

SELECT * FROM StudentDetails_063;


SELECT * FROM StudentProjects_063;













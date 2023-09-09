SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_employees IS
        SELECT employee_id, first_name
        FROM employees
        WHERE employee_id < 115;
    vr_employee c_employees%ROWTYPE;    
BEGIN
    OPEN c_employees;
    LOOP
        FETCH c_employees INTO vr_employee;
        IF c_employees%FOUND THEN
            DBMS_OUTPUT.PUT_LINE
            ('Just FETCHED row '
            ||TO_CHAR(c_employees%ROWCOUNT)||
            ' - Employee ID: '||vr_employee.employee_id || ' - First Name: '||vr_employee.first_name);
        ELSE
            EXIT;
        END IF;
    END LOOP;
    CLOSE c_employees;
EXCEPTION
    WHEN OTHERS THEN
            IF c_employees%ISOPEN THEN
                CLOSE c_employees;
            END IF;
END;

---------------------------------------------

SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_employees_063 IS
        SELECT employee_id, first_name
        FROM employees
        WHERE employee_id < 115;
BEGIN
    FOR vr_employee_063 IN c_employees_063
    LOOP
            DBMS_OUTPUT.PUT_LINE('Just FETCHED row '
            ||TO_CHAR(c_employees_063%ROWCOUNT)||
            ' - Employee ID: '||vr_employee_063.employee_id || ' - First Name: '||vr_employee_063.first_name);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        IF c_employees_063%ISOPEN THEN
            CLOSE c_employees_063;
        END IF;
END;








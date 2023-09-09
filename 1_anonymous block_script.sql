SET SERVEROUTPUT ON
DECLARE
    v_emp_firstname_063 employees_copy.first_name%TYPE;
BEGIN
    SELECT first_name
    INTO v_emp_firstname_063
    FROM employees_copy
    WHERE employee_id = 110;
    DBMS_OUTPUT.PUT_LINE('first name: ' || v_emp_firstname_063);
END;

SET SERVEROUTPUT ON;
DECLARE 
v_emp_salary employees.salary%TYPE;
BEGIN
SELECT salary
INTO v_emp_salary
FROM employees;
DBMS_OUTPUT.PUT_LINE('Salary : ' ||v_emp_salary);
END;


SET SERVEROUTPUT ON;
DECLARE 
v_emp_salary employees.salary%TYPE;
BEGIN
SELECT salary
INTO v_emp_salary
FROM employees;
DBMS_OUTPUT.PUT_LINE('Salary : ' ||v_emp_salary);
END;

DECLARE 
v_avg_salary employees.salary%TYPE;
BEGIN
SELECT min(salary)
INTO v_avg_salary
FROM employees;
DBMS_OUTPUT.PUT_LINE('Salary : ' ||v_avg_salary);
END;

SET SERVEROUTPUT ON;
DECLARE 
v_emp_salary employees.salary%TYPE;
a_employee_id employees.employee_id%TYPE := 115;
BEGIN
SELECT salary
INTO v_emp_salary
FROM employees
WHERE employee_id=a_employee_id;
DBMS_OUTPUT.PUT_LINE('Salary : ' ||v_emp_salary);
END;

-- Anonymous block
SET SERVEROUTPUT ON
DECLARE
    -- first name variable and salary variable using %TYPE 
    v_emp_firstname_063 employees_copy.first_name%TYPE;
    v_emp_salary_063    employees_copy.salary%TYPE;
BEGIN
    SELECT first_name, salary
    -- using variables
    INTO v_emp_firstname_063, v_emp_salary_063
    -- using employees_copy table for employee_id 110
    FROM employees_copy WHERE employee_id = 110;
    -- display first_name and salary
    DBMS_OUTPUT.PUT_LINE('First name: ' || v_emp_firstname_063);
    DBMS_OUTPUT.PUT_LINE('Salary : ' ||v_emp_salary_063);
END;

-- Anonymous block
SET SERVEROUTPUT ON
DECLARE 
    v_soc_sec_no_emp_063 employees_copy.soc_sec_no%TYPE;
BEGIN
    SELECT soc_sec_no INTO v_soc_sec_no_emp_063
    FROM employees_copy
    WHERE employee_id = 126;
    DBMS_OUTPUT.PUT_LINE('Social Security Number: ' ||v_soc_sec_no_emp_063);
END;

















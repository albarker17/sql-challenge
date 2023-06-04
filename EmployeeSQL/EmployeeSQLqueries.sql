-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


--List the employee number, last name, first name, sex, and salary of each employee.
SELECT * FROM "Employees"

Select emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
From "Employees" as emp
Join "Salaries" as sal
on emp.emp_no = sal.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT * FROM "Employees"
Select first_name, last_name, hire_date
From "Employees"
Where hire_date >='01/01/1986'

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT * FROM "Employees"


SELECT dep.dept_no, dep.dept_name, dman.emp_no, emp.last_name, emp.first_name
FROM "Departments" as dep
JOIN "Dept_manager" as dman
ON dep.dept_no = dman.dept_no
JOIN "Employees" as emp
on dman.emp_no = emp.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT * FROM "Employees"

SELECT emp.emp_no, emp.last_name, emp.first_name, demp.dept_no, dep.dept_name 
FROM "Employees" as emp
JOIN "Dept_emp" AS demp
ON emp.emp_no = demp.emp_no
JOIN "Departments" AS dep
ON demp.dept_no = dep.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT * FROM "Employees"

SELECT first_name, last_name, sex FROM "Employees"
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT * FROM "Departments"
SELECT * FROM "Dept_emp"
SELECT emp.emp_no, emp.last_name, emp.first_name
FROM "Employees" as emp
JOIN "Dept_emp" as demp
ON emp.emp_no = demp.emp_no
JOIN "Departments" as dep
ON demp.dept_no = dep.dept_no
WHERE dep.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM "Employees" as emp
JOIN "Dept_emp" as demp
ON emp.emp_no = demp.emp_no
JOIN "Departments" as dep
ON demp.dept_no = dep.dept_no
WHERE dep.dept_name = 'Sales' OR dep.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT * FROM "Employees"
SELECT last_name, 
	count (last_name) AS "Sum of Last Name"
FROM "Employees"
GROUP BY last_name
ORDER BY "Sum of Last Name" desc;
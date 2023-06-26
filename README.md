# Human Resources Management System

This repository contains the code for a Human Resources Management System database. The database schema is designed to store information about employees, departments, jobs, addresses, training programs, candidates, dependents, and more.

## Database Setup

To set up the database, follow these steps:

1. Run the following SQL query to create the database:
   ```sql
   DROP DATABASE IF EXISTS HumanResoursestest;

   CREATE DATABASE HumanResoursestest;
   USE HumanResoursestest;
   ```

2. Execute the provided SQL code to create the necessary tables, views, and stored procedures. Make sure to run the queries in the order they appear in the code file.

## Database Schema

The database schema consists of the following tables:

- `Employees`: Stores information about employees, including their ID, name, gender, birth date, nationality, contact details, hire date, and salary.
- `Employee_Educational_Background`: Keeps track of the educational background of employees.
- `Departments`: Stores information about departments within the organization.
- `Dept_manager`: Defines the manager for each department.
- `Emp_dep`: Establishes a relationship between employees and departments.
- `Jobs`: Represents different job positions available within the organization.
- `Job_salary`: Stores salary information for each job position.
- `Emp_Jobs`: Tracks job assignments for employees.
- `REGION`: Stores information about regions.
- `ZONE`: Stores information about zones within each region.
- `WOREDA`: Represents different woredas within each zone.
- `Employees_address`: Stores address information for employees.
- `Training_programs`: Stores information about training programs, including the department responsible for each program.
- `Candidates`: Stores information about job candidates, including their qualifications and resume date.
- `Dependents`: Keeps track of dependents for employees.
- `VEmployee_full_info`: A view that provides a comprehensive overview of employee information, including department, educational background, dependents, and address details.
- `VEmployee_Address`: A view that provides information about employees and their addresses.
- `VEmp_dep`: A view that shows the relationship between employees and departments.
- `vDept_manager`: A view that displays department managers and their respective departments.
- `VJob_salary`: A view that shows job positions and their salary ranges.
- `VEmp_Salary_tax`: A view that calculates the after-tax salary for each employee.
- `VRETIREMENT`: A view that calculates the years left until retirement for each employee.

## Stored Procedures

The following stored procedures are defined in the database:

1. `PDept_name`: Retrieves employees based on their department name.
2. `PEmp_Gender`: Retrieves employees based on their gender.
3. `PEdu_level`: Retrieves employees based on their educational level.
4. `PUpdate_Salary`: Updates the basic salary of an employee based on their ID.
5. `PDelete_Emp`: Deletes an employee from the database based on their ID.

Please note that the code provided is meant for illustrative purposes only and may require modifications based on your specific requirements.

Feel free to explore the code and adapt it to suit your needs. If you have any questions or need further assistance, please don't hesitate to reach out.

Happy coding!

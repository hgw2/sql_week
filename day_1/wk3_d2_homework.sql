--MVP 
--Q1 Find all the employees who work in the ‘Human Resources’ department.
SELECT *
FROM employees 
WHERE department ='Human Resources';

--Q2 Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT
	first_name,
	last_name,
	country
FROM employees 
WHERE department = 'Legal'

--Q3 Count the number of employees based in Portugal.

SELECT 
	COUNT(id) AS number_of_employees_in_portgual
FROM employees 
WHERE country = 'Portugal'

--Q4 Count the number of employees based in either Portugal or Spain.

SELECT 
 	COUNT(id) AS number_of_employees_in_spain_and_potugual
 FROM employees 
 WHERE country = 'Spain' OR country = 'Portugal'
 
 --Q5 Count the number of pay_details records lacking a local_account_no.
 
 SELECT *
 FROM pay_details 
 
 SELECT 
 	COUNT(id) AS number_of_people_without_local_account
 FROM pay_details 
 WHERE local_account_no IS NULL
 
-- Q6 Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

 SELECT 
 	first_name,
 	last_name
 FROM employees 
 ORDER BY last_name ASC NULLS LAST
 
 --Q7 How many employees have a first_name beginning with ‘F’?
 
 SELECT 
 	COUNT(id) AS number_of_people_with_first_name_begining_with_f
FROM employees 
WHERE first_name LIKE 'F%'

--Q8 Count the number of pension enrolled employees not based in either France or Germany.

SELECT 
	COUNT(id) AS number_of_people_on_pension_not_based_in_FRA_or_ger
FROM employees
WHERE (pension_enrol = TRUE) AND (country != 'France' OR country != 'Germany')

--Q9 Obtain a count by department of the employees who started work with the corporation in 2003.

SELECT 
	department,
	COUNT(id) AS number_of_people_who_started_work_in_2003
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department
 
 --10 Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. 
 --Order the table alphabetically by department, and then in ascending order of fte_hours.

SELECT 
	department,
	fte_hours,
	COUNT(id) AS number_of_employees_in_each_department
FROM employees 
GROUP BY department,fte_hours
ORDER BY department ASC NULLS LAST ,fte_hours ASC NULLS LAST


--Q11 Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
--Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department.

SELECT 
	department,
	COUNT(id) AS number_of_employees_missing_first_name
FROM employees 
WHERE first_name IS NULL
GROUP BY department  
HAVING COUNT(id) >= 2
ORDER BY count(id) DESC, department ASC

--Q12 Find the proportion of employees in each department who are grade 1.
 
SELECT 
COUNT(id)
FROM employees 
GROUP BY department

SELECT 
	sum(CAST(grade = 1 AS INT))
FROM employees 
GROUP BY department;




SELECT 
	department, 
      ROUND(CAST((sum(CAST(grade = 1 AS INT)))AS REAL) / CAST((COUNT(id))AS REAL)*100) AS percentage_number_are_grade_1
FROM employees
GROUP BY department

-- EXTENTION 
-- Q1 Do a count by year of the start_date of all employees, ordered most recent year last.

SELECT
	EXTRACT(YEAR FROM start_date) AS year_of_start_date, 
	COUNT(id) AS number_of_employees
FROM employees 
GROUP BY EXTRACT(YEAR FROM start_date) 
ORDER BY EXTRACT(YEAR FROM start_date) 

--Q2 Return the first_name, last_name and salary of all employees together with a new column called salary_class with a value 'low' where salary is less than 40,000 and value 'high'
-- where salary is greater than or equal to 40,000.

SELECT 
	first_name,
	last_name,
	salary, 
	CASE
	  WHEN salary < 40000 THEN 'Low'
	  WHEN salary >= 40000 THEN 'High'
	END salary_class
FROM employees

-- Q3 The first two digits of the local_sort_code (e.g. digits 97 in code 97-09-24) in the pay_details table are indicative of the region of an account. 
-- Obtain counts of the number of pay_details records bearing each set of first two digits? Make sure that the count of NULL local_sort_codes comes at the top of the table, 
-- and then order all subsequent rows first by counts in descending order, and then by the first two digits in ascending order

SELECT 
	SUBSTRING(local_sort_code, 1, 2) AS first_two_digits,
	 COUNT(id) AS count_records
FROM pay_details 
GROUP BY SUBSTRING(local_sort_code,1, 2)
ORDER BY COUNT(id) DESC,  SUBSTRING(local_sort_code,1, 2) ASC

--Q4 Return only the numeric part of the local_tax_code in the pay_details table, preserving NULLs where they exist in this column.
SELECT 
REGEXP_REPLACE(local_tax_code,'\D','','g') AS numeric_tax_code
FROM pay_details 

	
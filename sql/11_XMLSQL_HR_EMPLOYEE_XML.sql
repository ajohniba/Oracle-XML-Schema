--=======================================================================
-- SQL/XML XMLTABLE - HR_EMPLOYEE_XML 
-- consulta 01
--=======================================================================
SELECT
  x.emp_id,
  x.first_name,
  x.last_name,
  x.email,
  x.phone_number,
  x.hire_date,
  x.job_title,
  x.salary,
  x.department_id,
  x.department_name,
  x.city,
  x.country_id
FROM hr_employee_xml t,
     XMLTABLE(
       XMLNAMESPACES(DEFAULT 'http://www.company.com/employees'),
       '/company/employees/employee'
       PASSING t.OBJECT_VALUE
       COLUMNS
         emp_id         VARCHAR2(10) 	PATH '@id',
         first_name     VARCHAR2(50) 	PATH 'personal_data/first_name',
         last_name      VARCHAR2(50) 	PATH 'personal_data/last_name',
         email          VARCHAR2(100) 	PATH 'personal_data/email',
         phone_number   VARCHAR2(50) 	PATH 'personal_data/phone_number',
         hire_date      DATE         	PATH 'personal_data/hire_date',
         job_title      VARCHAR2(100) 	PATH 'job/job_title',
         salary         NUMBER       	PATH 'job/salary',
         department_id  NUMBER       	PATH 'job/department/@id',
         department_name VARCHAR2(100) 	PATH 'job/department/department_name',
         city           VARCHAR2(50)  	PATH 'job/department/location/city',
         country_id     VARCHAR2(10)  	PATH 'job/department/location/country_id'
     ) x
order by x.emp_id;

--=======================================================================
-- SQL/XML XMLTABLE - HR_EMPLOYEE_XML 
-- consulta 02
--=======================================================================

SELECT
  x.emp_id,
  x.first_name,
  x.last_name,
  j.job_id,
  j.job_title AS job_title_rel,
  j.min_salary,
  j.max_salary,
  x.department_id,
  d.department_name,
  d.manager_id
FROM hr_employee_xml t,
     XMLTABLE(
       XMLNAMESPACES(DEFAULT 'http://www.company.com/employees'),
       '/company/employees/employee'
       PASSING t.OBJECT_VALUE
       COLUMNS
         emp_id         VARCHAR2(10) PATH '@id',
         first_name     VARCHAR2(50) PATH 'personal_data/first_name',
         last_name      VARCHAR2(50) PATH 'personal_data/last_name',
         job_title      VARCHAR2(10) PATH 'job/job_title',
         department_id  NUMBER       PATH 'job/department/@id'
     ) x
JOIN jobs j
  ON x.job_title = j.job_title
JOIN departments d
  ON x.department_id = d.department_id;
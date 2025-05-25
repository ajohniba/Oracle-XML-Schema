--===========================================================
-- Consulta 01 SQL/XML: EMPLOYEES + DEPARTMENTS
--===========================================================
SELECT XMLELEMENT("employees",
         XMLAGG(
           XMLELEMENT("employee",
             XMLATTRIBUTES(e.employee_id AS "id"),
             XMLFOREST(
               e.first_name AS "first_name",
               e.last_name AS "last_name",
               e.email AS "email"
             ),
             XMLELEMENT("department",
               XMLATTRIBUTES(d.department_id AS "id"),
               XMLFOREST(d.department_name AS "name")
             )
           )
         )
       ) AS employee_xml
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

--===============================================================
-- Consulta 02 SQL/XML: EMPLOYEES + JOBS + LOCATIONS
--===============================================================
SELECT XMLELEMENT("employees",
         XMLAGG(
           XMLELEMENT("employee",
             XMLATTRIBUTES(e.employee_id AS "id"),
             XMLFOREST(
               e.first_name AS "first_name",
               e.last_name AS "last_name",
               e.email AS "email"
             ),
             XMLELEMENT("job",
               XMLATTRIBUTES(j.job_id AS "id"),
               XMLFOREST(j.job_title AS "title"),
               XMLELEMENT("salary_range",
                 XMLELEMENT("min", j.min_salary),
                 XMLELEMENT("max", j.max_salary)
               )
             ),
             XMLELEMENT("location",
               XMLATTRIBUTES(l.location_id AS "id"),
               XMLFOREST(
                 l.street_address AS "address",
                 l.city AS "city",
                 l.country_id AS "country"
               )
             )
           )
         )
       ) AS employee_xml
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
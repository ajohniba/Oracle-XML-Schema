--=================================================================
-- SQL para generar archivo base para hrdata.xml 
-- Generamos archivo xml con el resultado de la consulta 
-- Le adicionamos al principio como linea 1
-- <?xml version='1.0' encoding='UTF-8'?>
--=================================================================
SELECT XMLSERIALIZE(
         DOCUMENT
         XMLELEMENT("company",
           XMLATTRIBUTES('http://www.company.com/employees' AS "xmlns"),
           XMLELEMENT("employees",
             XMLELEMENT("employee",
               XMLATTRIBUTES(e.employee_id AS "id"),
               XMLELEMENT("personal_data",
                 XMLELEMENT("first_name", e.first_name),
                 XMLELEMENT("last_name", e.last_name),
                 XMLELEMENT("email", e.email),
                 XMLELEMENT("phone_number", e.phone_number),
                 XMLELEMENT("hire_date", e.hire_date)
               ),
               XMLELEMENT("job",
                 XMLELEMENT("job_title", j.job_title),
                 XMLELEMENT("salary", e.salary),
                 XMLELEMENT("department",
                   XMLATTRIBUTES(d.department_id AS "id"),
                   XMLELEMENT("department_name", d.department_name),
                   XMLELEMENT("location",
                     XMLELEMENT("city", l.city),
                     XMLELEMENT("country_id", l.country_id)
                   )
                 )
               )
             )
           )
         )
         AS CLOB
         INDENT SIZE = 2
       ) AS xml_hr_doc
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.employee_id = 102;

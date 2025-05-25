--=======================================================
--  Register the XSD in Oracle
--=======================================================
BEGIN
  DBMS_XMLSCHEMA.registerSchema(
    schemaURL => 'http://www.company.com/employees/hr_employee_hierarchical.xsd',
    schemaDoc => BFILENAME('XML_DIR', 'hr_employee_hierarchical.xsd'),
    local     => TRUE,
    genTypes  => TRUE,
    genTables => FALSE
  );
END;
/


CREATE TABLE hr_employee_xml OF XMLTYPE
XMLSCHEMA "http://www.company.com/employees/hr_employee_hierarchical.xsd"
ELEMENT "company";

--=====================================================
-- trigger validation 
--=====================================================
create or replace TRIGGER hr_employee_xml_trig BEFORE INSERT OR UPDATE ON hr_employee_xml FOR EACH ROW

DECLARE 
  newxml XMLType;
BEGIn
  newxml := :new.OBJECT_VALUE;
  XMLTYPE.schemavalidate(newxml);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('XML no válido según el esquema XSD: ' || SQLERRM);
    RAISE_APPLICATION_ERROR(-20001, 'XML inválido: no cumple con el esquema.');
END;
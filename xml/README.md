# `xml/`

This folder contains:

- `hr_employee_hierarchical.xsd`: The registered XML Schema that defines the structure of the employee documents.
- Sample XML files (`hr_employee_103.xml`, `hr_employee_104.xml`, etc.) that follow the schema and are used for inserts and testing.
- An example of an invalid XML (`hr_employee_106_invalid.xml`) that intentionally violates the schema to demonstrate validation failure.

All files in this directory are consumed through Oracle's `XMLTYPE` using BFILE and CLOB conversion within PL/SQL for validation and persistence.

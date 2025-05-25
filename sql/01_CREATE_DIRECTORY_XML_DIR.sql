--======================================================
--  Create directory for XSD access 
--  conexion sqlplus / as sysdba  
--======================================================
CREATE OR REPLACE DIRECTORY XML_DIR AS '/u02/xml';
GRANT READ ON DIRECTORY XML_DIR TO hrx;

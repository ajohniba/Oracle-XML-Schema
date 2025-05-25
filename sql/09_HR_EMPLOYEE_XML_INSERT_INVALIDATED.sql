--=============================================================================================
-- PL/SQL block to insert invalidated XML into hr_employee_xml using BFILE -> CLOB -> XMLTYPE
--=============================================================================================
set serveroutput on;

DECLARE
  l_bfile  		BFILE;
  l_clob   		CLOB;
  l_dest_offset INTEGER := 1;
  l_src_offset  INTEGER := 1;
  l_bfile_len   INTEGER;
  l_lang_ctx    INTEGER := DBMS_LOB.default_lang_ctx;
  l_warning     INTEGER;
BEGIN
  -- Reference the file located in the XMLDIR directory object
  l_bfile := BFILENAME('XML_DIR', 'hr_employee_106_invalid.xml');
  DBMS_LOB.OPEN(l_bfile, DBMS_LOB.LOB_READONLY);

  -- Create temporary CLOB
  DBMS_LOB.CREATETEMPORARY(l_clob, TRUE);
  l_bfile_len := DBMS_LOB.getlength(l_bfile);

  -- Load contents from BFILE into CLOB
  DBMS_LOB.LOADCLOBFROMFILE(
    dest_lob     => l_clob,
    src_bfile    => l_bfile,
    amount       => l_bfile_len,
    dest_offset  => l_dest_offset,
    src_offset   => l_src_offset,
    bfile_csid   => DBMS_LOB.DEFAULT_CSID,
    lang_context => l_lang_ctx,
    warning      => l_warning
  );

  DBMS_LOB.CLOSE(l_bfile);

  -- Insert XMLTYPE validated against registered XSD
  INSERT INTO hr_employee_xml VALUES (XMLTYPE.createXML(l_clob));
  
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
   

END;
/
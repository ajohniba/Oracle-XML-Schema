--=============================================================
-- PL/SQL block to insert multiple XML files from XML_DIR
--=============================================================
set serveroutput on;

DECLARE
  l_bfile       BFILE;
  l_clob        CLOB;
  l_bfile_len   INTEGER;
  l_lang_ctx    INTEGER := DBMS_LOB.default_lang_ctx;
  l_warning     INTEGER;
  l_filename    VARCHAR2(100);
  l_dest_offset INTEGER;
  l_src_offset  INTEGER;
  l_filenames   SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'hr_employee_103.xml',
    'hr_employee_104.xml',
    'hr_employee_105.xml',
	'hr_employee_106.xml'
  );
BEGIN
  FOR i IN 1 .. l_filenames.COUNT LOOP
    l_filename := l_filenames(i);
    l_bfile := BFILENAME('XML_DIR', l_filename);
    DBMS_LOB.OPEN(l_bfile, DBMS_LOB.LOB_READONLY);

    l_bfile_len := DBMS_LOB.getlength(l_bfile);

    DBMS_LOB.CREATETEMPORARY(l_clob, TRUE);
    
    -- Reset offsets on each iteration
    l_dest_offset := 1;
    l_src_offset := 1;

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

    INSERT INTO hr_employee_xml VALUES (XMLTYPE.createXML(l_clob));

    DBMS_LOB.FREETEMPORARY(l_clob);
    DBMS_OUTPUT.PUT_LINE('Inserted: ' || l_filename);
	COMMIT;
	
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
	ROLLBACK;
END;
/

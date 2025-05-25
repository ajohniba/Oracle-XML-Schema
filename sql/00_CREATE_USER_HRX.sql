--======================================================================
-- CREATE USER HRX
-- connect sys o system 
-- sqlplus / as sysdba
-- alter session set container = PDB1;
--======================================================================
create user hrx identified by hrx
DEFAULT TABLESPACE users 
TEMPORARY TABLESPACE temp
quota unlimited on users;


grant create session, create view, alter session, create sequence to hrx;
grant create synonym, create database link, resource , unlimited tablespace to hrx;


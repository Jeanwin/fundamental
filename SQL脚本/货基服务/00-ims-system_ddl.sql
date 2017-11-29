--数据表空间 
CREATE TABLESPACE SFFUND_DAT_TS1 DATAFILE 
  '/u01/app/oracle/oradata/SFFUND_DAT_TS1_01.dbf' SIZE 600M AUTOEXTEND OFF
LOGGING
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--索引表空间 
CREATE TABLESPACE SFFUND_IDX_TS1 DATAFILE 
  '/u01/app/oracle/oradata/SFFUND_IDX_TS1_01.dbf' SIZE 100M AUTOEXTEND OFF
LOGGING
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--创建用户
create user dm_sffund
  identified by dm_sffund
  default tablespace SFFUND_DAT_TS1;
-- Grant/Revoke role privileges 
grant connect to dm_sffund with admin option;
grant resource to dm_sffund with admin option;
-- Grant/Revoke system privileges 
grant unlimited tablespace to dm_sffund with admin option;
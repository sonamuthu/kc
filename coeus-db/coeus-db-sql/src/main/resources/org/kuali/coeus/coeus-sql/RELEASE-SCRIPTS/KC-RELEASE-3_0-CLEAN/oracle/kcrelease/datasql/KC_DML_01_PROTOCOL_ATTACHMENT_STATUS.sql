TRUNCATE TABLE PROTOCOL_ATTACHMENT_STATUS DROP STORAGE
/
INSERT INTO PROTOCOL_ATTACHMENT_STATUS (STATUS_CD,DESCRIPTION,UPDATE_USER,UPDATE_TIMESTAMP,OBJ_ID,VER_NBR) 
    VALUES ('1','Incomplete','admin',SYSDATE,SYS_GUID(),1)
/
INSERT INTO PROTOCOL_ATTACHMENT_STATUS (STATUS_CD,DESCRIPTION,UPDATE_USER,UPDATE_TIMESTAMP,OBJ_ID,VER_NBR) 
    VALUES ('2','Complete','admin',SYSDATE,SYS_GUID(),1)
/
ALTER TABLE FINANCIAL_ENTITY_ATTACHMENT
    ADD CONSTRAINT FK_FINENTA_FILE 
    FOREIGN KEY (FILE_ID) 
    REFERENCES ATTACHMENT_FILE (FILE_ID)
/

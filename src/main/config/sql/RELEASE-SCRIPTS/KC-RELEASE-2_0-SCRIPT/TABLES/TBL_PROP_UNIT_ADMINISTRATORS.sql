-- Table Script   
CREATE TABLE PROP_UNIT_ADMINISTRATORS (
    PROP_UNIT_ADMINISTRATORS_ID NUMBER (12, 0) NOT NULL, 
    PROPOSAL_ID NUMBER (12, 0) NOT NULL, 
    PROPOSAL_NUMBER VARCHAR2 (8) NOT NULL, 
    SEQUENCE_NUMBER NUMBER (4, 0) NOT NULL, 
    UNIT_ADMINISTRATOR_TYPE_CODE NUMBER (3, 0) NOT NULL, 
    ADMINISTRATOR VARCHAR2 (12) NOT NULL, 
    UPDATE_TIMESTAMP DATE NOT NULL, 
    UPDATE_USER VARCHAR2 (60) NOT NULL, 
    VER_NBR NUMBER (8, 0) DEFAULT 1 NOT NULL, 
    OBJ_ID VARCHAR2 (36) DEFAULT SYS_GUID () NOT NULL) ;

-- Primary Key Constraint   
ALTER TABLE PROP_UNIT_ADMINISTRATORS 
    ADD CONSTRAINT PK_PROP_UNIT_ADMINISTRATORS 
            PRIMARY KEY (PROP_UNIT_ADMINISTRATORS_ID) ;

-- *************** UNIQUE CONSTRAINT DEFINED FOR COMPOSITE KEY COLUMNS ************   
--ALTER TABLE PROP_UNIT_ADMINISTRATORS 
--    ADD CONSTRAINT UQ_PROP_UNIT_ADMINISTRATORS 
--            UNIQUE (PROPOSAL_NUMBER, SEQUENCE_NUMBER, UNIT_ADMINISTRATOR_TYPE_CODE, ADMINISTRATOR) ;
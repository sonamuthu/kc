CREATE TABLE SCIENCE_KEYWORD
(
   SCIENCE_KEYWORD_CODE VARCHAR(15) CONSTRAINT SCIENCE_KEYWORD_N1 not null,
   DESCRIPTION VARCHAR2(200) CONSTRAINT SCIENCE_KEYWORD_N2 not null,
   UPDATE_TIMESTAMP DATE CONSTRAINT SCIENCE_KEYWORD_N3 not null,
   UPDATE_USER VARCHAR2(60) CONSTRAINT SCIENCE_KEYWORD_N4 not null,
   VER_NBR NUMBER(8,0) DEFAULT 1 CONSTRAINT SCIENCE_KEYWORD_N5 NOT NULL,
   OBJ_ID VARCHAR2(36) DEFAULT SYS_GUID() CONSTRAINT SCIENCE_KEYWORD_N6 NOT NULL,
   CONSTRAINT SCIENCE_KEYWORD_TP1 PRIMARY KEY (SCIENCE_KEYWORD_CODE),
   CONSTRAINT SCIENCE_KEYWORD_TC0 UNIQUE (OBJ_ID)
);
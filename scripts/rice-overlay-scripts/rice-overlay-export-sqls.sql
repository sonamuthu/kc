-- EXPORT SQLS
SELECT * FROM KRNS_NMSPC_T WHERE NMSPC_CD LIKE 'KC%';
SELECT * FROM KRNS_PARM_DTL_TYP_T WHERE NMSPC_CD LIKE 'KC%';
SELECT * FROM KRNS_PARM_T WHERE NMSPC_CD LIKE 'KC%';

--select min(entity_id) from krim_prncpl_t where prncpl_nm not in ('kr', 'admin', 'notsys', 'quickstart', 'kc')
--10001
--select max(entity_id) from krim_prncpl_t where prncpl_nm not in ('kr', 'admin', 'notsys', 'quickstart', 'kc');
--10082

SELECT PHONE_TYP_CD, PHONE_TYP_NM, ACTV_IND, DISPLAY_SORT_CD, OBJ_ID, VER_NBR FROM KRIM_PHONE_TYP_T WHERE PHONE_TYP_CD = 'FAX';
SELECT AFLTN_TYP_CD, NM, EMP_AFLTN_TYP_IND, ACTV_IND, DISPLAY_SORT_CD, OBJ_ID, VER_NBR FROM KRIM_AFLTN_TYP_T WHERE AFLTN_TYP_CD NOT IN ('STDNT', 'FCLTY', 'STAFF', 'AFLT' ) ORDER BY DISPLAY_SORT_CD;

SELECT 'KC'||ENTITY_ID AS ENTITY_ID, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083
UNION 
SELECT 'KC'||ENTITY_ID AS ENTITY_ID, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_ENT_TYP_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_ENT_TYP_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_NM_ID AS ENTITY_NM_ID, 'KC'||ENTITY_ID AS ENTITY_ID, NM_TYP_CD, FIRST_NM, MIDDLE_NM, LAST_NM, SUFFIX_NM, TITLE_NM, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_NM_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_NM_ID AS ENTITY_NM_ID, 'KC'||ENTITY_ID AS ENTITY_ID, NM_TYP_CD, FIRST_NM, MIDDLE_NM, LAST_NM, SUFFIX_NM, TITLE_NM, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_NM_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_ADDR_ID AS ENTITY_ADDR_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, ADDR_TYP_CD, ADDR_LINE_1, ADDR_LINE_2, ADDR_LINE_3, CITY_NM, POSTAL_STATE_CD, POSTAL_CD, POSTAL_CNTRY_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_ADDR_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_ADDR_ID AS ENTITY_ADDR_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, ADDR_TYP_CD, ADDR_LINE_1, ADDR_LINE_2, ADDR_LINE_3, CITY_NM, POSTAL_STATE_CD, POSTAL_CD, POSTAL_CNTRY_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_ADDR_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_AFLTN_ID AS ENTITY_AFLTN_ID, 'KC'||ENTITY_ID AS ENTITY_ID, AFLTN_TYP_CD, CAMPUS_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_AFLTN_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION
SELECT 'KC'||ENTITY_AFLTN_ID AS ENTITY_AFLTN_ID, 'KC'||ENTITY_ID AS ENTITY_ID, AFLTN_TYP_CD, CAMPUS_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_AFLTN_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_EMP_ID AS ENTITY_EMP_ID, 'KC'||ENTITY_ID AS ENTITY_ID, DECODE(ENTITY_AFLTN_ID, NULL, 'NULL', '', 'NULL', 'KC'||ENTITY_AFLTN_ID) AS ENTITY_AFLTN_ID, DECODE(EMP_STAT_CD, NULL, 'NULL', '', 'NULL', EMP_STAT_CD) AS EMP_STAT_CD, DECODE(EMP_TYP_CD, NULL, 'NULL', '', 'NULL', EMP_TYP_CD) AS EMP_TYP_CD, PRMRY_IND, ACTV_IND, PRMRY_DEPT_CD, EMP_ID, EMP_REC_ID, OBJ_ID, VER_NBR FROM KRIM_ENTITY_EMP_INFO_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_EMP_ID AS ENTITY_EMP_ID, 'KC'||ENTITY_ID AS ENTITY_ID, DECODE(ENTITY_AFLTN_ID, NULL, 'NULL', '', 'NULL', 'KC'||ENTITY_AFLTN_ID) AS ENTITY_AFLTN_ID, DECODE(EMP_STAT_CD, NULL, 'NULL', '', 'NULL', EMP_STAT_CD) AS EMP_STAT_CD, DECODE(EMP_TYP_CD, NULL, 'NULL', '', 'NULL', EMP_TYP_CD) AS EMP_TYP_CD, PRMRY_IND, ACTV_IND, PRMRY_DEPT_CD, EMP_ID, EMP_REC_ID, OBJ_ID, VER_NBR FROM KRIM_ENTITY_EMP_INFO_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_EMAIL_ID AS ENTITY_EMAIL_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, EMAIL_TYP_CD, EMAIL_ADDR, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_EMAIL_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_EMAIL_ID AS ENTITY_EMAIL_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, EMAIL_TYP_CD, EMAIL_ADDR, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_EMAIL_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT 'KC'||ENTITY_PHONE_ID AS ENTITY_PHONE_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, PHONE_TYP_CD, PHONE_NBR, PHONE_EXTN_NBR, POSTAL_CNTRY_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_PHONE_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||ENTITY_PHONE_ID AS ENTITY_PHONE_ID, 'KC'||ENTITY_ID AS ENTITY_ID, ENT_TYP_CD, PHONE_TYP_CD, PHONE_NBR, PHONE_EXTN_NBR, POSTAL_CNTRY_CD, DFLT_IND, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ENTITY_PHONE_T WHERE ENTITY_ID = (SELECT ENTITY_ID FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC');

SELECT PRNCPL_ID AS PRNCPL_ID, 'kc'||PRNCPL_NM AS PRNCPL_NM, 'KC'||ENTITY_ID AS ENTITY_ID, PRNCPL_PSWD, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_PRNCPL_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083 
UNION 
SELECT 'KC'||PRNCPL_ID AS PRNCPL_ID, PRNCPL_NM AS PRNCPL_NM, 'KC'||ENTITY_ID AS ENTITY_ID, PRNCPL_PSWD, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_PRNCPL_T WHERE UPPER(PRNCPL_NM) = 'KC';


SELECT 'KC'||KIM_ATTR_DEFN_ID AS KIM_ATTR_DEFN_ID, NM, LBL, ACTV_IND, NMSPC_CD, CMPNT_NM, OBJ_ID, VER_NBR FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%';
SELECT 'KC'||KIM_TYP_ID AS KIM_TYP_ID, NM, SRVC_NM, ACTV_IND, NMSPC_CD, OBJ_ID, VER_NBR FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||KIM_TYP_ATTR_ID AS KIM_TYP_ATTR_ID, 'KC'||KIM_TYP_ID AS KIM_TYP_ID, 
   CASE WHEN KIM_ATTR_DEFN_ID IN (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_ATTR_DEFN_ID 
   ELSE KIM_ATTR_DEFN_ID END AS KIM_ATTR_DEFN_ID,  
SORT_CD, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_TYP_ATTR_T WHERE KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||PERM_TMPL_ID AS PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'|| KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  
ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_PERM_TMPL_T WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||PERM_ID AS PERM_ID, NMSPC_CD, NM, DESC_TXT, 
   CASE WHEN PERM_TMPL_ID IN (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||PERM_TMPL_ID 
   ELSE PERM_TMPL_ID END AS PERM_TMPL_ID, 
ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_PERM_T  WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||ATTR_DATA_ID AS ATTR_DATA_ID, 'KC'||PERM_ID AS PERM_ID, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  

   CASE WHEN KIM_ATTR_DEFN_ID IN (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_ATTR_DEFN_ID 
   ELSE KIM_ATTR_DEFN_ID END AS KIM_ATTR_DEFN_ID,  
ATTR_VAL, OBJ_ID, VER_NBR FROM KRIM_PERM_ATTR_DATA_T WHERE PERM_ID IN (SELECT PERM_ID FROM KRIM_PERM_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||ROLE_ID AS ROLE_ID, ROLE_NM, NMSPC_CD, DESC_TXT, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  

ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||ROLE_MBR_ID AS ROLE_MBR_ID, 
   CASE WHEN ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||ROLE_ID 
   ELSE ROLE_ID END AS ROLE_ID,  

   CASE 
   WHEN MBR_ID IN (SELECT PRNCPL_ID FROM KRIM_PRNCPL_T WHERE PRNCPL_NM IN ('kc'))  
   THEN 'KC'||MBR_ID  
   WHEN MBR_ID IN (SELECT GRP_ID FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%')  
   THEN 'KC'||MBR_ID 
   WHEN MBR_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%')  
   THEN 'KC'||MBR_ID 
   ELSE MBR_ID END AS MBR_ID, 
    
MBR_TYP_CD, OBJ_ID, VER_NBR FROM KRIM_ROLE_MBR_T  WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||ATTR_DATA_ID AS ATTR_DATA_ID, 'KC'||ROLE_MBR_ID AS ROLE_MBR_ID, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  
 
   CASE WHEN KIM_ATTR_DEFN_ID IN (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_ATTR_DEFN_ID 
   ELSE KIM_ATTR_DEFN_ID END AS KIM_ATTR_DEFN_ID,  

ATTR_VAL, OBJ_ID, VER_NBR FROM KRIM_ROLE_MBR_ATTR_DATA_T WHERE ROLE_MBR_ID IN (SELECT DISTINCT ROLE_MBR_ID FROM KRIM_ROLE_MBR_T WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%'));

SELECT 'KC'||ROLE_PERM_ID AS ROLE_PERM_ID, 
   CASE WHEN ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||ROLE_ID 
   ELSE ROLE_ID END AS ROLE_ID,  

   CASE WHEN PERM_ID IN (SELECT PERM_ID FROM KRIM_PERM_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||PERM_ID 
   ELSE PERM_ID END AS PERM_ID,  
ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ROLE_PERM_T WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||GRP_ID AS GRP_ID, GRP_NM, NMSPC_CD, GRP_DESC, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  

ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||GRP_MBR_ID AS GRP_MBR_ID, 'KC'||GRP_ID AS GRP_ID, 
   CASE 
   WHEN MBR_ID IN (SELECT PRNCPL_ID FROM KRIM_PRNCPL_T WHERE PRNCPL_NM IN ('kc'))  
   THEN 'KC'||MBR_ID  
   WHEN MBR_ID IN (SELECT GRP_ID FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%')  
   THEN 'KC'||MBR_ID 
   WHEN MBR_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%')  
   THEN 'KC'||MBR_ID 
   ELSE MBR_ID END AS MBR_ID, 
MBR_TYP_CD, OBJ_ID, VER_NBR FROM KRIM_GRP_MBR_T WHERE GRP_ID IN (SELECT GRP_ID FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||RSP_ID AS RSP_ID, NMSPC_CD, NM, DESC_TXT, ACTV_IND, RSP_TMPL_ID, OBJ_ID, VER_NBR FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%';

SELECT 'KC'||ROLE_RSP_ID AS ROLE_RSP_ID, 'KC'||ROLE_ID AS ROLE_ID, 'KC'||RSP_ID AS RSP_ID, ACTV_IND, OBJ_ID, VER_NBR FROM KRIM_ROLE_RSP_T WHERE (ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%')) OR (RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%'));

SELECT 'KC'||ATTR_DATA_ID AS ATTR_DATA_ID, 'KC'||RSP_ID AS RSP_ID, 
   CASE WHEN KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_TYP_ID 
   ELSE KIM_TYP_ID END AS KIM_TYP_ID,  

   CASE WHEN KIM_ATTR_DEFN_ID IN (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%') 
   THEN 'KC'||KIM_ATTR_DEFN_ID 
   ELSE KIM_ATTR_DEFN_ID END AS KIM_ATTR_DEFN_ID,  

ATTR_VAL, OBJ_ID, VER_NBR FROM KRIM_RSP_ATTR_DATA_T WHERE RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%');

SELECT 'KC'||ROLE_RSP_ACTN_ID AS ROLE_RSP_ACTN_ID, 'KC'||ROLE_RSP_ID AS ROLE_RSP_ID, DECODE(ROLE_MBR_ID, '*', ROLE_MBR_ID, 'KC'||ROLE_MBR_ID) AS ROLE_MBR_ID, ACTN_TYP_CD, PRIORITY_NBR, ACTN_PLCY_CD, FRC_ACTN, OBJ_ID, VER_NBR FROM KRIM_ROLE_RSP_ACTN_T WHERE ROLE_RSP_ID IN (SELECT ROLE_RSP_ID FROM KRIM_ROLE_RSP_T WHERE RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%'));

SELECT CHNL_ID, NM, DESC_TXT, SUBSCRB_IND, VER_NBR FROM KREN_CHNL_T WHERE NM LIKE 'KC%';

SELECT PRODCR_ID, NM, DESC_TXT, CNTCT_INFO, VER_NBR FROM KREN_PRODCR_T  WHERE NM LIKE 'KC%'; -- Notification System
SELECT CHNL_ID, PRODCR_ID FROM KREN_CHNL_PRODCR_T WHERE CHNL_ID IN (SELECT CHNL_ID FROM KREN_CHNL_T WHERE NM LIKE 'KC%');

-- CLEANUP SQLS
DELETE FROM KRNS_PARM_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRNS_PARM_DTL_TYP_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRNS_NMSPC_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_ENTITY_EMAIL_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_EMP_INFO_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_PHONE_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_ADDR_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_NM_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_ENT_TYP_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_PRNCPL_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_ENTITY_T WHERE ENTITY_ID > 10000 AND ENTITY_ID < 10083;
DELETE FROM KRIM_PHONE_TYP_T WHERE PHONE_TYP_CD = 'FAX';
DELETE FROM KRIM_GRP_MBR_T WHERE GRP_ID IN (SELECT GRP_ID FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_GRP_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_ROLE_PERM_T WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_ROLE_MBR_ATTR_DATA_T WHERE ROLE_MBR_ID IN (SELECT DISTINCT ROLE_MBR_ID FROM KRIM_ROLE_MBR_T WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%'));
DELETE FROM KRIM_ROLE_MBR_T  WHERE ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_ROLE_RSP_ACTN_T WHERE ROLE_RSP_ID IN (SELECT ROLE_RSP_ID FROM KRIM_ROLE_RSP_T WHERE RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%'));
DELETE FROM KRIM_ROLE_RSP_T WHERE (ROLE_ID IN (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD LIKE 'KC%')) OR (RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%'));
DELETE FROM KRIM_RSP_ATTR_DATA_T WHERE RSP_ID IN (SELECT RSP_ID FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_RSP_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_PERM_ATTR_DATA_T WHERE PERM_ID IN (SELECT PERM_ID FROM KRIM_PERM_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_PERM_T  WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_PERM_TMPL_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_TYP_ATTR_T WHERE KIM_TYP_ID IN (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%');
DELETE FROM KRIM_TYP_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KRIM_ATTR_DEFN_T WHERE NMSPC_CD LIKE 'KC%';
DELETE FROM KREN_CHNL_PRODCR_T WHERE CHNL_ID IN (SELECT CHNL_ID FROM KREN_CHNL_T WHERE NM LIKE 'KC%');
DELETE FROM KREN_CHNL_T WHERE NM LIKE 'KC%';
COMMIT;

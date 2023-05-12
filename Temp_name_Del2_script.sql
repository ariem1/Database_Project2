CREATE DATABASE NONPROFIT_ORG
USE NONPROFIT_ORG;

--CREATE VOLUNTEER ENTITY
CREATE TABLE VOLUNTEER (
VOLUNTEER_ID CHAR(6) CONSTRAINT VOLUNTEER_VOLUNTEER_ID_PK PRIMARY KEY ,
VOLUNTEER_FNAME VARCHAR(20),
VOLUNTEER_LNAME VARCHAR(20),
PHONE_NUMBER CHAR(10),
STREET VARCHAR(20),
CITY VARCHAR(20),
COUNTRY CHAR(2),
POSTAL_CODE VARCHAR(6) );

--SEQUENCE FOR VOLUNTEER 
CREATE SEQUENCE VOLUNTEER_SQ
START WITH 10010
INCREMENT BY 1;

--CREATE TASK ENTITY
CREATE TABLE TASK(
TASK_NUM CHAR(6) CONSTRAINT TASK_TASK_NUM_PK PRIMARY KEY,
TASK_DESCRIPTION VARCHAR(20) NOT NULL,
TASK_STATUS VARCHAR(15) NOT NULL );

--CREATE ASSIGNMENT ENTITY
CREATE TABLE ASSIGNMENT(
VOLUNTEER_ID CHAR(6) CONSTRAINT ASSIGNMENT_VOLUNTEER_ID_FK FOREIGN KEY (VOLUNTEER_ID) REFERENCES VOLUNTEER ON DELETE CASCADE,
TASK_NUM CHAR(6) CONSTRAINT ASSIGNMENT_TASK_NUM_FK FOREIGN KEY (TASK_NUM) REFERENCES TASK ON DELETE CASCADE,
TASK_START_DATE DATE,
TASK_START_TIME CHAR(5),
TASK_END_DATE DATE,
TASK_END_TIME CHAR(5),
CONSTRAINT ASSIGNMENT_VOLUNTEERID_TASKNUM_PK PRIMARY KEY (VOLUNTEER_ID,TASK_NUM) );

--CREATE PACKAGE ENTITY
CREATE TABLE PACKAGE(
PACKAGE_NUM CHAR(6) CONSTRAINT PACKAGE_PACKAGE_NUM_PK PRIMARY KEY,
DATE_CREATED DATE NOT NULL,
TOTAL_WEIGHT NUMERIC (6,2) NOT NULL,
TASK_NUM CHAR(6) CONSTRAINT PACKAGE_TASK_NUM_FK FOREIGN KEY (TASK_NUM) REFERENCES TASK ON DELETE SET NULL );

-- CREATE ITEM ENTITY
CREATE TABLE ITEM(
ITEM_ID CHAR(6) CONSTRAINT ITEM_ITEM_ID_PK  PRIMARY KEY ,
ITEM_DESCRIPTION VARCHAR(50) NOT NULL,
ITEM_VALUE NUMERIC(5,2),
ITEM_QUANTITY INT IDENTITY (5, 5));

--CREATE CONTENTS ENTITY
CREATE TABLE CONTENTS(
PACKAGE_NUM CHAR(6) CONSTRAINT CONTENTS_PACKAGE_NUM_FK FOREIGN KEY (PACKAGE_NUM) REFERENCES PACKAGE ON DELETE CASCADE,
ITEM_ID CHAR(6),
CONSTRAINT CONTENTS_PACKAGENUM_ITEMID_PK PRIMARY KEY (PACKAGE_NUM, ITEM_ID) );


--ALTER STATEMENTS
ALTER TABLE CONTENTS
ADD CONSTRAINT CONTENTS_ITEM_ID_FK FOREIGN KEY (ITEM_ID) REFERENCES ITEM ON DELETE CASCADE;

ALTER TABLE ITEM
ALTER COLUMN ITEM_VALUE NUMERIC(5,2) NOT NULL;

--CREATING INDEXES
CREATE INDEX VOLUNTEER_FNAME_INDX ON VOLUNTEER (VOLUNTEER_FNAME);

CREATE INDEX TASK_NUM_INDX ON TASK (TASK_NUM);

--INSERT VALUES
INSERT INTO VOLUNTEER VALUES (NEXT VALUE FOR VOLUNTEER_SQ,'Josh','Owen','7053242559','3755 40th Street','Calgary','CA', 'T2K0P7');
INSERT INTO VOLUNTEER VALUES (NEXT VALUE FOR VOLUNTEER_SQ,'Tamara','Wallace','2635722221','1342 Rene-Levesques','Montreal','CA', 'H3B4W8');
INSERT INTO VOLUNTEER VALUES (NEXT VALUE FOR VOLUNTEER_SQ,'Kye','Shaw','4748981353','4331 Galts Avenue','Alberta','CA', 'T4N5Z9');
INSERT INTO VOLUNTEER VALUES (NEXT VALUE FOR VOLUNTEER_SQ,'Alexa','Neal','2269922923','187 rue Garneau','Quebec','CA', 'G1V3V5');
INSERT INTO VOLUNTEER VALUES (NEXT VALUE FOR VOLUNTEER_SQ,'Christian','Carrillo','2046964326','2878 Carlson Road','Prince George','CA', 'V2L5E5');

INSERT INTO TASK VALUES ('01','Receiving','Complete');
INSERT INTO TASK VALUES ('02','Creating','In progress');
INSERT INTO TASK VALUES ('03','Packing','In progress');
INSERT INTO TASK VALUES ('04','Checking ','In progress');
INSERT INTO TASK VALUES ('05','Shipping','In progress');

INSERT INTO ASSIGNMENT VALUES ((SELECT VOLUNTEER_ID FROM VOLUNTEER WHERE VOLUNTEER_FNAME = 'Josh'),'01',GETDATE(),'11:20', GETDATE(),'11:25');
INSERT INTO ASSIGNMENT VALUES ((SELECT VOLUNTEER_ID FROM VOLUNTEER WHERE VOLUNTEER_FNAME = 'Tamara'),'02', GETDATE(),'11:30',NULL, NULL);
INSERT INTO ASSIGNMENT VALUES ((SELECT VOLUNTEER_ID FROM VOLUNTEER WHERE VOLUNTEER_FNAME = 'Kye'),'03', GETDATE(), '8:30' , NULL , NULL);
INSERT INTO ASSIGNMENT VALUES ((SELECT VOLUNTEER_ID FROM VOLUNTEER WHERE VOLUNTEER_FNAME = 'Alexa'),'04', GETDATE(), '9:45', NULL , NULL);
INSERT INTO ASSIGNMENT VALUES ((SELECT VOLUNTEER_ID FROM VOLUNTEER WHERE VOLUNTEER_FNAME = 'Christian'),'05', GETDATE(),'17:00', NULL, NULL);

INSERT INTO PACKAGE VALUES ('001','2020-03-06','6','01');
INSERT INTO PACKAGE VALUES ('002','2020-03-08','6','03');
INSERT INTO PACKAGE VALUES ('003','2020-03-09','6','04');
INSERT INTO PACKAGE VALUES ('004','2020-03-11','6','02');
INSERT INTO PACKAGE VALUES ('005','2020-03-15','6','05');

INSERT INTO ITEM VALUES ('I00001','Canned Goods','0.99');
INSERT INTO ITEM VALUES ('I00002', 'Instant Noodles','0.99');
INSERT INTO ITEM VALUES ('I00003', 'Blankets','10.50');
INSERT INTO ITEM VALUES ('I00004', 'Shirts','3.50');
INSERT INTO ITEM VALUES ('I00005', 'Hygiene Kit','1.00');

INSERT INTO CONTENTS VALUES ('001', 'I00005');
INSERT INTO CONTENTS VALUES ('002', 'I00003');
INSERT INTO CONTENTS VALUES ('003', 'I00002');
INSERT INTO CONTENTS VALUES ('004', 'I00001');
INSERT INTO CONTENTS VALUES ('005', 'I00004');


--explain why on delete is like that

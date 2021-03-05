
--ΘΕΜΑ 1:

CREATE TABLE AGENTS(
	AFM INT NOT NULL,
	FULL_NAME VARCHAR(40),
	HIRE_DATE DATE,
	PRIMARY KEY (AFM)
);

ALTER TABLE CONTRACTS ADD(AGENT_AFM INT);
ALTER TABLE CONTRACTS
ADD FOREIGN KEY(AGENT_AFM) REFERENCES AGENTS(AFM);

INSERT INTO AGENTS VALUES
(1234, 'Giorgos Kwstakis', '2020-5-10'),
(5341, 'Kwstis MAkis', '2019-5-10');

UPDATE CONTRACTS 
SET AGENT_AFM = 1234
WHERE AFM = 18390008;

UPDATE CONTRACTS 
SET AGENT_AFM = 5341
WHERE AFM = 18390037;



--ΘΕΜΑ 2:

DELIMITER //
CREATE PROCEDURE thema2(agentAFM INT)
BEGIN
DECLARE startrow INT DEFAULT 0;
DECLARE endrow INT DEFAULT 0;
DECLARE contractscount INT DEFAULT 0;
DECLARE totalprofit INT DEFAULT 0;
DECLARE cost INT DEFAULT 0;
DECLARE icode INT;
DECLARE startdate DATE;
DECLARE enddate DATE;
DECLARE AFMcust INT;
DECLARE AFMag INT;
DECLARE contractptr CURSOR FOR SELECT * from CONTRACTS;
SELECT COUNT(*) FROM CONTRACTS INTO endrow;
SET startrow := 0;
SET contractscount := 0;
SET totalprofit := 0;
OPEN contractptr;
WHILE (startrow < endrow) DO
	FETCH contractptr INTO AFMcust, icode, startdate, enddate, AFMag;
    SELECT COST_YEARLY FROM INSURANCE_COVERS WHERE INSUR_CODE = icode INTO cost;
    
	IF (AFMag = agentAFM) THEN
		SET contractscount := contractscount + 1;
		SET totalprofit := totalprofit + cost;
	END IF;
    
    SET startrow := startrow + 1;
END WHILE;
SELECT contractscount AS 'Contracts taken', totalprofit*(0.4) AS 'Contracts profit';
END//
DELIMITER ;

CALL thema2(1234);
CALL thema2(5341);

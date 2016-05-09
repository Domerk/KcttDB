PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ��������;
DROP TABLE IF EXISTS �������������;
DROP TABLE IF EXISTS ��������������;
DROP TABLE IF EXISTS �����������;
DROP TABLE IF EXISTS ������;
DROP TABLE IF EXISTS ��������;

CREATE TABLE �������� (
-- ����
`ID`      			INTEGER			PRIMARY KEY			AUTOINCREMENT,
`�������`			VARCHAR(60)		NOT NULL,
`���`				VARCHAR(60)		NOT NULL,
`��������`		    VARCHAR(60),
`��� ���������`	  	VARCHAR(60)		NOT NULL,
`����� ���������`	VARCHAR(60)		NOT NULL,
`���`			    VARCHAR(3)		NOT NULL,
`��� ��������`	  	DATE,

`����� �����`		  VARCHAR(60),
`�����`			      VARCHAR(60),
`�����`			      VARCHAR(5),

`��������`		    VARCHAR(200),
`�������� �����`	VARCHAR(200),
`�������`   			VARCHAR(100),
`e-mail`     			VARCHAR(100),

`���� ���������`	DATE,
`����� ��������`	VARCHAR(60),
`����� �����`		DATE,

`� ����������� ���������` 	BOOLEAN,
`������`    			BOOLEAN,
`�������`   			BOOLEAN,
`�� ����� � �������`		BOOLEAN,
`����������� �����`	      	BOOLEAN,
`�������� �����`      		BOOLEAN,
`���������������� �����`  	BOOLEAN,
`��������`    		BOOLEAN,


`����������`  		VARCHAR(200)
);

CREATE TABLE ������������� (
`ID` 				INTEGER			PRIMARY KEY			AUTOINCREMENT,
`�������`   		VARCHAR(60)		NOT NULL,
`���`     			VARCHAR(60)		NOT NULL,
`��������`    		VARCHAR(60),
`�������`			VARCHAR(60)		NOT NULL,
`�����`     		VARCHAR(60)
);

CREATE TABLE �������������� (
`ID` 			INTEGER				PRIMARY KEY			AUTOINCREMENT,
`��������`	VARCHAR(60)		NOT NULL
);

CREATE TABLE ����������� (
`ID` 			INTEGER				PRIMARY KEY			AUTOINCREMENT,
`��������`		VARCHAR(60)		NOT NULL,
`�����`			  	VARCHAR(60)		NOT NULL,
`��������`		VARCHAR(300),
`ID ��������������` INTEGER,

FOREIGN KEY (`ID ��������������`)	REFERENCES ��������������(`ID`)
);

CREATE TABLE ������ (
`ID` 				INTEGER			PRIMARY KEY			AUTOINCREMENT,
`ID �����������` 	INTEGER,
`ID �������������` 	INTEGER,
`�����`			   	VARCHAR(30),
`��� ��������`		INTEGER,

FOREIGN KEY (`ID �����������`) 		REFERENCES �����������(`ID`)		ON DELETE CASCADE,
FOREIGN KEY (`ID �������������`)	REFERENCES �������������(`ID`)		ON DELETE CASCADE
);

CREATE TABLE �������� (
`ID ���������`	INTEGER,
`ID ������` 	INTEGER,

PRIMARY KEY (`ID ���������`, `ID ������`),
FOREIGN KEY (`ID ���������`) 	REFERENCES ��������(`ID`) 	ON DELETE CASCADE,
FOREIGN KEY (`ID ������`)		REFERENCES ������(`ID`)		ON DELETE CASCADE
);


-- �������������

DROP VIEW IF EXISTS �����������;
CREATE VIEW ����������� AS
	SELECT �����������.`ID` `ID`, ��������������.`ID` `ID ��������������`, �����������.`��������` `��������`, ��������������.`��������` `��������������`, �����������.`�����` `�����`,  �����������.`��������` `��������`
	FROM �����������, ��������������
	WHERE �����������.`ID ��������������` = ��������������.`ID`
;

DROP VIEW IF EXISTS ������;
CREATE VIEW ������ AS 
	SELECT ������.`ID` `ID`, ������.`ID �������������` `ID �������������`, ������.`�����` `�����`, ������.`��� ��������` `��� ��������`, �����������.`ID` `ID �����������`, �����������.`��������` `�����������`, �������������.`�������` `������� �������������`, �������������.`���` `��� �������������`, �������������.`��������` `�������� �������������`
	FROM ������, �����������, �������������
	WHERE ������.`ID �����������` = �����������.`ID`
	AND ������.`ID �������������` = �������������.`ID`
;


DROP VIEW IF EXISTS ������_�����;
CREATE VIEW ������_����� AS
	SELECT ������.`ID` `ID ������`, ��������.`ID` `ID ���������`, ������.`�����` `����� ������`, ��������.`�������` `�������`, ��������.`���` `���`, ��������.`��������` `��������`, ��������.`�������` `�������`, ��������.`e-mail` `e-mail`
	FROM ������, ��������, ��������
	WHERE ������.`ID` = ��������.`ID ������`
	AND ��������.`ID` = ��������.`ID ���������`
;

DROP VIEW IF EXISTS �������������_�����;
CREATE VIEW �������������_����� AS
	SELECT ������.`ID`, �������������.`ID`, ������.`����� ������`, �������������.`���`, �������������.`�������`, �������������.`��������`, �������������.`�����` 
	FROM ������, �������������
	WHERE ������.`ID �������������` = �������������.`ID`
	GROUP BY (�������������.`ID`)
;

-- ��������

DROP TRIGGER IF EXISTS AllInsertTrigger;
CREATE TRIGGER AllInsertTrigger
 AFTER INSERT ON �����������
 BEGIN 
	INSERT INTO ������ (`�����`,`ID �����������`) VALUES ("��� ������", (SELECT `ID` FROM ����������� WHERE `��������` = NEW.`��������`));
 END;
 
 -- ��� ��� ����� �� �������� (�� ��������!), ����� �������� � ���-�� �����
 
 DROP TRIGGER IF EXISTS AllDeleteTrigger;
 CREATE TRIGGER AllDeleteTrigger
 BEFORE DELETE ON �����������
 BEGIN 
	DELETE FROM ����������e WHERE `ID` = OLD.`ID`;
 END;
 
-- ������� ������

INSERT INTO ��������(`ID`, `��� ���������`, `����� ���������`, `�������`, `���`, `���`) VALUES ("0", "�������", "123", "������", "����", "���");
INSERT INTO ��������(`ID`, `��� ���������`, `����� ���������`, `�������`, `���`, `���`) VALUES ("1", "�������", "124", "������", "�������", "���");
INSERT INTO ��������(`ID`, `��� ���������`, `����� ���������`, `�������`, `���`, `���`) VALUES ("2", "�������", "125", "������", "�������", "���");
INSERT INTO ��������(`ID`, `��� ���������`, `����� ���������`, `�������`, `���`, `���`) VALUES ("3", "�������", "126", "���������", "������", "���");
INSERT INTO ��������(`ID`, `��� ���������`, `����� ���������`, `�������`, `���`, `���`) VALUES ("4", "������������� � ��������", "111", "�������", "�����", "���");

INSERT INTO �������������(`ID`, `�������`, `�������`, `���`) VALUES ("0", "200", "������", "�������");
INSERT INTO �������������(`ID`, `�������`, `�������`, `���`) VALUES ("1", "201", "�����", "�����");
INSERT INTO �������������(`ID`, `�������`, `�������`, `���`) VALUES ("3", "202", "�������", "���");
INSERT INTO �������������(`ID`, `�������`, `�������`, `���`) VALUES ("4", "203", "�������", "�����");

INSERT INTO �������������� (`��������`) VALUES ("�����������");
INSERT INTO �������������� (`��������`) VALUES ("��������������");
INSERT INTO �������������� (`��������`) VALUES ("������������-����������");



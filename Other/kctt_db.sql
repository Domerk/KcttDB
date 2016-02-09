PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ��������;
DROP TABLE IF EXISTS �������������;
DROP TABLE IF EXISTS �����������;
DROP TABLE IF EXISTS ������;
DROP TABLE IF EXISTS ��������;

CREATE TABLE �������� (
-- ����
"ID"      				INTEGER,
"��� ���������"	  VARCHAR(60)		NOT NULL,
"����� ���������"	VARCHAR(60)		NOT NULL,
"�������"			    VARCHAR(60)		NOT NULL,
"���"				      VARCHAR(60)		NOT NULL,
"��������"		    VARCHAR(60),
"���"			      	VARCHAR(1)		NOT NULL,
"��� ��������"	  DATE,

"���� ���������"	DATE,
"����� �����"		  DATE,

"����� �����"		  VARCHAR(60),
"�����"			      VARCHAR(60),
"�����"			      VARCHAR(5),

"��������"		    VARCHAR(200),
"�������� �����"	VARCHAR(200),
"�������"   			VARCHAR(100),
"e-mail"     			VARCHAR(100),

"������"    			BOOLEAN,
"�������"   			BOOLEAN,
"� ����������� ���������" 	BOOLEAN,
"�� ����� � �������"		  	BOOLEAN,
"����������� �����"	      	BOOLEAN,
"�������� �����"      			BOOLEAN,
"���������������� �����"  	BOOLEAN,
"��������"    		BOOLEAN,

"����� ��������"	VARCHAR(60),
"����������"  		VARCHAR(200),

-- ���������
PRIMARY KEY ("ID")
);

CREATE TABLE ������������� (
-- ����
"ID" 				      INTEGER,
"����� ��������"	VARCHAR(60)		NOT NULL,
"�������"   			VARCHAR(60)		NOT NULL,
"���"     				VARCHAR(60)		NOT NULL,
"��������"    		VARCHAR(60),
"�����"     			VARCHAR(60),

-- ���������
PRIMARY KEY ("ID")
);


CREATE TABLE ����������� (
-- ����
"ID" 				  INTEGER,
"��������"		VARCHAR(60)		NOT NULL,
"��������������"	VARCHAR(60)		NOT NULL,
"�����"			  VARCHAR(60)		NOT NULL,
"��������"		VARCHAR(300),

-- ���������
PRIMARY KEY ("ID")
);


CREATE TABLE ������ (
-- ����
"ID" 				       INTEGER,
"ID �����������" 	 INTEGER,
"ID �������������" INTEGER,
"����� ������"	   VARCHAR(30),

-- ���������
PRIMARY KEY ("ID"),
FOREIGN KEY ("ID �����������") 	REFERENCES �����������("ID")
FOREIGN KEY ("ID �������������")	REFERENCES �������������("ID")
);


CREATE TABLE �������� (
-- ����
"ID ���������"	 INTEGER,
"ID ������" 		 INTEGER,

-- ���������
PRIMARY KEY ("ID ���������", "ID ������"),
FOREIGN KEY ("ID ���������") 	REFERENCES ��������("ID")
FOREIGN KEY ("ID ������")	REFERENCES ������("ID")
);


-- �������������

DROP VIEW IF EXISTS ������_�����;
DROP VIEW IF EXISTS �������������_�����;


CREATE VIEW ������_����� AS
	SELECT ������."ID", ��������."ID", ������."����� ������", ��������."�������", ��������."���", ��������."��������", ��������."�������", ��������."e-mail"
	FROM ������, ��������, ��������
	WHERE ������."ID" = ��������."ID ������"
	AND ��������."ID" = ��������."ID ���������"
	GROUP BY (������."����� ������")
;

CREATE VIEW �������������_����� AS
	SELECT ������."ID", �������������."ID", ������."����� ������", �������������."���", �������������."�������", �������������."��������", �������������."�����" 
	FROM ������, �������������
	WHERE ������."ID �������������" = �������������."ID"
	GROUP BY (�������������."ID")
;
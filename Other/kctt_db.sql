﻿PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Учащиеся;
DROP TABLE IF EXISTS Преподаватели;
DROP TABLE IF EXISTS Направленности;
DROP TABLE IF EXISTS Объединение;
DROP TABLE IF EXISTS Группа;
DROP TABLE IF EXISTS Нагрузка;

CREATE TABLE Учащиеся (
-- Поля
`ID`      			INTEGER			PRIMARY KEY			AUTOINCREMENT,
`Фамилия`			VARCHAR(60)		NOT NULL,
`Имя`				VARCHAR(60)		NOT NULL,
`Отчество`		    VARCHAR(60),
`Тип документа`	  	VARCHAR(60)		NOT NULL,
`Номер документа`	VARCHAR(60)		NOT NULL,
`Пол`			    VARCHAR(3)		NOT NULL,
`Год рождения`	  	DATE,

`Район школы`		  VARCHAR(60),
`Школа`			      VARCHAR(60),
`Класс`			      VARCHAR(5),

`Родители`		    VARCHAR(200),
`Домашний адрес`	VARCHAR(200),
`Телефон`   			VARCHAR(100),
`e-mail`     			VARCHAR(100),

`Дата заявления`	DATE,
`Форма обучения`	VARCHAR(60),
`Когда выбыл`		DATE,

`С ослабленным здоровьем` 	BOOLEAN,
`Сирота`    			BOOLEAN,
`Инвалид`   			BOOLEAN,
`На учёте в полиции`		BOOLEAN,
`Многодетная семья`	      	BOOLEAN,
`Неполная семья`      		BOOLEAN,
`Малообеспеченная семья`  	BOOLEAN,
`Мигранты`    		BOOLEAN,


`Примечания`  		VARCHAR(200)
);

CREATE TABLE Преподаватели (
`ID` 				INTEGER			PRIMARY KEY			AUTOINCREMENT,
`Фамилия`   		VARCHAR(60)		NOT NULL,
`Имя`     			VARCHAR(60)		NOT NULL,
`Отчество`    		VARCHAR(60),
`Паспорт`			VARCHAR(60)		NOT NULL,
`Отдел`     		VARCHAR(60)
);

CREATE TABLE Направленности (
`ID` 			INTEGER				PRIMARY KEY			AUTOINCREMENT,
`Название`	VARCHAR(60)		NOT NULL
);

CREATE TABLE Объединение (
`ID` 			INTEGER				PRIMARY KEY			AUTOINCREMENT,
`Название`		VARCHAR(60)		NOT NULL,
`Отдел`			  	VARCHAR(60)		NOT NULL,
`Описание`		VARCHAR(300),
`ID Направленности` INTEGER,

FOREIGN KEY (`ID Направленности`)	REFERENCES Направленности(`ID`)
);

CREATE TABLE Группа (
`ID` 				INTEGER			PRIMARY KEY			AUTOINCREMENT,
`ID объединения` 	INTEGER,
`ID преподавателя` 	INTEGER,
`Номер`			   	VARCHAR(30),
`Год обучения`		INTEGER,

FOREIGN KEY (`ID объединения`) 		REFERENCES Объединение(`ID`)		ON DELETE CASCADE,
FOREIGN KEY (`ID преподавателя`)	REFERENCES Преподаватели(`ID`)		ON DELETE CASCADE
);

CREATE TABLE Нагрузка (
`ID учащегося`	INTEGER,
`ID группы` 	INTEGER,

PRIMARY KEY (`ID учащегося`, `ID группы`),
FOREIGN KEY (`ID учащегося`) 	REFERENCES Учащиеся(`ID`) 	ON DELETE CASCADE,
FOREIGN KEY (`ID группы`)		REFERENCES Группа(`ID`)		ON DELETE CASCADE
);


-- Предстваления

DROP VIEW IF EXISTS Объединения;
CREATE VIEW Объединения AS
	SELECT Объединение.`ID` `ID`, Направленности.`ID` `ID Направленности`, Объединение.`Название` `Название`, Направленности.`Название` `Направленность`, Объединение.`Отдел` `Отдел`,  Объединение.`Описание` `Описание`
	FROM Объединение, Направленности
	WHERE Объединение.`ID Направленности` = Направленности.`ID`
;

DROP VIEW IF EXISTS Группы;
CREATE VIEW Группы AS 
	SELECT Группа.`ID` `ID`, Группа.`ID преподавателя` `ID преподавателя`, Группа.`Номер` `Номер`, Группа.`Год обучения` `Год обучения`, Объединение.`ID` `ID объединения`, Объединение.`Название` `Объединение`, Преподаватели.`Фамилия` `Фамилия преподавателя`, Преподаватели.`Имя` `Имя преподавателя`, Преподаватели.`Отчество` `Отчество преподавателя`
	FROM Группа, Объединение, Преподаватели
	WHERE Группа.`ID объединения` = Объединение.`ID`
	AND Группа.`ID преподавателя` = Преподаватели.`ID`
;


DROP VIEW IF EXISTS Состав_групп;
CREATE VIEW Состав_групп AS
	SELECT Группа.`ID` `ID Группы`, Учащиеся.`ID` `ID Учащегося`, Группа.`Номер` `Номер группы`, Учащиеся.`Фамилия` `Фамилия`, Учащиеся.`Имя` `Имя`, Учащиеся.`Отчество` `Отчество`, Учащиеся.`Телефон` `Телефон`, Учащиеся.`e-mail` `e-mail`
	FROM Группа, Нагрузка, Учащиеся
	WHERE Группа.`ID` = Нагрузка.`ID группы`
	AND Учащиеся.`ID` = Нагрузка.`ID учащегося`
;

DROP VIEW IF EXISTS Преподаватели_групп;
CREATE VIEW Преподаватели_групп AS
	SELECT Группы.`ID`, Преподаватели.`ID`, Группы.`Номер группы`, Преподаватели.`Имя`, Преподаватели.`Фамилия`, Преподаватели.`Отчество`, Преподаватели.`Отдел` 
	FROM Группы, Преподаватели
	WHERE Группы.`ID преподавателя` = Преподаватели.`ID`
	GROUP BY (Преподаватели.`ID`)
;

-- Триггеры

DROP TRIGGER IF EXISTS AllInsertTrigger;
CREATE TRIGGER AllInsertTrigger
 AFTER INSERT ON Объединение
 BEGIN 
	INSERT INTO Группа (`Номер`,`ID объединения`) VALUES ("Без группы", (SELECT `ID` FROM Объединение WHERE `Название` = NEW.`Название`));
 END;
  
 DROP TRIGGER IF EXISTS AllDeleteTrigger;
 CREATE TRIGGER AllDeleteTrigger
 INSTEAD OF DELETE ON Объединения
 BEGIN 
	DELETE FROM Объединение WHERE `ID` = OLD.`ID`;
 END;
 
 DROP TRIGGER IF EXISTS GroupDeleteTrigger;
 CREATE TRIGGER GroupDeleteTrigger
 INSTEAD OF DELETE ON Группы
 BEGIN 
	DELETE FROM Группа WHERE `ID` = OLD.`ID`;
 END;
 
-- Примеры данных

INSERT INTO Учащиеся(`ID`, `Тип документа`, `Номер документа`, `Фамилия`, `Имя`, `Пол`) VALUES ("0", "Паспорт", "123", "Иванов", "Иван", "Муж");
INSERT INTO Учащиеся(`ID`, `Тип документа`, `Номер документа`, `Фамилия`, `Имя`, `Пол`) VALUES ("1", "Паспорт", "124", "Топчий", "Алексей", "Муж");
INSERT INTO Учащиеся(`ID`, `Тип документа`, `Номер документа`, `Фамилия`, `Имя`, `Пол`) VALUES ("2", "Паспорт", "125", "Герцев", "Алексей", "Муж");
INSERT INTO Учащиеся(`ID`, `Тип документа`, `Номер документа`, `Фамилия`, `Имя`, `Пол`) VALUES ("3", "Паспорт", "126", "Гусманова", "Мунира", "Жен");
INSERT INTO Учащиеся(`ID`, `Тип документа`, `Номер документа`, `Фамилия`, `Имя`, `Пол`) VALUES ("4", "Свидетельство о рождении", "111", "Петрова", "Мария", "Жен");

INSERT INTO Преподаватели(`ID`, `Паспорт`, `Фамилия`, `Имя`) VALUES ("0", "200", "Аксёнов", "Алексей");
INSERT INTO Преподаватели(`ID`, `Паспорт`, `Фамилия`, `Имя`) VALUES ("1", "201", "Сухов", "Роман");
INSERT INTO Преподаватели(`ID`, `Паспорт`, `Фамилия`, `Имя`) VALUES ("3", "202", "Каяндер", "Ася");
INSERT INTO Преподаватели(`ID`, `Паспорт`, `Фамилия`, `Имя`) VALUES ("4", "203", "Горелик", "Денис");

INSERT INTO Направленности (`Название`) VALUES ("Техническая");
INSERT INTO Направленности (`Название`) VALUES ("Художественная");
INSERT INTO Направленности (`Название`) VALUES ("Физкультурно-спортивная");



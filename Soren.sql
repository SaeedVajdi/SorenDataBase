CREATE DATABASE Soren;

CREATE TABLE `Soren`.`Person`(
    id integer PRIMARY KEY,
    FName char(30) NOT NULL,
    LName char(30) NOT NULL,
    EMail char(200) NOT NULL,
    Password char(30) NOT NULL,
    University char(200) NOT NULL,
    ProfilePhoto varchar(100),
    Type Char(1) NOT NULL,
    unique(EMail),
    CONSTRAINT CHK_PERSON CHECK(id>=1 AND Type IN ('s', 't'))
);

CREATE TABLE `Soren`.`Student`(
    id integer PRIMARY KEY,
    StudentCode int(9) NOT NULL,
    unique(StudentCode),
    FOREIGN KEY (id) REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_STUDENT CHECK(id>=1 AND Studentcode>=100000000)
);

CREATE TABLE `Soren`.`Professor`(
    id integer PRIMARY KEY,
    NationalCode bigint(10) NOT NULL,
    unique(NationalCode),
    FOREIGN KEY (id) REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_PROFESSOR CHECK(id>=1 AND NationalCode>=1000000000)
);

CREATE TABLE `Soren`.`Course`(
    id integer PRIMARY KEY,
    TeacherID int NOT NULL,
    Title char(50) NOT NULL,
    ExamDate datetime NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    FOREIGN KEY (TeacherID) REFERENCES Professor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_COURSE CHECK(id>=1 AND EndDate>StartDate AND ExamDate>StartDate)
);

CREATE TABLE `Soren`.`CourseStudents`(
    id integer PRIMARY KEY,
    CourseID int NOT NULL,
    StudentID int NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StudentID) REFERENCES Student(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_COURSESTUDENT CHECK(id>=1)
);

CREATE TABLE `Soren`.`Subjects`(
    id integer PRIMARY KEY,
    CourseID int NOT NULL,
    Title char(30) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_SUBJECT CHECK(id>=1)
);

CREATE TABLE `Soren`.`Exercise`(
    id integer PRIMARY KEY,
    SubjectID int NOT NULL,
    Title char(30) NOT NULL,
    Deadline datetime NOT NULL,
    Files varchar(100),
    Texts text(2000) NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_EXERCISE CHECK(id>=1)
);

CREATE TABLE `Soren`.`Answers`(
    id integer PRIMARY KEY,
    ExerciseID int NOT NULL,
    StudentID int NOT NULL,
    Files varchar(100),
    Texts text(2000) NOT NULL,
    FOREIGN KEY (ExerciseID) REFERENCES Exercise(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StudentID) REFERENCES Student(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_ANSWER CHECK(id>=1)
);

CREATE TABLE `Soren`.`Posts`(
    id integer PRIMARY KEY,
    CourseID int NOT NULL,
    PersonID int NOT NULL,
    Files varchar(100),
    Texts text(2000) NOT NULL,
    PostDate datetime DEFAULT NOW(),
    FOREIGN KEY (CourseID) REFERENCES Course(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PersonID) REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_POST CHECK(id>=1)
);

CREATE TABLE `Soren`.`Likes`(
    id integer PRIMARY KEY,
    PostID int NOT NULL,
    PersonID int NOT NULL,
    FOREIGN KEY (PostID) REFERENCES Posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PersonID) REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_LIKE CHECK(id>=1)
);

CREATE TABLE `Soren`.`Comments`(
    id integer PRIMARY KEY,
    PostID int NOT NULL,
    PersonID int NOT NULL,
    Texts text(2000) NOT NULL,
    FOREIGN KEY (PostID) REFERENCES Posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PersonID) REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_COMMENT CHECK(id>=1)
);

INSERT INTO `Soren`.`Person` VALUES
(1,'Saeed','Vajdi','saeedvajdi79@gmail.com',1234,'Kharazmi','','s'),
(2,'Amir','Vahdati','amirvahdati16@gmail.com',9850,'Kharazmi','','s'),
(3,'Atefeh','Arabi','atefeharabi@gmail.com',4433,'Kharazmi','','t'),
(4,'Ali','a','ali@gmail.com',3540,'Shahed','','s'),
(5,'Bahram','b','bahram@gmail.com',7685,'Sharif','','t'),
(6,'Kaveh','c','kaveh@gmail.com',6625,'Sharif','','s'),
(7,'Donya','d','donya@gmail.com',1244,'Tehran','','s'),
(8,'Elisa','e','elisa@gmail.com',1894,'Shahed','','s'),
(9,'Fatemeh','f','fatemeh@gmail.com',3434,'Sharif','','t'),
(10,'Zahra','g','zahra@gmail.com',8585,'Tehran','','s');

INSERT INTO `Soren`.`Student` VALUES
(1,982023029),(2,982023030),(4,111111111),
(6,222222222),(7,333333333),(8,444444444),
(10,555555555);

INSERT INTO `Soren`.`Professor` VALUES
(3,1234567899),(5,1111111111),(9,2222222222);

INSERT INTO `Soren`.`Course` VALUES
(1,3,'DataBase','2021-12-30 11:30','2021-08-01','2021-12-30'),
(2,5,'Computer Construction Principles','2022-01-25 08:30','2021-08-02','2022-01-25'),
(3,9,'Computer Architectur','2022-01-30 08:00','2021-08-05','2022-01-30');

INSERT INTO `Soren`.`CourseStudents` VALUES
(1,1,1),(2,1,2),(3,1,4),(4,1,6),(5,3,1),
(6,2,1),(7,3,2),(8,2,2),(9,3,10),(10,2,6),
(11,1,8),(12,1,10),(13,2,7);

INSERT INTO `Soren`.`Subjects` VALUES
(1,1,'Natural Join'),
(2,1,'Theta Join'),
(3,1,'Semi Join'),
(4,2,'Bottom-Up Parsing'),
(5,3,'CPU'),
(6,2,'Top-Down Parsing'),
(7,3,'Binary Numbers'),
(8,2,'LL(1) Grammers'),
(9,3,'Verilog'),
(10,2,'Scanning'),
(11,1,'SQL');

INSERT INTO `Soren`.`Exercise` VALUES
(1,1,'EXERCISE 1','1400-10-01','','EX1'),
(2,1,'EXERCISE 2','1400-10-06','','EX2'),
(3,2,'EXERCISE 3','1400-10-20','','EX3'),
(4,3,'EXERCISE 4','1400-11-01','','EX4'),
(5,8,'EXERCISE 5','1400-11-07','','EX5');

INSERT INTO `Soren`.`Answers` VALUES
(1,1,1,'','answer 1'),
(2,5,6,'','answer 2');

INSERT INTO `Soren`.`Posts` VALUES
(1,1,1,'','post 1',now()),
(2,2,1,'','post 2','1400-09-01'),
(3,1,4,'','post 3','1400-09-01'),
(4,2,1,'','post 4','1400-09-05'),
(5,3,10,'','post 5','1400-09-10'),
(6,1,3,'','post 6','1400-09-20'),
(7,2,5,'','post 7','1400-09-23'),
(8,3,9,'','post 8','1400-09-25');

INSERT INTO `Soren`.`Likes` VALUES 
(1,1,2),(2,1,3),(3,1,4),
(4,2,1),(5,2,6),(6,2,5),
(7,3,10),(8,3,9),(9,3,9);

INSERT INTO `Soren`.`Comments` VALUES
(1,1,2,'comment 1'),(2,1,3,'comment 2'),(3,1,4,'comment 3'),
(4,2,1,'comment 4'),(5,2,6,'comment 5'),(6,2,5,'comment 6'),
(7,3,10,'comment 7'),(8,3,9,'comment 8'),(9,3,9,'comment 9');


-- 1st Query
DELETE FROM `Soren`.`Subjects` WHERE id = 11;
SELECT id,Title FROM `Soren`.`Subjects` WHERE CourseID=1 ORDER BY Title DESC;

-- 2nd Query
SELECT DISTINCT * FROM `Soren`.`Person` JOIN `Soren`.`Professor` WHERE Type='t' ORDER BY Person.id ASC;

-- 3rd Query
SELECT * FROM `Soren`.`Person` NATURAL JOIN `Soren`.`Student` WHERE id=1 OR id=2;

-- 4th Query
SELECT StudentCode FROM `Soren`.`Student` UNION SELECT NationalCode FROM `Soren`.`Professor`;

-- 5th Query
SELECT * FROM `Soren`.`Posts` WHERE postdate NOT IN ('1400-09-01','1400-09-23');

-- 6th Query
SELECT AVG(StudentCode) FROM `Soren`.`Student`;
SELECT COUNT(Title) FROM `Soren`.`Subjects`;
SELECT MIN(Texts) FROM `Soren`.`Posts`;

-- 7th Query
SELECT SUM(StudentCode)/MAX(id) FROM `Soren`.`Student`;

-- 8th Query
SELECT id,FName,LName FROM `Soren`.`Person` WHERE id < (SELECT AVG(id)/2 FROM `Soren`.`Person`) GROUP BY id;

-- 9th Query
SELECT FName,LName,StudentCode FROM `Soren`.`Person`,`Soren`.`Student` WHERE Student.id=Person.id HAVING StudentCode LIKE '%982%';

-- 10th Query
SELECT `Soren`.`Posts`.id, PersonID, Title FROM `Soren`.`Posts`, `Soren`.`Course` WHERE(
PersonID< (SELECT COUNT(DISTINCT PersonID) FROM `Soren`.`Posts`) AND Course.id = Posts.CourseID) ORDER BY id;

-- 11th Query
CREATE VIEW `Soren`.`People`(Title,StudentID,FName,LName) AS SELECT DISTINCT Title,StudentID,FName,LName 
FROM `Soren`.`Course`,`Soren`.`CourseStudents`,`Soren`.`Person` WHERE Course.id=1 AND StudentID=Person.id;
SELECT * FROM `Soren`.`People`;

-- 12th Query
ALTER TABLE `Soren`.`Subjects` MODIFY Title char(35) NOT NULL;

-- 13th Query
UPDATE `Soren`.`Person` SET id=15 WHERE id=10;
SELECT id,FName FROM `Soren`.`Person`;

-- 14th Query
DROP TABLE `Soren`.`Likes`;
SELECT * FROM `Soren`.`Likes`; -- ERROR: TABLE NOT EXIST

-- 15th Query
DROP DATABASE Soren;
SELECT * FROM `Soren`.`Comments`; -- ERROR: DATABASE NOT EXIST
CREATE DATABASE CEITI;
GO

USE CEITI;

-- 2. Crearea tabelului Grupe
CREATE TABLE Grupe (
    ID_Grupa INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) UNIQUE NOT NULL,
    An_Studiu INT CHECK (An_Studiu BETWEEN 1 AND 4) NOT NULL,
    Specialitate NVARCHAR(60) NOT NULL
);

-- 2. Crearea tabelului Raioane
CREATE TABLE Raioane (
    ID_Raion INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(100) NOT NULL
);

-- 3. Crearea tabelului Localitati
CREATE TABLE Localitati (
    ID_Localitate INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(100) NOT NULL,
    ID_Raion INT FOREIGN KEY REFERENCES Raioane(ID_Raion) ON DELETE CASCADE
);

-- 4. Crearea tabelului Studenti
CREATE TABLE Studenti (
    ID_Student INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    Data_Nasterii DATE CHECK (Data_Nasterii <= GETDATE()),
    ID_Grupa INT FOREIGN KEY REFERENCES Grupe(ID_Grupa) ON DELETE CASCADE,
    Email NVARCHAR(100) UNIQUE,
    ID_Localitate INT FOREIGN KEY REFERENCES Localitati(ID_Localitate) ON DELETE CASCADE
);

-- 5. Crearea tabelului Profesori
CREATE TABLE Profesori (
    ID_Profesor INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    Specializare NVARCHAR(100) NOT NULL,
    Catedra NVARCHAR(60) NOT NULL
);

-- 6. Crearea tabelului Cursuri
CREATE TABLE Cursuri (
    ID_Curs INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(100) NOT NULL,
    ID_Profesor INT FOREIGN KEY REFERENCES Profesori(ID_Profesor) ON DELETE SET NULL
);

-- 7. Crearea tabelului Note
CREATE TABLE Note (
    ID_Nota INT PRIMARY KEY IDENTITY(1,1),
    ID_Student INT FOREIGN KEY REFERENCES Studenti(ID_Student) ON DELETE CASCADE,
    ID_Curs INT FOREIGN KEY REFERENCES Cursuri(ID_Curs) ON DELETE CASCADE,
    Nota DECIMAL(3,1) CHECK (Nota BETWEEN 1 AND 10),
    Data_Acordarii DATE DEFAULT GETDATE()
);

ALTER TABLE Profesori ADD Catedra NVARCHAR(60)

ALTER TABLE Grupe ADD Specialitate NVARCHAR(60)

INSERT INTO Grupe (Nume, An_Studiu, Specialitate) VALUES
('P-2323', 1, 'Informatica'),
('W-2321', 1, 'Matematica'),
('T-2319', 1, 'Fizica'),
('E-2305', 1, 'Chimie'),
('M-2325', 1, 'Electronica'),
('P-2420', 2, 'Informatica'),
('W-2418', 2, 'Matematica'),
('T-2409', 2, 'Fizica'),
('E-2411', 2, 'Chimie'),
('M-2427', 2, 'Electronica'),
('P-2522', 3, 'Informatica'),
('W-2515', 3, 'Matematica'),
('T-2507', 3, 'Fizica'),
('E-2513', 3, 'Chimie'),
('M-2529', 3, 'Electronica'),
('P-2621', 4, 'Informatica'),
('W-2616', 4, 'Matematica'),
('T-2608', 4, 'Fizica'),
('E-2614', 4, 'Chimie'),
('M-2630', 4, 'Electronica');


-- 7. Inserarea grupelor
INSERT INTO Studenti (Nume, Prenume, Data_Nasterii, ID_Grupa, Email, Localitate) VALUES 
('Popescu', 'Ion', '2003-05-12', 1, 'ion.popescu1@example.com', 'Chisinau'),
('Ionescu', 'Maria', '2002-08-24', 1, 'maria.ionescu1@example.com', 'Balti'),
('Radu', 'Andrei', '2003-01-17', 2, 'andrei.radu1@example.com', 'Cahul'),
('Georgescu', 'Daniel', '2003-06-15', 1, 'daniel.georgescu@example.com', 'Chisinau'),
('Matei', 'Elena', '2002-07-22', 1, 'elena.matei@example.com', 'Orhei'),
('Vasile', 'Alexandru', '2003-04-10', 2, 'alex.vasile@example.com', 'Balti'),
('Marin', 'Cristina', '2003-09-13', 3, 'cristina.marin@example.com', 'Chisinau'),
('Tudor', 'Florin', '2002-11-30', 4, 'florin.tudor@example.com', 'Cahul'),
('Dobre', 'Mihai', '2003-02-21', 5, 'mihai.dobre@example.com', 'Chisinau'),
('Stan', 'Ana', '2002-10-10', 6, 'ana.stan@example.com', 'Balti'),
('Constantin', 'Ioana', '2003-03-15', 7, 'ioana.constantin@example.com', 'Orhei'),
('Grigore', 'Roxana', '2002-07-25', 8, 'roxana.grigore@example.com', 'Cahul'),
('Sandu', 'Victor', '2003-06-19', 9, 'victor.sandu@example.com', 'Chisinau'),
('Popa', 'Larisa', '2003-04-07', 10, 'larisa.popa@example.com', 'Balti'),
('Ciobanu', 'George', '2002-12-20', 11, 'george.ciobanu@example.com', 'Orhei'),
('Petrescu', 'Alina', '2003-05-30', 12, 'alina.petrescu@example.com', 'Cahul'),
('Fodor', 'Gabriel', '2002-09-15', 13, 'gabriel.fodor@example.com', 'Chisinau'),
('Marinescu', 'Diana', '2003-08-10', 14, 'diana.marinescu@example.com', 'Balti'),
('Neagu', 'Stefan', '2003-01-05', 15, 'stefan.neagu@example.com', 'Orhei'),
('Nistor', 'Madalina', '2002-11-22', 16, 'madalina.nistor@example.com', 'Cahul');



-- Adăugarea de noi profesori
INSERT INTO Profesori (Nume, Prenume, Specializare, Catedra) VALUES 
('Dumitrescu', 'Cristian', 'Matematica', 'Matematica si Informatica'),
('Ionescu', 'Ana', 'Informatica', 'Matematica si Informatica'),
('Popa', 'Mihai', 'Fizica', 'Fizica si Chimie'),
('Georgescu', 'Elena', 'Chimie', 'Fizica si Chimie'),
('Stefan', 'Adrian', 'Electronica', 'Electronica si Telecomunicatii'),
('Radulescu', 'Alexandru', 'Informatica', 'Matematica si Informatica'),
('Dobre', 'Ion', 'Matematica', 'Matematica si Informatica'),
('Marin', 'Elena', 'Fizica', 'Fizica si Chimie'),
('Tudor', 'Mihai', 'Chimie', 'Fizica si Chimie'),
('Sandu', 'Andrei', 'Electronica', 'Electronica si Telecomunicatii'),
('Popescu', 'Roxana', 'Informatica', 'Matematica si Informatica'),
('Ionescu', 'Cristina', 'Matematica', 'Matematica si Informatica'),
('Popa', 'Daniel', 'Fizica', 'Fizica si Chimie'),
('Georgescu', 'Ana', 'Chimie', 'Fizica si Chimie'),
('Stefan', 'Marius', 'Electronica', 'Electronica si Telecomunicatii'),
('Radulescu', 'Maria', 'Informatica', 'Matematica si Informatica'),
('Dobre', 'Laura', 'Matematica', 'Matematica si Informatica'),
('Marin', 'Cristian', 'Fizica', 'Fizica si Chimie'),
('Tudor', 'Adrian', 'Chimie', 'Fizica si Chimie'),
('Sandu', 'Larisa', 'Electronica', 'Electronica si Telecomunicatii');

-- Adăugarea de noi cursuri
INSERT INTO Cursuri (Nume, ID_Profesor) VALUES 
('Algoritmica', 2), ('Baze de date', 2), ('Analiza Matematica', 1),
('Fizica Aplicata', 3), ('Chimie Generala', 4), ('Circuite Electronice', 5),
('Programare Orientata pe Obiecte', 6), ('Structuri de Date', 7), ('Tehnici de Programare', 8),
('Fizica Teoretica', 9), ('Chimie Organica', 10), ('Electronica Digitala', 11),
('Programare Web', 12), ('Algoritmi Avansati', 13), ('Analiza Numerica', 14),
('Fizica Experimentala', 15), ('Chimie Anorganica', 16), ('Electronica Analogica', 17),
('Programare in Java', 18), ('Baze de date Avansate', 19), ('Matematica Discreta', 20);

-- Adăugarea de noi note
INSERT INTO Note (ID_Student, ID_Curs, Nota) VALUES 
(4, 4, 6.0), (5, 5, 5.0), (6, 6, 4.5),
(7, 7, 9.0), (8, 8, 8.5), (9, 9, 7.0), (10, 10, 6.5), (11, 11, 9.5), (12, 12, 8.0),
(13, 13, 7.5), (14, 14, 6.0), (15, 15, 5.0), (16, 16, 4.5), (17, 17, 9.0), (18, 18, 8.5),
(19, 19, 7.0), (20, 20, 6.5), (21, 5, 8.9), (22,6,9),(23, 8, 7.6);

-- Adăugarea de noi raioane
INSERT INTO Raioane (Nume) VALUES 
('Chisinau'), ('Balti'), ('Cahul'), ('Orhei'), 
('Ungheni'), ('Soroca'), ('Hincesti'), ('Edinet'),
('Drochia'), ('Rezina'), ('Falesti'), ('Floresti'),
('Leova'), ('Nisporeni'), ('Cimislia'), ('Stefan Voda'),
('Anenii Noi'), ('Calarasi'), ('Telenesti'), ('Straseni');

-- Adăugarea de noi localități
INSERT INTO Localitati (Nume, ID_Raion) VALUES 
('Chisinau', 1), ('Balti', 2), ('Cahul', 3), ('Orhei', 4), 
('Ungheni', 5), ('Soroca', 6), ('Hincesti', 7), ('Edinet', 8),
('Drochia', 9), ('Rezina', 10), ('Falesti', 11), ('Floresti', 12),
('Leova', 13), ('Nisporeni', 14), ('Cimislia', 15), ('Stefan Voda', 16),
('Anenii Noi', 17), ('Calarasi', 18), ('Telenesti', 19), ('Straseni', 20);
-- Afișarea studenților cu vârsta calculată
SELECT Nume, Prenume, DATEDIFF(Year, Data_Nasterii, GETDATE()) AS Varsta 
FROM Studenti;

-- Media notelor pe curs
SELECT C.Nume AS Curs, AVG(N.Nota) AS Medie_Nota 
FROM Note N JOIN Cursuri C ON N.ID_Curs = C.ID_Curs 
GROUP BY C.Nume;

-- Numărul de studenți per grupă
SELECT G.Nume, COUNT(S.ID_Student) AS Nr_Studenti 
FROM Grupe G LEFT JOIN Studenti S ON G.ID_Grupa = S.ID_Grupa 
GROUP BY G.Nume;

-- Lista profesorilor și cursurile lor
SELECT P.Nume, P.Prenume, C.Nume AS Curs 
FROM Profesori P LEFT JOIN Cursuri C ON P.ID_Profesor = C.ID_Profesor;

UPDATE Studenti SET Localitate = 'Chisinau' WHERE Nume = 'Popescu';
UPDATE Studenti SET Localitate = 'Balti' WHERE Nume = 'Ionescu';
UPDATE Studenti SET Localitate = 'Cahul' WHERE Nume = 'Radu';
UPDATE Studenti SET Localitate = 'Chisinau' WHERE Nume = 'Georgescu';
UPDATE Studenti SET Localitate = 'Orhei' WHERE Nume = 'Matei';
UPDATE Studenti SET Localitate = 'Balti' WHERE Nume = 'Vasile';

-- Interogările solicitate
-- Afișați lista grupelor, în care sunt elevi, ce studiază pe note negative.
SELECT DISTINCT G.Nume 
FROM Grupe G
JOIN Studenti S ON G.ID_Grupa = S.ID_Grupa
JOIN Note N ON S.ID_Student = N.ID_Student
WHERE N.Nota < 5;

-- Studenții cu nota 8 și numele 'Popescu'
SELECT S.Nume, S.Prenume
FROM Studenti S
JOIN Note N ON S.ID_Student = N.ID_Student
WHERE N.Nota = 8 AND S.Nume = 'Popescu';

-- Numărul de profesori per catedră
SELECT Catedra, COUNT(ID_Profesor) AS Nr_Profesori
FROM Profesori
GROUP BY Catedra;

-- Lista localităților și raioanelor
SELECT L.Nume AS Localitate, R.Nume AS Raion
FROM Localitati L
JOIN Raioane R ON L.ID_Raion = R.ID_Raion;

-- Lista grupelor, specialitatea, obiectele și profesorii
SELECT G.Nume AS Grupa, G.Specialitate, C.Nume AS Curs, P.Nume AS Profesor, P.Prenume AS Profesor_Prenume
FROM Grupe G
JOIN Studenti S ON G.ID_Grupa = S.ID_Grupa
JOIN Note N ON S.ID_Student = N.ID_Student
JOIN Cursuri C ON N.ID_Curs = C.ID_Curs
JOIN Profesori P ON C.ID_Profesor = P.ID_Profesor
GROUP BY G.Nume, G.Specialitate, C.Nume, P.Nume, P.Prenume;

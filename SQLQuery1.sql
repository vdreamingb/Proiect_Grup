CREATE DATABASE CEITI;
GO

USE CEITI;

-- 2. Crearea tabelului Grupe
CREATE TABLE Grupe (
    ID_Grupa INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) UNIQUE NOT NULL,
    An_Studiu INT CHECK (An_Studiu BETWEEN 1 AND 4) NOT NULL
);

-- 3. Crearea tabelului Studenti
CREATE TABLE Studenti (
    ID_Student INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    Data_Nasterii DATE,
    ID_Grupa INT FOREIGN KEY REFERENCES Grupe(ID_Grupa) ON DELETE CASCADE,
    Email NVARCHAR(100) UNIQUE,
    CONSTRAINT CHK_DataNasterii CHECK (Data_Nasterii <= GETDATE())
);

-- 4. Crearea tabelului Profesori
CREATE TABLE Profesori (
    ID_Profesor INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    Specializare NVARCHAR(100) NOT NULL
);

-- 5. Crearea tabelului Cursuri
CREATE TABLE Cursuri (
    ID_Curs INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(100) NOT NULL,
    ID_Profesor INT FOREIGN KEY REFERENCES Profesori(ID_Profesor) ON DELETE SET NULL
);

-- 6. Crearea tabelului Note
CREATE TABLE Note (
    ID_Nota INT PRIMARY KEY IDENTITY(1,1),
    ID_Student INT FOREIGN KEY REFERENCES Studenti(ID_Student) ON DELETE CASCADE,
    ID_Curs INT FOREIGN KEY REFERENCES Cursuri(ID_Curs) ON DELETE CASCADE,
    Nota DECIMAL(3,1) CHECK (Nota BETWEEN 1 AND 10),
    Data_Acordarii DATE DEFAULT GETDATE()
);

-- 7. Inserarea grupelor
INSERT INTO Grupe (Nume, An_Studiu) VALUES 
('TI-211', 1), ('TI-212', 1), 
('TI-221', 2), ('TI-222', 2), 
('TI-231', 3), ('TI-241', 4);

-- 8. Inserarea studenților
INSERT INTO Studenti (Nume, Prenume, Data_Nasterii, ID_Grupa, Email) VALUES 
('Popescu', 'Ion', '2003-05-12', 1, 'ion.popescu1@example.com'),
('Ionescu', 'Maria', '2002-08-24', 1, 'maria.ionescu1@example.com'),
('Radu', 'Andrei', '2003-01-17', 2, 'andrei.radu1@example.com'),
('Georgescu', 'Daniel', '2003-06-15', 1, 'daniel.georgescu@example.com'),
('Matei', 'Elena', '2002-07-22', 1, 'elena.matei@example.com'),
('Vasile', 'Alexandru', '2003-04-10', 2, 'alex.vasile@example.com');

-- 9. Inserarea profesorilor
INSERT INTO Profesori (Nume, Prenume, Specializare) VALUES 
('Dumitrescu', 'Cristian', 'Matematica'),
('Ionescu', 'Ana', 'Informatica'),
('Popa', 'Mihai', 'Fizica'),
('Georgescu', 'Elena', 'Chimie'),
('Stefan', 'Adrian', 'Electronica');

-- 10. Inserarea cursurilor
INSERT INTO Cursuri (Nume, ID_Profesor) VALUES 
('Algoritmica', 2), ('Baze de date', 2), ('Analiza Matematica', 1),
('Fizica Aplicata', 3), ('Chimie Generala', 4), ('Circuite Electronice', 5);

-- 11. Inserarea notelor
INSERT INTO Note (ID_Student, ID_Curs, Nota) VALUES 
(1, 1, 9.5), (2, 2, 8.0), (3, 3, 7.5);

-- 12. Interogări avansate
-- Afișarea studenților cu vârsta calculată
SELECT Nume, Prenume, DATEDIFF(YEAR, Data_Nasterii, GETDATE()) AS Varsta 
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


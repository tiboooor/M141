/*
Zweck:      Erstellt die Datenbank mit allen benötigten Tabellen und Relationen
Autor:      Tibor Blasko
Datum:      07.09.2022
Ausführung: mysql -u tibor -p < "Path"
*/

/*Datenbank erstellen*/
DROP DATABASE IF EXISTS Stihleisen;
CREATE DATABASE Stihleisen;
USE Stihleisen;

/*Kundentabelle erstellen*/
CREATE TABLE Kunden
(
    id_Kunde INT NOT NULL AUTO_INCREMENT,
    Anrede ENUM('FRAU','HERR') NOT NULL,
    Vorname VARCHAR(50) NOT NULL,
    Nachname VARCHAR(50) NOT NULL,
    Strasse VARCHAR(50),
    PLZ CHAR(4),
    Ort VARCHAR(50),
    Tefelon VARCHAR(15),
    Geburtsdatum DATE NOT NULL,
    Ausweisnummer CHAR(5),
    PRIMARY KEY(id_Kunde),
    INDEX(Nachname)
)Engine = InnoDB;

/*Büchertabelle erstellen*/
CREATE TABLE Buecher
(
    id_Buch INT NOT NULL AUTO_INCREMENT,
    Titel VARCHAR(50) NOT NULL,
    Kategorie VARCHAR(20),
    Autor VARCHAR(50),
    ISBN VARCHAR(50) NOT NULL,
    Lagerbestand INT,
    Regal VARCHAR(5),
    PRIMARY KEY(id_Buch),
    INDEX(Titel)
)Engine = InnoDB;

/*Mitarbeitertabelle erstellen*/
CREATE TABLE Mitarbeiter
(
    id_Mitarbeiter INT NOT NULL AUTO_INCREMENT,
    Anrede ENUM('Frau','Herr') NOT NULL,
    Vorname VARCHAR(50) NOT NULL,
    Nachname VARCHAR(50) NOT NULL,
    Strasse VARCHAR(50),
    PLZ CHAR(4),
    Ort VARCHAR(50),
    Tefelon VARCHAR(15),
    Geburtsdatum DATE NOT NULL,
    PRIMARY KEY(id_Mitarbeiter),
    INDEX(Nachname)
)Engine = InnoDB;

/*Ausleihetabelle erstellen*/
CREATE TABLE Ausleihe
(
    id_Ausleihe INT NOT NULL AUTO_INCREMENT,
    Ausleihdatum DATE NOT NULL,
    Rueckgabedatum DATE NOT NULL,
    fs_Kunde INT,
    fs_Buch INT,
    fs_Mitarbeiter_Ausleihe INT,
    fs_Mitarbeiter_Rueckgabe INT,
    PRIMARY KEY(id_Ausleihe),
    FOREIGN KEY(fs_Kunde) REFERENCES Kunden(id_Kunde),
    FOREIGN KEY(fs_Buch) REFERENCES Buecher(id_Buch),
    FOREIGN KEY(fs_Mitarbeiter_Ausleihe) REFERENCES Mitarbeiter(id_Mitarbeiter),
    FOREIGN KEY(fs_Mitarbeiter_Rueckgabe) REFERENCES Mitarbeiter(id_Mitarbeiter)
)Engine = InnoDB;
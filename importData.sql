/*
Zweck:      Importiert die Daten in die Tabellen Tabellen
Autor:      Tibor Blasko
Datum:      14.09.2022
Ausführung: mysql -u tibor -p < "Path"
*/

/*Datenbank Stihleisen benutzen*/

/*Zuerst alle Daten in allen Tabellen löschen*/
DELETE FROM Kunden WHERE id_Kunde > 0;
DELETE FROM Mitarbeiter WHERE id_Mitarbeiter > 0;
DELETE FROM Buecher WHERE id_Buch > 0;
DELETE FROM Ausleihe WHERE id_Ausleihe > 0;

/*Bulkimport Kunden*/
LOAD DATA INFILE '/tmp/Kunden.csv'
INTO TABLE Kunden
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
(id_Kunde,Anrede,Vorname,Nachname,Strasse,PLZ,Ort,Tefelon,Geburtsdatum,Ausweisnummer);

INSERT INTO Mitarbeiter
(id_Mitarbeiter,Anrede,Vorname,Nachname,Strasse,PLZ,Ort,Tefelon,Geburtsdatum)
VALUES
(1,'Herr','Yanik','Breitenmoser','Gerbestrasse 2b','9436','Balgach','079 529 69 46','2005-09-20'),
(2,'Frau','Franziska','Tobler','Buetzelhofstrasse 12','9422','Staad','076 251 92 50','2001-12-12'),
(3,'Herr','Michel','Keller','Stockenstrasse 10','8352','Balterswil','079 552 01 19','2005-09-27'),
(4,'Herr','Tibor','Blasko','Bruggwaldstrasse 60','9008','St. Gallen','077 471 94 35','2005-11-11');

INSERT INTO Buecher
(id_Buch,Titel,Kategorie,Autor,ISBN,Lagerbestand,Regal)
VALUES
(1,'Harry Potter And the Philosophers Stone','Fantasy','Joanne Kathleen Rowling','978-3-551-35401-3',5,'A2'),
(2,'Harry Potter And the Chamber of Secrets','Fantasy','Joanne Kathleen Rowling','978-3-551-35402-0',7,'A2'),
(3,'Harry Potter And the Prisoner Of Azkaban','Fantasy','Joanne Kathleen Rowling','978-3-551-35403-7',3,'A2'),
(4,'Harry Potter And the Goblet of Fire','Fantasy','Joanne Kathleen Rowling','978-3-551-35404-4',9,'A2'),
(5,'Harry Potter And the Order of the Phoenix','Fantasy','Joanne Kathleen Rowling','978-3-551-35405-1',8,'A2'),
(6,'Harry Potter And the Half-Bloode Prince','Fantasy','Joanne Kathleen Rowling','978-3-551-35406-8',1,'A2'),
(7,'Harry Potter And the Deathly Hollows','Fantasy','Joanne Kathleen Rowling','978-3-551-35407-5',6,'A2');
/*
Zweck:      Erstellt Views und Stored Procedures
Autor:      Tibor Blasko
Datum:      21.09.2022
Ausführung: mysql -u tibor -p < "Path"
*/

/* Views löschen */
DROP VIEW IF EXISTS Kundensuche_V;
DROP VIEW IF EXISTS Buechersuche_V;
DROP VIEW IF EXISTS Ausleihemitarbeitersuche_V;
DROP VIEW IF EXISTS Rueckgabemitarbeitersuche_V;

/* View zur Kundensuche */
CREATE VIEW Kundensuche_V AS
SELECT id_Kunde, Anrede, Vorname, Nachname, Ausweisnummer FROM Kunden
WHERE Anrede = 'Herr';

/* View zur Büchersuche */
CREATE VIEW Buechersuche_V AS
SELECT id_Buch, Titel, Autor, Regal FROM Buecher
INNER JOIN Ausleihe ON Buecher.id_Buch = Ausleihe.fs_Buch
WHERE Buecher.Autor = 'Joanne Kathleen Rowling';

/* View zur Suche des Mitarbeiters, der für die Ausleihe zuständig war */
CREATE VIEW Ausleihemitarbeitersuche_V AS
SELECT id_Mitarbeiter, Anrede, Vorname, Nachname FROM Mitarbeiter
INNER JOIN Ausleihe ON Mitarbeiter.id_Mitarbeiter = Ausleihe.fs_Mitarbeiter_Ausleihe
WHERE Anrede = 'Herr';

/* View zur Suche des Mitarbeiters, der für die Rückgabe zuständig war */
CREATE VIEW Rueckgabemitarbeitersuche_V AS
SELECT id_Mitarbeiter, Anrede, Vorname, Nachname FROM Mitarbeiter
INNER JOIN Ausleihe ON Mitarbeiter.id_Mitarbeiter = Ausleihe.fs_Mitarbeiter_Rueckgabe
WHERE Anrede = 'Herr';

/* Procedures löschen */
DROP PROCEDURE IF EXISTS ausleihen;
DROP PROCEDURE IF EXISTS zurueckgeben;
DROP PROCEDURE IF EXISTS Ausleihmitarbeiter;
DROP PROCEDURE IF EXISTS Rueckgabemitarbeiter;

/* Delimiter setzen */
delimiter //

/* Prozedur zur Erfassung einer neuen Ausleihe
Aufruf mit "CALL ausleihen('0000-00-00','0000-00-00','0','0','0');" Die Nullen mit entsprechendem Wert ersetzen. */
CREATE PROCEDURE ausleihen (IN pAusleihdatum DATE,
                            IN pRueckgabedatum DATE,
                            IN p_fs_Kunde INT,
                            IN p_fs_Buch INT,
                            IN p_fs_Mitarbeiter_Ausleihe INT)
BEGIN
    INSERT INTO Ausleihe
    (Ausleihdatum,Rueckgabedatum,fs_Kunde,fs_Buch,fs_Mitarbeiter_Ausleihe)
    VALUES
    (pAusleihdatum,pRueckgabedatum,p_fs_Kunde,p_fs_Buch,p_fs_Mitarbeiter_Ausleihe);
END;
//

/* Prozedur zur Erfassung des für die Rückgabe zuständigen Mitarbeiters
Aufruf mit "CALL zurueckgeben('0','0');" Die Nullen mit entsprechendem Wert ersetzen. */
CREATE PROCEDURE zurueckgeben  (IN p_id_Ausleihe INT,
                                IN p_fs_Mitarbeiter_Rueckgabe INT)
BEGIN
    UPDATE Ausleihe
    SET fs_Mitarbeiter_Rueckgabe = p_fs_Mitarbeiter_Rueckgabe
    WHERE id_Ausleihe = p_id_Ausleihe;
END;
//

/* Prozedzur zur Ermittlung des für die Ausleihe zuständigen Mitarbeiters
Aufruf mit "CALL Ausleihmitarbeiter('0',@MitarbeiterfuerAusleihe);" Die Nullen mit entsprechendem Wert ersetzen.
Abruf des OUT-Parameters "SELECT @MitarbeiterfuerAusleihe;" Ausgabe wird dann angezeigt. */
CREATE PROCEDURE Ausleihmitarbeiter    (IN p_id_Ausleihe INT,
                                        OUT p_fs_Mitarbeiter_Ausleihe VARCHAR(50))
BEGIN
    SELECT CONCAT(Vorname,' ',Nachname)
    AS Mitarbeiter_Ausleihe
    INTO p_fs_Mitarbeiter_Ausleihe
    FROM Ausleihe
    INNER JOIN Mitarbeiter ON Ausleihe.fs_Mitarbeiter_Ausleihe = Mitarbeiter.id_Mitarbeiter
    WHERE id_Ausleihe = p_id_Ausleihe;
END;
//

/* Prozedzur zur Ermittlung des für die Rueckgabe zuständigen Mitarbeiters
Aufruf mit "CALL Reuckgabemitarbeiter('0',@MitarbeiterfuerRueckgabe);" Die Nullen mit entsprechendem Wert ersetzen.
Abruf des OUT-Parameters "SELECT @MitarbeiterfuerRueckgabe;" Ausgabe wird dann angezeigt. */
CREATE PROCEDURE Rueckgabemitarbeiter  (IN p_id_Ausleihe INT,
                                        OUT p_fs_Mitarbeiter_Rueckgabe VARCHAR(50))
BEGIN
    SELECT CONCAT(Vorname,' ',Nachname)
    AS Mitarbeiter_Rueckgabe
    INTO p_fs_Mitarbeiter_Rueckgabe
    FROM Ausleihe
    INNER JOIN Mitarbeiter ON Ausleihe.fs_Mitarbeiter_Rueckgabe = Mitarbeiter.id_Mitarbeiter
    WHERE id_Ausleihe = p_id_Ausleihe;
END;
//

/* Delimiter zurücksetzen */
delimiter ;

/* Berechtigungen auf Views und Procedures setzen */
GRANT SELECT ON TABLE Kundensuche_V TO 'KundenAdmin'@'localhost';
GRANT SELECT ON TABLE Kundensuche_V TO 'KundenWildcard'@'%';
GRANT SELECT ON TABLE Buechersuche_V TO 'BuchAdmin'@'localhost';
GRANT SELECT ON TABLE Buechersuche_V TO 'BuchWildcard'@'%';
GRANT SELECT ON TABLE Ausleihemitarbeitersuche_V TO 'AusleihAdmin'@'localhost';
GRANT SELECT ON TABLE Ausleihemitarbeitersuche_V TO 'AusleihWildcard'@'%';
GRANT SELECT ON TABLE Ausleihemitarbeitersuche_V TO 'MitarbeiterAdmin'@'localhost';
GRANT SELECT ON TABLE Ausleihemitarbeitersuche_V TO 'MitarbeiterWildcard'@'%';
GRANT SELECT ON TABLE Rueckgabemitarbeitersuche_V TO 'AusleihAdmin'@'localhost';
GRANT SELECT ON TABLE Rueckgabemitarbeitersuche_V TO 'AusleihWildcard'@'%';
GRANT SELECT ON TABLE Rueckgabemitarbeitersuche_V TO 'MitarbeiterAdmin'@'localhost';
GRANT SELECT ON TABLE Rueckgabemitarbeitersuche_V TO 'MitarbeiterWildcard'@'%';
GRANT EXECUTE ON PROCEDURE ausleihen TO 'AusleihAdmin'@'localhost';
GRANT EXECUTE ON PROCEDURE ausleihen TO 'AusleihWildcard'@'%';
GRANT EXECUTE ON PROCEDURE zurueckgeben TO 'AusleihAdmin'@'localhost';
GRANT EXECUTE ON PROCEDURE zurueckgeben TO 'AusleihWildcard'@'%';
GRANT EXECUTE ON PROCEDURE Ausleihmitarbeiter TO 'MitarbeiterAdmin'@'localhost';
GRANT EXECUTE ON PROCEDURE Ausleihmitarbeiter TO 'MitarbeiterWildcard'@'%';
GRANT EXECUTE ON PROCEDURE Rueckgabemitarbeiter TO 'MitarbeiterAdmin'@'localhost';
GRANT EXECUTE ON PROCEDURE Rueckgabemitarbeiter TO 'MitarbeiterWildcard'@'%';
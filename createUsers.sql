/*
Zweck:      Erstellt die Datenbankbenutzer mit den entsprechenden Berechtigungen
Autor:      Michel Keller
Datum:      14.09.2022
Ausführung: mysql -u root -p < "Path"
*/

USE mysql;
DROP USER IF EXISTS 'AusleihAdmin'@'localhost';
DROP USER IF EXISTS 'BuchAdmin'@'localhost';
DROP USER IF EXISTS 'KundenAdmin'@'localhost';
DROP USER IF EXISTS 'MitarbeiterAdmin'@'localhost';
DROP USER IF EXISTS 'AusleihWildcard'@'%';
DROP USER IF EXISTS 'BuchWildcard'@'%';
DROP USER IF EXISTS 'KundenWildcard'@'%';
DROP USER IF EXISTS 'MitarbeiterWildcard'@'%';

CREATE USER 'AusleihAdmin'@'localhost'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Ausleihe TO 'AusleihAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Buecher TO 'AusleihAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Kunden TO 'AusleihAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'AusleihAdmin'@'localhost';

CREATE USER 'BuchAdmin'@'localhost'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Buecher TO 'BuchAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Ausleihe TO 'BuchAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Kunden TO 'BuchAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'BuchAdmin'@'localhost';

CREATE USER 'KundenAdmin'@'localhost'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Kunden TO 'KundenAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Ausleihe TO 'KundenAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Buecher TO 'KundenAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'KundenAdmin'@'localhost';

CREATE USER 'MitarbeiterAdmin'@'localhost'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Mitarbeiter TO 'MitarbeiterAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Ausleihe TO 'MitarbeiterAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Buecher TO 'MitarbeiterAdmin'@'localhost';
GRANT SELECT ON Stihleisen.Kunden TO 'MitarbeiterAdmin'@'localhost';

/*Hier bei 'AusleihWildcard'@'%' steht das '%' für Wildcard*/
/*Ein Wildcard-Benutzer hat die Berechtigung über Remote auf die Datenbank zuzugreifen*/

CREATE USER 'AusleihWildcard'@'%'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Ausleihe TO 'AusleihWildcard'@'%';
GRANT SELECT ON Stihleisen.Kunden TO 'AusleihWildcard'@'%';
GRANT SELECT ON Stihleisen.Buecher TO 'AusleihWildcard'@'%';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'AusleihWildcard'@'%';

CREATE USER 'BuchWildcard'@'%'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Buecher TO 'BuchWildcard'@'%';
GRANT SELECT ON Stihleisen.Ausleihe TO 'BuchWildcard'@'%';
GRANT SELECT ON Stihleisen.Kunden TO 'BuchWildcard'@'%';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'BuchWildcard'@'%';

CREATE USER 'KundenWildcard'@'%'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Kunden TO 'KundenWildcard'@'%';
GRANT SELECT ON Stihleisen.Ausleihe TO 'KundenWildcard'@'%';
GRANT SELECT ON Stihleisen.Buecher TO 'KundenWildcard'@'%';
GRANT SELECT ON Stihleisen.Mitarbeiter TO 'KundenWildcard'@'%';

CREATE USER 'MitarbeiterWildcard'@'%'
IDENTIFIED BY 'gibbiX12345';
GRANT ALL PRIVILEGES ON Stihleisen.Mitarbeiter TO 'MitarbeiterWildcard'@'%';
GRANT SELECT ON Stihleisen.Kunden TO 'MitarbeiterWildcard'@'%';
GRANT SELECT ON Stihleisen.Buecher TO 'MitarbeiterWildcard'@'%';
GRANT SELECT ON Stihleisen.Ausleihe TO 'MitarbeiterWildcard'@'%';
FLUSH PRIVILEGES;
CREATE DATABASE firma;
GO
use firma;
Go
CREATE SCHEMA rozliczenia;
GO

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika CHAR(8) PRIMARY KEY,
	imie VARCHAR(50) NOT NULL,
	nazwisko VARCHAR(50) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon CHAR(12) NULL);



CREATE TABLE rozliczenia.godziny (
	id_godziny CHAR(6) PRIMARY KEY, 
	dataa DATE NOT NULL, 
	liczba_godzin INT NOT NULL, 
	id_pracownika CHAR(8) NOT NULL);

CREATE TABLE rozliczenia.pensje (
	id_pensji CHAR(8) PRIMARY KEY, 
	stanowisko VARCHAR(50) NOT NULL, 
	kwota MONEY NOT NULL, 
	id_premii CHAR(8) NULL);

CREATE TABLE rozliczenia.premie(
	id_premii CHAR(8) PRIMARY KEY, 
	rodzaj VARCHAR(30) NULL,
	kwota SMALLMONEY NOT NULL);



ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);


ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);


INSERT INTO rozliczenia.pracownicy(

	[id_pracownika],
	[imie],
	[nazwisko],
	[adres],
	[telefon]

)
VALUES
(
'A',
'Adam',
'Nowak',
'Orzeszkowa 22/56',
NULL
),
(
'B',
'Barbara',
'Kowalska',
'Orzeszkowa 77/51',
'+48967006998'
),
(
'C',
'Cezary',
'Wójcik',
'Orzeszkowa 22/41',
'+48917894997'
),
(
'D',
'Daniel',
'Kowalczyk',
'Orzeszkowa 21/48',
'+48991463796'
),
(
'E',
'Eliza',
'Jankowska',
'Orzeszkowa 22/40',
'+48943578995'
),
(
'F',
'Franciszek',
'Górski',
'Sezamkowa 29/67',
'+48990943994'
),
(
'G',
'Gabriela',
'Nowicka',
'Sezamkowa 29/56',
'+48997164993'
),
(
'H',
'Henryk',
'Kaczmarek',
'Sezamkowa 29/11',
'+48994535992'
),
(
'I',
'Iwona',
'Koz³owska',
'Sezamkowa 29/45',
'+48123456789'
),
(
'J',
'Jan',
'Zieliñski',
'Sezamkowa 29/40',
NULL
)

SELECT * FROM rozliczenia.pracownicy


INSERT INTO rozliczenia.premie(

	[id_premii],
	[kwota],
	[rodzaj]

)
VALUES
(
	'1',
	1,
	NULL
),
(
	'2',
	200,
	NULL
),
(
	'3',
	300,
	NULL
),
(
	'4',
	400,
	NULL
),
(
	'5',
	500,
	NULL
),
(
	'6',
	600,
	NULL
),
(
	'7',
	700,
	NULL
),
(
	'8',
	800,
	NULL
),
(
	'9',
	900,
	NULL
),
(
	'10',
	1000,
	NULL
)

SELECT * FROM rozliczenia.premie

INSERT INTO rozliczenia.pensje (
	[id_pensji],
	[stanowisko],
	[kwota],
	[id_premii]
)
VALUES
(
	'1',
	'Konserwator',
	3000,
	'1'
),
(
	'2',
	'Ochroniarz',
	4000,
	'2'
),
(
	'3',
	'Produkcja',
	5000,
	'3'
),
(
	'4',
	'Produkcja',
	6000,
	'4'
),
(
	'5',
	'Kierownik Produkcji',
	7000,
	'5'
),
(
	'6',
	'Sekretarz',
	8000,
	'6'
),
(
	'7',
	'Kierownik Sprzedazy',
	9000,
	'7'
),
(
	'8',
	'Kierownik Marketingu',
	10000,
	'8'
),
(
	'9',
	'Kierownik Logistyki',
	11000,
	'9'
),
(
	'P10',
	'Prezes',
	12000,
	'10'
)

SELECT * FROM rozliczenia.pensje;

INSERT INTO rozliczenia.godziny(

	[dataa],
	[id_godziny],
	[id_pracownika],
	[liczba_godzin]

)
VALUES
(
	'2023-04-01',
	1,
	'A',
	10
),
(
	'2023-04-02',
	2,
	'B',
	11
),
(
	'2023-04-03',
	3,
	'C',
	12
),
(
	'2023-04-04',
	4,
	'D',
	13
),
(
	'2023-04-05',
	5,
	'E',
	14
),
(
	'2023-04-06',
	6,
	'F',
	15
),
(
	'2023-04-07',
	7,
	'G',
	16
),
(
	'2023-04-08',
	12,
	'H',
	17
),
(
	'2023-04-09',
	8,
	'I',
	18
),
(
	'2023-04-10',
	9,
	'J',
	19
)

SELECT * FROM rozliczenia.godziny

-- ZADANIE 5
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--ZADANIE 6
SELECT DATEPART ( dw , dataa ) as 'Dzien ',
	   DATEPART ( mm , dataa ) as 'Miesiac'
FROM rozliczenia.godziny;

--ZADANIE 7
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje
ADD kwota_netto AS (pensje.kwota_brutto * 0.72);

SELECT * FROM rozliczenia.pensje
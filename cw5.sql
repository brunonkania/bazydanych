
create database firma2;
use firma;

create schema ksiegowosc;

create table ksiegowosc.pracownicy(
id_pracownika int primary key, 
imie nvarchar(50) NOT NULL, 
nazwisko nvarchar(50) NOT NULL, 
adres nvarchar(100) NOT NULL, 
telefon varchar(15) NOT NULL);

create table ksiegowosc.godziny(
id_godziny int primary key, 
dataa date NOT NULL, 
liczba_godzin int NOT NULL, 
id_pracownika int NOT NULL);

create table ksiegowosc.pensje(
id_pensji int primary key, 
stanowisko nvarchar(50) not null,
kwota money NOT NULL);

create table ksiegowosc.premia(
id_premii int primary key NOT NULL, 
rodzaj nvarchar(60) NOT NULL, 
kwota money NOT NULL);

create table ksiegowosc.wynagrodzenie(
id_wynagrodzenia int primary key,
dataa date NOT NULL, 
id_pracownika int NOT NULL, 
id_godziny int NOT NULL,
id_pensji int NOT NULL, 
id_premii int NOT NULL);


alter table ksiegowosc.godziny 
add foreign key(id_pracownika) references ksiegowosc.pracownicy(id_pracownika);

alter table ksiegowosc.wynagrodzenie
add foreign key(id_godziny) references ksiegowosc.godziny(id_godziny);

alter table ksiegowosc.wynagrodzenie
add foreign key(id_pensji) references ksiegowosc.pensje(id_pensji);

alter table ksiegowosc.wynagrodzenie
add foreign key(id_premii) references ksiegowosc.premia(id_premii);

alter table ksiegowosc.wynagrodzenie
add foreign key(id_pracownika) references ksiegowosc.pracownicy(id_pracownika);


EXEC sys.sp_addextendedproperty 
@name=N'Pracownicy', 
@value=N'Tabela pracownikow',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='pracownicy'

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pracownicy')
  AND minor_id = 0
  AND class = 1;

 EXEC sys.sp_addextendedproperty 
@name=N'Godziny', 
@value=N'Tabela godzin',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='godziny'

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.godziny')
  AND minor_id = 0
  AND class = 1;

 EXEC sys.sp_addextendedproperty 
@name=N'Pensje', 
@value=N'Tabela pensji',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='pensje'


SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pensje')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty 
@name=N'Premie', 
@value=N'Tabela premii',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='premia'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.premia')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela wynagrodzen - wysokosc wynagrodzenia dla danego pracownika oraz data wyplacenia',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='wynagrodzenie'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.wynagrodzenie')
  AND minor_id = 0
  AND class = 1;

--5. 

INSERT INTO ksiegowosc.pracownicy values(1, 'Jan', 'Nowak', 'ul. S³oneczna 15, 30-888 Kraków', '111111111');
INSERT INTO ksiegowosc.pracownicy values(2, 'Anna', 'Kowalska', 'ul. Lipowa 12/5, 30-555 Kraków', '222222222');
INSERT INTO ksiegowosc.pracownicy values(3, 'Piotr', 'Nowicki', 'ul. D³uga 7, 33-100 Tarnów', '333333333');
INSERT INTO ksiegowosc.pracownicy values(4, 'Karolina', 'Wójcik', 'ul. Wroc³awska 23/8, 30-999 Kraków', '444444444');
INSERT INTO ksiegowosc.pracownicy values(5, 'Mariusz', 'Lis', 'ul. Krakowska 5, 31-999 Kraków', '555555555');
INSERT INTO ksiegowosc.pracownicy values(6, 'Katarzyna', 'Szymañska', 'ul. Mickiewicza 9/11, 30-777 Kraków', '666666666');
INSERT INTO ksiegowosc.pracownicy values(7, 'Micha³', 'Kaczmarek', 'ul. Warszawska 14, 30-888 Kraków', '777777777');
INSERT INTO ksiegowosc.pracownicy values(8, 'Magdalena', 'Piotrowska', 'ul. Œwierkowa 7, 30-777 Kraków', '888888888');
INSERT INTO ksiegowosc.pracownicy values(9, 'Tomasz', 'Kamiñski', 'ul. 3 Maja 25, 30-444 Kraków', '999999999');
INSERT INTO ksiegowosc.pracownicy values(10, 'Marcin', 'D¹browski', 'ul. Leœna 11, 31-100 Kraków', '123456789');


INSERT INTO ksiegowosc.godziny values(1,'2023-04-27',100,1);
INSERT INTO ksiegowosc.godziny values(2,'2023-04-27',90,2);
INSERT INTO ksiegowosc.godziny values(3,'2023-04-27',80,3);
INSERT INTO ksiegowosc.godziny values(4,'2023-04-27',77,4);
INSERT INTO ksiegowosc.godziny values(5,'2023-04-27',60,5);
INSERT INTO ksiegowosc.godziny values(6,'2023-04-27',50,6);
INSERT INTO ksiegowosc.godziny values(7,'2023-04-27',40,7);
INSERT INTO ksiegowosc.godziny values(8,'2023-04-27',30,8);
INSERT INTO ksiegowosc.godziny values(9,'2023-04-27',20,9);
INSERT INTO ksiegowosc.godziny values(10,'2023-04-27',10,10);


INSERT INTO ksiegowosc.pensje values(1, 'kierownik produkcji', 8500);
INSERT INTO ksiegowosc.pensje values(2, 'specjalista ds. marketingu', 6700);
INSERT INTO ksiegowosc.pensje values(3, 'asystent zarz¹du', 5500);
INSERT INTO ksiegowosc.pensje values(4, 'sprz¹tacz', 2400);
INSERT INTO ksiegowosc.pensje values(5, 'konsultant ds. sprzeda¿y', 6200);
INSERT INTO ksiegowosc.pensje values(6, 'programista Java', 7800);
INSERT INTO ksiegowosc.pensje values(7, 'in¿ynier procesu', 8200);
INSERT INTO ksiegowosc.pensje values(8, 'inspektor jakoœci', 5900);
INSERT INTO ksiegowosc.pensje values(9, 'pracownik magazynu', 3400);
INSERT INTO ksiegowosc.pensje values(10, 'operator maszyn', 2600);



INSERT INTO ksiegowosc.premia values(1, 'wynik finansowy', 500);
INSERT INTO ksiegowosc.premia values(2, 'premia œwi¹teczna', 1000);
INSERT INTO ksiegowosc.premia values(3, 'ocena pracownika', 300);
INSERT INTO ksiegowosc.premia values(4, 'premia wakacyjna', 800);
INSERT INTO ksiegowosc.premia values(5, 'dodatkowa premia', 600);
INSERT INTO ksiegowosc.premia values(6, 'premia za osi¹gniêcie celów', 1200);
INSERT INTO ksiegowosc.premia values(7, 'premia za pracê w nadgodzinach', 400);
INSERT INTO ksiegowosc.premia values(8, 'premia za obs³ugê klienta', 900);
INSERT INTO ksiegowosc.premia values(9, 'premia za udzia³ w projekcie', 750);
INSERT INTO ksiegowosc.premia values(10, 'premia za d³ugi sta¿ pracy', 1500);



insert into ksiegowosc.wynagrodzenie values(1,'2023-04-27',1,1,1,1);
insert into ksiegowosc.wynagrodzenie values(2,'2023-04-27',2,2,2,2);
insert into ksiegowosc.wynagrodzenie values(3,'2023-04-27',3,3,3,3);
insert into ksiegowosc.wynagrodzenie values(4,'2023-04-27',4,4,4,4);
insert into ksiegowosc.wynagrodzenie values(5,'2023-04-27',5,5,5,5);
insert into ksiegowosc.wynagrodzenie values(6,'2023-04-27',6,6,6,6);
insert into ksiegowosc.wynagrodzenie values(7,'2023-04-27',7,7,7,7);
insert into ksiegowosc.wynagrodzenie values(8,'2023-04-27',8,8,8,8);
insert into ksiegowosc.wynagrodzenie values(9,'2023-04-27',9,9,9,9);
insert into ksiegowosc.wynagrodzenie values(10,'2023-04-27',10,10,10,10);


SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.godziny;
SELECT * FROM ksiegowosc.pensje;
SELECT * FROM ksiegowosc.premia;
SELECT * FROM ksiegowosc.wynagrodzenie;

--A
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--B
SELECT ksiegowosc.wynagrodzenie.id_pracownika, ksiegowosc.pensje.kwota FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensje ON	 ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji
WHERE ksiegowosc.pensje.kwota>1000
ORDER BY ksiegowosc.wynagrodzenie.id_pracownika;

--C
SELECT ksiegowosc.wynagrodzenie.id_pracownika,ksiegowosc.pensje.kwota, ksiegowosc.premia.rodzaj FROM ksiegowosc.premia 
INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pensje.id_pensji=ksiegowosc.wynagrodzenie.id_pensji) ON ksiegowosc.premia.id_premii=ksiegowosc.wynagrodzenie.id_premii
WHERE ksiegowosc.pensje.kwota >2000 and ksiegowosc.premia.rodzaj LIKE 'brak';

--D
SELECT ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko FROM ksiegowosc.pracownicy
WHERE ksiegowosc.pracownicy.imie LIKE 'J%'

--E
SELECT ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko FROM ksiegowosc.pracownicy
WHERE ksiegowosc.pracownicy.nazwisko LIKE '%A' AND ksiegowosc.pracownicy.nazwisko like '%N%'

--F
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko,( ksiegowosc.godziny.liczba_godzin*20)-160 AS nadgodziny FROM ksiegowosc.pracownicy INNER JOIN(ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny) ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
WHERE ( ksiegowosc.godziny.liczba_godzin*20)-160>0

--G
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensje.kwota
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje on ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji) INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.pensje.kwota BETWEEN 1500 AND 3000;

--H
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika INNER JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny INNER JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii  
WHERE (ksiegowosc.godziny.liczba_godzin*20)-160>0 AND ksiegowosc.premia.rodzaj LIKE 'brak'

--I
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensje.kwota FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji

--J
SELECT ksiegowosc.pracownicy.imie,ksiegowosc.pracownicy.nazwisko,ksiegowosc.pensje.kwota, ksiegowosc.premia.kwota FROM ((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji) 
INNER JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pensje.kwota DESC, ksiegowosc.premia.kwota DESC;

--K
SELECT ksiegowosc.pensje.stanowisko, count(ksiegowosc.pensje.stanowisko) AS policzone FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
GROUP BY ksiegowosc.pensje.stanowisko;

--L
SELECT ksiegowosc.pensje.stanowisko, AVG(ksiegowosc.pensje.kwota) AS srednia, MIN(ksiegowosc.pensje.kwota) AS minim, MAX(ksiegowosc.pensje.kwota) as maks from ksiegowosc.pensje
where ksiegowosc.pensje.stanowisko like 'kierownik produkcji'
group by ksiegowosc.pensje.stanowisko;

--M
SELECT SUM(ksiegowosc.pensje.kwota + ksiegowosc.premia.kwota) AS wynagrodzenia,SUM(ksiegowosc.pensje.kwota) AS pensje,SUM(ksiegowosc.premia.kwota) AS premie FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji)
INNER JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii;

--F
SELECT ksiegowosc.pensje.stanowisko, SUM(ksiegowosc.pensje.kwota) AS wynagrodzenie_stanowiska FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
GROUP BY ksiegowosc.pensje.stanowisko;

--G 

SELECT ksiegowosc.pensje.stanowisko, COUNT(ksiegowosc.premia.id_premii) AS liczba_premii FROM ksiegowosc.pensje
LEFT OUTER JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.premia.id_premii
GROUP BY ksiegowosc.pensja.stanowisko;

--H
DELETE ksiegowosc.pracownicy FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji WHERE ksiegowosc.pensje.kwota<1200;
	

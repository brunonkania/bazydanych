
SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.godziny;
SELECT * FROM ksiegowosc.pensje;
SELECT * FROM ksiegowosc.premia;
SELECT * FROM ksiegowosc.wynagrodzenie;

--A
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon)


--B
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 4, 3), '-', SUBSTRING(telefon, 7, 3))


--C
SELECT UPPER(nazwisko) AS najdluzsze_nazwisko
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy)

--D
SELECT
    CONVERT(VARCHAR(32), HASHBYTES('md5', imie), 2) AS imie,
    CONVERT(VARCHAR(32), HASHBYTES('md5', nazwisko), 2) AS nazwisko,
    CONVERT(VARCHAR(32), HASHBYTES('md5', CAST(ksiegowosc.pensje.kwota AS VARCHAR(32))), 2) AS pensje
FROM
    ksiegowosc.wynagrodzenie
INNER JOIN
    ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
INNER JOIN
    ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji;


--F
SELECT
  ksiegowosc.pracownicy.imie,
  ksiegowosc.pracownicy.nazwisko,
  ksiegowosc.pensje.kwota AS pensje,
  ksiegowosc.premia.kwota AS premie
FROM
  ksiegowosc.wynagrodzenie
LEFT JOIN
  ksiegowosc.pracownicy
ON
  ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
LEFT JOIN
  ksiegowosc.pensje
ON
  ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji
LEFT JOIN
  ksiegowosc.premia
ON
  ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii;

--G
SELECT
  'Pracownik ' + ksiegowosc.pracownicy.imie + ' ' + ksiegowosc.pracownicy.nazwisko +
  ', w dniu ' + CONVERT(varchar(10), CONVERT(date, ksiegowosc.wynagrodzenie.dataa), 104) +
  ' otrzyma³ pensjê ca³kowit¹ na kwotê ' +
  CONVERT(varchar(10), (ksiegowosc.pensje.kwota + ksiegowosc.premia.kwota +
  CASE WHEN (ksiegowosc.godziny.liczba_godzin * 20) - 160 < 0 THEN 0 ELSE ((ksiegowosc.godziny.liczba_godzin * 20) - 160) * 20 END)) +
  ' z³, gdzie wynagrodzenie zasadnicze wynosi³o ' +
  CAST(ksiegowosc.pensje.kwota AS varchar(10)) + ' z³, premia: ' +
  CAST(ksiegowosc.premia.kwota AS varchar(10)) + ' z³, nadgodziny: ' +
  CONVERT(varchar(7), (CASE WHEN (ksiegowosc.godziny.liczba_godzin * 20) - 160 < 0 THEN 0 ELSE ((ksiegowosc.godziny.liczba_godzin * 20) - 160) * 20 END)) + ' z³.' AS raport
FROM
  ksiegowosc.wynagrodzenie
LEFT JOIN
  ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
LEFT JOIN
  ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji
LEFT JOIN
  ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
LEFT JOIN
  ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny;


-- 1. Zestawienie firm produkcyjnych, i iloœci wyprodukowanych przez nie filmów, których d³ugoœæ jest wiêksza od œredniej d³ugoœæi wszystkich filmów
GO
CREATE VIEW Firma_Liczba(Firma, Liczba_Filmów)
AS SELECT Firmy_produkcyjne.Nazwa AS Firma, COUNT(*) AS Liczba_Filmów
	FROM Firmy_produkcyjne, Fil_Fir, Filmy
	WHERE Fil_Fir.Film = Filmy.Id
	AND Fil_Fir.Firma_produkcyjna = Firmy_produkcyjne.Id
	AND Filmy.D³ugoœæ > (SELECT AVG(Filmy.D³ugoœæ) FROM Filmy)
	GROUP BY Firmy_produkcyjne.Nazwa;
GO

SELECT * FROM Firma_Liczba;
DROP VIEW Firma_Liczba;

-- 2. Zestawienie posortowanych bud¿etów filmów, których box office by³ wiêkszy ni¿ œredni box office wszystkich filmów
GO
CREATE VIEW Tytu³_Bud¿et(Tytu³_Filmu, Bud¿et)
	AS SELECT Filmy.Tytu³, Filmy.Bud¿et
	FROM Filmy
	WHERE Box_office > (SELECT AVG(Box_office) FROM Filmy)
	ORDER BY Filmy.Bud¿et DESC OFFSET 0 ROWS;
GO

SELECT * FROM Tytu³_Bud¿et;
DROP VIEW Tytu³_Bud¿et;

-- 3. Podaj u¿ytkownika, który napisa³ najwiêcej komentarzy, wyœwietl te¿ kraj z którego pochodzi
SELECT TOP 1 Komentarze.U¿ytkownik, COUNT(*) AS "Liczba komentarzy", U¿ytkownicy.Kraj
	FROM Komentarze, U¿ytkownicy
	WHERE Komentarze.U¿ytkownik = U¿ytkownicy.Nazwa_u¿ytkownika
	GROUP BY Komentarze.U¿ytkownik, U¿ytkownicy.Kraj
	ORDER BY [Liczba komentarzy] DESC;

-- 4. Podaj srednia ocene wszystkich filmow, posortowane malejaco
SELECT Filmy.Tytu³, AVG(Cast(Oceny.Ocena AS FLOAT)) AS AvgOcena
	FROM Filmy JOIN Oceny ON Oceny.Film=Filmy.Id
	GROUP BY Filmy.Tytu³
	ORDER BY AvgOcena DESC;

-- 5. Posortowana lista aktorów, ktorzy urodzili sie przed 1980 i którzy grali w wiêcej ni¿ jednym filmie
SELECT Osoba.Imiê, Osoba.Nazwisko, Osoba.Data_urodzenia, COUNT(*) AS Liczba
	FROM Osoba JOIN Aktorzy ON Osoba.Id = Aktorzy.Osoba
	WHERE Osoba.Data_urodzenia < '1980-01-01'
	GROUP BY Osoba.Imiê, Osoba.Nazwisko, Osoba.Data_urodzenia
	HAVING COUNT(*) > 1
	ORDER BY Osoba.Data_urodzenia;

-- 6. Liczba filmów, które znajduj¹ siê w watchlistach u¿ytkowników, i które zosta³y wydane po 2010
SELECT Watchlisty.U¿ytkownik, COUNT(Filmy.Tytu³) AS 'Liczba filmów'
	FROM Filmy, Wat_Fil, Watchlisty
	WHERE Wat_Fil.Film = Filmy.Id
	AND Wat_Fil.Watchlist = Watchlisty.Id
	AND Filmy.Data_wydania > '2010-01-01'
	GROUP BY Watchlisty.U¿ytkownik
	ORDER BY [Liczba filmów] DESC;

-- 7. Liczba gatunków filmów w których gra³ jakiœ aktor
SELECT Gatunki.Gatunek, COUNT(*) AS Liczba
	FROM Filmy, Gatunki, Ga_Fil, Osoba, Aktorzy
	WHERE Ga_Fil.Film = Filmy.Id
	AND Ga_Fil.Gatunek = Gatunki.Id
	AND Osoba.Id = Aktorzy.Osoba
	AND Aktorzy.Film = Filmy.Id
	AND Osoba.Imiê = 'Christian'
	AND Osoba.Nazwisko = 'Bale'
	GROUP BY Gatunki.Gatunek
	ORDER BY Liczba DESC;

-- 8. Film, który znajduje siê w najstarszej watchliœcie, i którego bud¿et by³ najmniejszy
SELECT Filmy.Tytu³, Filmy.Bud¿et
	FROM Filmy
	WHERE Filmy.Bud¿et = 
		(SELECT MIN(Filmy.Bud¿et)
			FROM Filmy, Wat_Fil, Watchlisty
			WHERE Wat_Fil.Film = Filmy.Id
			AND Wat_Fil.Watchlist = Watchlisty.Id
			AND Watchlisty.Data_stworzenia = (SELECT MIN(Watchlisty.Data_stworzenia) FROM Watchlisty));

-- 9. W¹tki, które zawieraj¹ najwiêcej komentarzy
SELECT W¹tki.Tytu³, W¹tki.U¿ytkownik, COUNT(*) AS Liczba 
	FROM W¹tki JOIN Komentarze ON W¹tki.Id = Komentarze.W¹tek
	GROUP BY W¹tki.Tytu³, W¹tki.U¿ytkownik
	ORDER BY Liczba DESC;


-- 1. Zestawienie firm produkcyjnych, i ilo�ci wyprodukowanych przez nie film�w, kt�rych d�ugo�� jest wi�ksza od �redniej d�ugo��i wszystkich film�w
GO
CREATE VIEW Firma_Liczba(Firma, Liczba_Film�w)
AS SELECT Firmy_produkcyjne.Nazwa AS Firma, COUNT(*) AS Liczba_Film�w
	FROM Firmy_produkcyjne, Fil_Fir, Filmy
	WHERE Fil_Fir.Film = Filmy.Id
	AND Fil_Fir.Firma_produkcyjna = Firmy_produkcyjne.Id
	AND Filmy.D�ugo�� > (SELECT AVG(Filmy.D�ugo��) FROM Filmy)
	GROUP BY Firmy_produkcyjne.Nazwa;
GO

SELECT * FROM Firma_Liczba;
DROP VIEW Firma_Liczba;

-- 2. Zestawienie posortowanych bud�et�w film�w, kt�rych box office by� wi�kszy ni� �redni box office wszystkich film�w
GO
CREATE VIEW Tytu�_Bud�et(Tytu�_Filmu, Bud�et)
	AS SELECT Filmy.Tytu�, Filmy.Bud�et
	FROM Filmy
	WHERE Box_office > (SELECT AVG(Box_office) FROM Filmy)
	ORDER BY Filmy.Bud�et DESC OFFSET 0 ROWS;
GO

SELECT * FROM Tytu�_Bud�et;
DROP VIEW Tytu�_Bud�et;

-- 3. Podaj u�ytkownika, kt�ry napisa� najwi�cej komentarzy, wy�wietl te� kraj z kt�rego pochodzi
SELECT TOP 1 Komentarze.U�ytkownik, COUNT(*) AS "Liczba komentarzy", U�ytkownicy.Kraj
	FROM Komentarze, U�ytkownicy
	WHERE Komentarze.U�ytkownik = U�ytkownicy.Nazwa_u�ytkownika
	GROUP BY Komentarze.U�ytkownik, U�ytkownicy.Kraj
	ORDER BY [Liczba komentarzy] DESC;

-- 4. Podaj srednia ocene wszystkich filmow, posortowane malejaco
SELECT Filmy.Tytu�, AVG(Cast(Oceny.Ocena AS FLOAT)) AS AvgOcena
	FROM Filmy JOIN Oceny ON Oceny.Film=Filmy.Id
	GROUP BY Filmy.Tytu�
	ORDER BY AvgOcena DESC;

-- 5. Posortowana lista aktor�w, ktorzy urodzili sie przed 1980 i kt�rzy grali w wi�cej ni� jednym filmie
SELECT Osoba.Imi�, Osoba.Nazwisko, Osoba.Data_urodzenia, COUNT(*) AS Liczba
	FROM Osoba JOIN Aktorzy ON Osoba.Id = Aktorzy.Osoba
	WHERE Osoba.Data_urodzenia < '1980-01-01'
	GROUP BY Osoba.Imi�, Osoba.Nazwisko, Osoba.Data_urodzenia
	HAVING COUNT(*) > 1
	ORDER BY Osoba.Data_urodzenia;

-- 6. Liczba film�w, kt�re znajduj� si� w watchlistach u�ytkownik�w, i kt�re zosta�y wydane po 2010
SELECT Watchlisty.U�ytkownik, COUNT(Filmy.Tytu�) AS 'Liczba film�w'
	FROM Filmy, Wat_Fil, Watchlisty
	WHERE Wat_Fil.Film = Filmy.Id
	AND Wat_Fil.Watchlist = Watchlisty.Id
	AND Filmy.Data_wydania > '2010-01-01'
	GROUP BY Watchlisty.U�ytkownik
	ORDER BY [Liczba film�w] DESC;

-- 7. Liczba gatunk�w film�w w kt�rych gra� jaki� aktor
SELECT Gatunki.Gatunek, COUNT(*) AS Liczba
	FROM Filmy, Gatunki, Ga_Fil, Osoba, Aktorzy
	WHERE Ga_Fil.Film = Filmy.Id
	AND Ga_Fil.Gatunek = Gatunki.Id
	AND Osoba.Id = Aktorzy.Osoba
	AND Aktorzy.Film = Filmy.Id
	AND Osoba.Imi� = 'Christian'
	AND Osoba.Nazwisko = 'Bale'
	GROUP BY Gatunki.Gatunek
	ORDER BY Liczba DESC;

-- 8. Film, kt�ry znajduje si� w najstarszej watchli�cie, i kt�rego bud�et by� najmniejszy
SELECT Filmy.Tytu�, Filmy.Bud�et
	FROM Filmy
	WHERE Filmy.Bud�et = 
		(SELECT MIN(Filmy.Bud�et)
			FROM Filmy, Wat_Fil, Watchlisty
			WHERE Wat_Fil.Film = Filmy.Id
			AND Wat_Fil.Watchlist = Watchlisty.Id
			AND Watchlisty.Data_stworzenia = (SELECT MIN(Watchlisty.Data_stworzenia) FROM Watchlisty));

-- 9. W�tki, kt�re zawieraj� najwi�cej komentarzy
SELECT W�tki.Tytu�, W�tki.U�ytkownik, COUNT(*) AS Liczba 
	FROM W�tki JOIN Komentarze ON W�tki.Id = Komentarze.W�tek
	GROUP BY W�tki.Tytu�, W�tki.U�ytkownik
	ORDER BY Liczba DESC;

--CASCADE Z DELETE 1.0
SELECT * FROM Aktorzy
SELECT * FROM Osoba
DELETE FROM Osoba WHERE Id=2
SELECT * FROM Aktorzy
SELECT * FROM Osoba

--CASCADE Z DELETE 2.0
SELECT * FROM Komentarze
SELECT * FROM W�tki
DELETE FROM W�tki WHERE U�ytkownik='batman'
SELECT * FROM Komentarze
SELECT * FROM W�tki

--CASCADE Z UPDATE 1.0
SELECT * FROM Gatunki
SELECT * FROM Ga_Fil
UPDATE Gatunki SET Id=123 WHERE Id=1
SELECT * FROM Gatunki
SELECT * FROM Ga_Fil

--CASCADE Z UPDATE 2.0
SELECT * FROM Filmy
SELECT * FROM Oceny
UPDATE Filmy SET Id=12321 WHERE Id=1
SELECT * FROM Filmy
SELECT * FROM Oceny


--SELECT * FROM Dummytable1;
--SELECT * FROM Dummytable2;
SELECT * FROM Fil_Fir;
SELECT * FROM Ga_Fil;
SELECT * FROM Wat_Fil;
SELECT * FROM Funkcja;
SELECT * FROM Aktorzy;
SELECT * FROM Osoba;
SELECT * FROM Firmy_produkcyjne;
SELECT * FROM Gatunki;
SELECT * FROM Watchlisty;
SELECT * FROM Komentarze;
SELECT * FROM W�tki;
SELECT * FROM Oceny;
SELECT * FROM Filmy;
SELECT * FROM U�ytkownicy;

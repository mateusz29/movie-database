CREATE TABLE U¿ytkownicy(
	Nazwa_u¿ytkownika varchar(20) PRIMARY KEY,
	Haslo varchar(40) NOT NULL,
	Email varchar(40) UNIQUE,
	Kraj varchar(30) NOT NULL,
	Bio varchar(4000) NOT NULL,
	Avatar varchar(100) DEFAULT 'https://i.imgur.com/hepj9ZS.png'
);

CREATE TABLE Filmy(
	Id int PRIMARY KEY,
	Tytu³ varchar(50) NOT NULL,
	Opis varchar(5000) NOT NULL,
	Ocena int CHECK (Ocena >= 1 AND OCENA <= 10),
	Bud¿et int CHECK (Bud¿et > 0),
	D³ugoœæ int CHECK (D³ugoœæ > 0),
	Data_wydania date,
	Jêzyk varchar(20) NOT NULL,
);

CREATE TABLE Oceny(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Ocena int CHECK (Ocena >= 1 AND OCENA <= 10),
	Opis varchar(4000) NOT NULL,
	Data_stworzenia date NOT NULL,
	U¿ytkownik varchar(20) FOREIGN KEY REFERENCES U¿ytkownicy(Nazwa_u¿ytkownika) ON DELETE CASCADE ON UPDATE CASCADE,
	Film int REFERENCES Filmy(Id) ON UPDATE CASCADE
);

CREATE TABLE W¹tki(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Tytu³ varchar(100) NOT NULL,
	Opis varchar(5000) NOT NULL,
	U¿ytkownik varchar(20) FOREIGN KEY REFERENCES U¿ytkownicy(Nazwa_u¿ytkownika) ON DELETE SET NULL,
	Film int REFERENCES Filmy(Id) ON UPDATE CASCADE
);

CREATE TABLE Komentarze(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Tekst varchar(2000) NOT NULL,
	Data_stworzenia date NOT NULL,
	W¹tek int REFERENCES W¹tki ON DELETE CASCADE ON UPDATE CASCADE,
	U¿ytkownik varchar(20) FOREIGN KEY REFERENCES U¿ytkownicy(Nazwa_u¿ytkownika) ON UPDATE CASCADE
);

CREATE TABLE Watchlisty(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Data_stworzenia date NOT NULL,
	Nazwa varchar(100) NOT NULL,
	U¿ytkownik varchar(20) FOREIGN KEY REFERENCES U¿ytkownicy(Nazwa_u¿ytkownika) ON DELETE CASCADE ON UPDATE CASCADE
);
 
 CREATE TABLE Gatunki(
	Id int PRIMARY KEY,
	Gatunek varchar(30) UNIQUE
 );

 CREATE TABLE Firmy_produkcyjne(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Nazwa varchar(50) UNIQUE,
	W³aœciciel varchar(50) NOT NULL,
	Za³o¿yciel varchar(50) NOT NULL
 );

 CREATE TABLE Osoba(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Imiê varchar(20) NOT NULL,
	Nazwisko varchar(20) NOT NULL,
	Data_urodzenia date,
	Bio varchar(3000)
 );

CREATE TABLE Aktorzy(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Typ_roli varchar(50) NOT NULL,
	Osoba int FOREIGN KEY REFERENCES Osoba(Id) ON DELETE CASCADE,
	Film int FOREIGN KEY REFERENCES Filmy(Id) ON UPDATE CASCADE
);

CREATE TABLE Funkcja(
	Id int IDENTITY (1, 1) PRIMARY KEY,
	Nazwa_funkcji varchar(50) NOT NULL,
	Osoba int FOREIGN KEY REFERENCES Osoba(Id) ON DELETE CASCADE,
	Film int FOREIGN KEY REFERENCES Filmy(Id) ON UPDATE CASCADE
);

CREATE TABLE Wat_Fil(
	Watchlist int FOREIGN KEY REFERENCES Watchlisty(Id) ON DELETE CASCADE,
	Film int FOREIGN KEY REFERENCES Filmy(Id) ON UPDATE CASCADE,
	PRIMARY KEY (Watchlist, Film)
);

CREATE TABLE Ga_Fil(
	Gatunek int FOREIGN KEY REFERENCES Gatunki(Id) ON UPDATE CASCADE,
	Film int FOREIGN KEY REFERENCES Filmy(Id) ON UPDATE CASCADE,
	PRIMARY KEY (Gatunek, Film)
);

CREATE TABLE Fil_Fir(
	Film int FOREIGN KEY REFERENCES Filmy(Id) ON UPDATE CASCADE,
	Firma_produkcyjna int FOREIGN KEY REFERENCES Firmy_produkcyjne(Id) ON UPDATE CASCADE,
	PRIMARY KEY (Film, Firma_produkcyjna)
);

ALTER TABLE Filmy
	ADD Box_office bigint;

CREATE TABLE Dummytable1(
	Atrybut1 int,
	Atrybut2 varchar(20),
	Atrybut3 varchar(30),
	PRIMARY KEY (Atrybut1, Atrybut2)
);

CREATE TABLE Dummytable2(
	Atrybut1 int,
	Atrybut2 varchar(20),
	Atrybut3 date
	FOREIGN KEY (Atrybut1, Atrybut2) REFERENCES Dummytable1
);
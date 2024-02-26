CREATE TABLE [dbo].[Transakcje]
(
	IdTransakcji INT IDENTITY(1,1) PRIMARY KEY,
	TypTransakcji NVARCHAR(10) NOT NULL,
	KwotaTransakcji DECIMAL NOT NULL,
	KontoWyjsciowe INT FOREIGN KEY REFERENCES Konta(IdKonta),
	KontoDocelowe INT FOREIGN KEY REFERENCES Konta(IdKonta)
)

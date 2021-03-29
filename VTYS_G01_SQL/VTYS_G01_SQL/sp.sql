--Sp Insert--
--Model Id'si 12 olan,model adý Panaroma olan ve Araçtip no 3 
--olan aracý Model tablosuna ekle
IF OBJECT_ID('SPInsert') IS NOT NULL
   BEGIN
      DROP PROCEDURE SPInsert
   END
GO

CREATE PROCEDURE SPInsert(@ýd INT, @ad VARCHAR(20), @tipno INT)
AS
INSERT INTO model VALUES(@ýd,@ad,@tipno )
SELECT m.ModelID, m.ModelAD,ar.AraçTipNo
FROM
model m INNER JOIN AraçTipi ar ON m.AraçTipNo=ar.AraçTipNo

EXEC SPInsert 14,'Panaroma',3

SELECT * FROM model









IF OBJECT_ID('SPDelete') IS NOT NULL
  BEGIN
    DROP PROCEDURE SPUpdate
  END
GO

CREATE PROCEDURE SPDelete (@soyad VARCHAR(20), @cinsiyet varchar(6))
AS
DELETE FROM Uyee 
WHERE len(Uyee.Ad) >7 AND Uyee.Ad like 'a%' 
AND Uyee.Soyad = @soyad AND Uyee.Cinsiyet=@cinsiyet

EXEC SPDelete 'Akman', 'ERKEK'

SELECT* FROM Uyee














-- SPUpdate 1 --
--Durak ID 3den küçük olan seferduraklardaki duraklardan geçen ve 
--alýndýðý yýl 2015 üstün olan
--seferlerdeki araç ya da araçlarýn  arac plakayý 446 ve kapasitesini 80 yap.
IF OBJECT_ID('SPUpdate') IS NOT NULL
    DROP PROCEDURE SPUpdate
GO
CREATE PROCEDURE SPUpdate (@plaka varchar(20),@kapasite int)
AS
UPDATE Arac
SET Arac.Plaka  = @plaka, Arac.Kapasite  = @kapasite
FROM Arac A
INNER JOIN Sefer S ON S.AracID = A.AracID
INNER JOIN SEFERDURAK d ON d.SeferID = S.SeferID
WHERE d.DurakID < 3 AND a.AlýndýgýYýl>2015

exec SPUpdate '445',80

select*from Arac


















 -- Emre Liman
 -- Araç id si verilen aracýn istenilen sayýya aracýn kapasitesini arttýrýr (cursor kullanýmlý)
 IF OBJECT_ID('kapasite_arttýr') IS NOT NULL
 BEGIN
 DROP PROCEDURE kapasite_arttýr
 END
 GO

 CREATE OR ALTER PROCEDURE kapasite_arttýr(
	@aracid INT,@kapasite INT
)
AS BEGIN
  DECLARE @id INT;
  DECLARE @ckapasite INT ;
  DECLARE cr_kapasite CURSOR FOR SELECT AracID,Kapasite FROM dbo.Arac WHERE AracID=@aracid
  
  OPEN cr_kapasite
  FETCH NEXT FROM cr_kapasite INTO @id,@ckapasite
  WHILE ( @@FETCH_STATUS = 0) 
  BEGIN 
        UPDATE dbo.Arac SET Kapasite=@kapasite WHERE AracID=@aracid
  
  FETCH NEXT FROM cr_kapasite INTO @id,@ckapasite
  END
  CLOSE cr_kapasite
  DEALLOCATE cr_kapasite
  SELECT * FROM dbo.Arac
  END
  GO

  EXEC kapasite_arttýr 1,200

  GO

  


















  
--SP SELECT
--PERSONEL GOREVTURU MUAVÝN OLAN VE PERSONELÝN ÇALIÞTIÐI ÝL ADI 5 KARAKTERDEN BUYUK OLAN
--PERSONELÝN ÝSÝM,SOYÝSÝM,TC'SÝNÝ GETÝR.

IF OBJECT_ID('SpBiletBilgiler10') IS NOT NULL
  BEGIN
    DROP PROCEDURE SpBiletBilgiler10
  END
GO

	CREATE PROCEDURE SpBiletBilgiler10(@Gorevtur Varchar(20))
        AS
     BEGIN
	SELECT P.Ýsim, P.SoyIsim, P.TelNo FROM personel P
	INNER JOIN IL I ON P.IlNO=I.IlNO
	INNER JOIN Unvan U ON P.UnvanNo=U.UnvanNo
	WHERE  U.GorevTuru = @Gorevtur AND LEN(ÝlAdý) > 5
	END
     EXEC SpBiletBilgiler10 @Gorevtur= 'Muavin'



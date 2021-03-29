---FUNCTION----
---Üye adý ve soyadý verilen yolcunun sefer yaptýgý durak bilgilerini birteþtirerek donduren sorgu


IF OBJECT_ID ('durakBilgi1') IS NOT NULL
	BEGIN
		DROP FUNCTION durakBilgi1
	END

CREATE OR ALTER FUNCTION durakBilgi1(@ad VARCHAR(60),@soyad VARCHAR(60))
RETURNS VARCHAR(60) 
AS
	BEGIN --- BÝLET UYE TCDEN ÇAKIÞTIR
	DECLARE @sonuc VARCHAR(60)
	DECLARE @1 VARCHAR(60)
	DECLARE @2 VARCHAR(60)
	DECLARE @3 VARCHAR(60)
	DECLARE @4 VARCHAR(60)
	SET @1 = CAST((SELECT D.DurakID  FROM Bilet B INNER JOIN Peron P ON B.PeronID = P.PeronId
			  INNER JOIN Durak D ON P.DurakID = D.DurakID INNER JOIN Uyee U ON U.TcNo = B.UyeTcNo 
			  WHERE U.Ad = @ad AND @soyad = U.Soyad) AS varchar(60))
	(SELECT @2 =  D.DurakAd  FROM Bilet B INNER JOIN Peron P ON B.PeronID = P.PeronId
			  INNER JOIN Durak D ON P.DurakID = D.DurakID INNER JOIN Uyee U ON U.TcNo = B.UyeTcNo 
			  WHERE U.Ad = @ad AND @soyad = U.Soyad)
	SET @3 = CAST((SELECT D.IlNO  FROM Bilet B INNER JOIN Peron P ON B.PeronID = P.PeronId
			  INNER JOIN Durak D ON P.DurakID = D.DurakID INNER JOIN Uyee U ON U.TcNo = B.UyeTcNo 
			  WHERE U.Ad = @ad AND @soyad = U.Soyad) AS VARCHAR(60))
	SET @4 = CAST((SELECT D.IlceNO  FROM Bilet B INNER JOIN Peron P ON B.PeronID = P.PeronId
			  INNER JOIN Durak D ON P.DurakID = D.DurakID INNER JOIN Uyee U ON U.TcNo = B.UyeTcNo 
			  WHERE U.Ad = @ad AND @soyad = U.Soyad) AS VARCHAR(60))
		SELECT   @sonuc = CONCAT(@1,@2,@3,@4)
	 RETURN @sonuc
	 END

SELECT * FROM dbo.MusteriBilgi
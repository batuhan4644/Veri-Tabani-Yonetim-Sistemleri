---View---
---Personellerin Bilet kestikleri müþterilerin  check in yapan ve ögrenci olan müþterilerin bilgileri

IF OBJECT_ID ('MusteriBilgi') IS NOT NULL
	BEGIN
		DROP VIEW MusteriBilgi
	END

SELECT TcNO FROM Uyee
SELECT UyeTcNo,CheckInDurumu FROM Bilet
SELECT * From BiletTuru
GO
CREATE OR ALTER VIEW dbo.MusteriBilgi
	AS 
	SELECT U.TcNo,U.Ad,U.Soyad,U.Cinsiyet,U.Telno,U.Mail,U.IlNO,U.IlceNO ,
	BT.Isim
	FROM Uyee U INNER JOIN Bilet B ON U.TcNo = B.UyeTcNo  INNER JOIN 
	Personel P ON P.PersonelNo = B.PersonelNo INNER JOIN BiletTuru BT ON 
	BT.BiletTuruNo = B.BiletTuruNo
	WHERE U.TcNo IN (SELECT UyeTcNo FROM Bilet WHERE CheckInNo IS NOT NULL)
	INTERSECT 
    SELECT U.TcNo,U.Ad,U.Soyad,U.Cinsiyet,U.Telno,U.Mail,U.IlNO,U.IlceNO ,BT.Isim
	FROM Uyee U INNER JOIN Bilet B ON U.TcNo = B.UyeTcNo  INNER JOIN 
	Personel P ON P.PersonelNo = B.PersonelNo INNER JOIN BiletTuru BT ON 
	BT.BiletTuruNo = B.BiletTuruNo WHERE BT.Isim ='Öðrenci'

SELECT * FROM dbo.MusteriBilgi
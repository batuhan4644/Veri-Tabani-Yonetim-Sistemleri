-- Personel no, isim, soyisim ve telno girdiðimiz takdirde personel eklemesi yapan transaction kullanýmlý sp

   IF OBJECT_ID('personel_ekle') IS NOT NULL
  BEGIN
  DROP PROCEDURE personel_ekle
  END
  GO

  CREATE OR ALTER PROCEDURE personel_ekle(
	@personelno INT,@isim VARCHAR(100),@soyisim VARCHAR(100),@tel INT
)
 AS BEGIN
   BEGIN TRANSACTION 
   
   IF (@personelno NOT IN(SELECT PersonelNO FROM dbo.Personel))
   BEGIN
   INSERT INTO dbo.Personel (PersonelNo,Ýsim,SoyIsim,TelNo)
   VALUES (@personelno,@isim,@soyisim,@tel)
   PRINT('Ýþlem baþarý ile gerçekleþtirildi...')
   END
   ELSE
   PRINT('Bu id ile çakýþan personel bulunmaktadýr...')
    IF @@ERROR <> 0
        ROLLBACK
	COMMIT

  END

  GO

  EXEC personel_ekle 17,Beth,Harmon,564658545
  SELECT * FROM dbo.Personel


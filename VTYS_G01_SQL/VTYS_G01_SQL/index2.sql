CREATE NONCLUSTERED INDEX idxUyeeAdiSoyadi ON Uyee(Ad)

SET STATISTICS IO ON
SELECT Ad from Uyee
Where Ad = 'Atahan'
SELECT Soyad from Uyee
WHERE Soyad ='Adanýr'


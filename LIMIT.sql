-- LIMIT --

-- Kisiler tablosundan ilk 5 veriyi listeleyiniz
select * from kisiler limit 5;

-- Ilk iki veriden sonra 5 veriyi listeleyiniz
select * from kisiler limit 5 offset 2; -- Ilk iki veriden sonra dedigi icin OFFSET ile ilk 2'yi atliyoruz

-- id degeri 5'den buyuk olan ilk iki veriyi listeleyiniz.
select * from kisiler where id > 5 limit 2;

-- Maas'i en yuksek 3 kisinin bilgilerini listeleyiniz.
select * from kisiler order by maas desc limit 3;

-- EN yuksek maasi alan 4, 5, 6. kisilerin bilgilerini listeleyiniz.
select * from kisiler order by maas desc limit 3 offset 3;


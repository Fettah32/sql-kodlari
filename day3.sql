CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yilmaz, 5000,'2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- Unique
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY

SELECT * FROM calisanlar

-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');


select * from adresler;


INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız


INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için


select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;


DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir

delete from calisanlar where id = '10002'; --Parent
--Once child'dan silmezsek Parent'tan silmeye izin vermiyor

delete from adresler where adres_id = '10002'; --Child
--Once buradan sildik sonra parent'dan yani calisanlar table'dan.

Drop table calisanlar; -- child table varken silemeyiz.

-- ON DELETE CASCADE --
--Her defasinda once child tablo'daki verileri silmek yerine, 
--ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz.
--Bunun icin FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmamiz yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

select * from talebeler;

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from notlar;

delete from notlar where talebe_id = '123';

delete from talebeler where id = '126'; --ON DELETE CASCADE kullandigimiz icin parent table'dan direk silebildik
--Parent table'dan sildigimiz icin child table'dan da silinmis olur.

Delete from talebeler;

DROP table talebeler CASCADE; -- Parent tabloyu kaldirmak istersek DROP table tablo_adi'ndan sonra
-- CASCADE komutunu kullaniriz.

-- Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz ve veri tipini VARCHAR(30) olarak degistiriniz.
alter table talebeler 
alter column isim TYPE VARCHAR(30), 
alter column isim SET NOT NULL;

select * from talebeler;

--Talebeler tablosundaki yazili_notu sutununa sadece 60'dan buyuk rakam girilebilsin.
alter table talebeler
add CONSTRAINT sinir CHECK (yazili_notu > 60);
--CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
--Yukarida 60'i sinir olarak belirledigimiz icin bunu eklemedi.

INSERT INTO talebeler VALUES(128, 'Mustafa Can', 'Hasan',45);-- sinir 60 oldugu icin eklemez.

create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;

--Tablodaki bir sutuna PRIMARY KEY ekleme 
alter table ogrenciler 
add primary key (id); 

--PRIMARY KEY olusturmada ikinci yol : 
alter table ogrenciler
add constraint fettah primary key (id);

--PK'dan sonra FK atamasi
alter table ogrenci_adres
add constraint fettah_fk foreign key (id) references ogrenciler;
--Child tabloyu parent tablodan olusturdugumuz icin sutun adi verilmedi

--FK'yi CONSTRAINT silme
alter table ogrenci_adres DROP CONSTRAINT fettah_fk;
--PK'yi CONSTRAINT silme
alter table ogrenciler DROP CONSTRAINT fettah;

--Yazili notu 85'den buyuk olan talebe bilgilerini getirin.
Select * from talebeler WHERE yazili_notu > 85;

--Ismi Mustafa Bak olan talebenin tum bilgilerini getirin.
Select * from talebeler WHERE isim = 'Mustafa Bak';

-- SELECT komutunda -- BETWEEN kosulu --
-- Between belirttiginiz iki veri arasindaki bilgileri listeler
-- Between'de belirttigimiz degerler de listelemeye dahildir.

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
    AND (ve) : Belirtilen sartlarin her ikisi de gerceklesiyorsa o kayit listelenir
Bir tanesi gerceklesmezse listelenmez.
	Selecekt * from matematik sinav1 > 50 AND sinav2 > 50 
Hem sinav1 hem de sinav2 alani, 50'den buyuk olan kayitlari listeler
	OR (veya) : Belirtilen sartlardan biri gerceklesirse, kayit listelenir
	Select * from matematik sinav1 > 50 OR sinav2 > 50
Hem sinav1 hem de sinav2 alani, 50'den buyuk olan kayitlari listeler.
*/
select * from personel

-- id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz.
select * from personel WHERE id BETWEEN '1003' and '1005'; 

-- 2.YOl
select * from personel WHERE id >= '1003' and id <= '1005';

--Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz.
select * from personel WHERE isim BETWEEN 'Derya Soylu' and 'Yavuz Bal';

--Maasi 70.000 veya ismi Sena olan personeli listele.
select * from personel where maas = 70000 or isim = 'Sena Beyaz';

--IN : Birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutta yazabilme imkani verir.
-- Farkli sutunlar icin IN kullanilamaz!!!

-- id'si 1001, 1002 ve 1004 olan personelin bilgilerini listele.
select * from personel where id = '1001' or id = '1002' or id = '1004'; 
-- 2.YOL :
select * from personel where id in ('1001','1002','1004');

--Maasi sadece 70000, 100000 olan personeli listele.
select * from personel where maas in (70000, 100000);

/*
SELECT - LIKE kosulu
LIKE : Sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ILIKE : Sorgulama yaparken buyuk/kucuk harfe duyarsiz olarak eslestir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE : !~~*

% --> 0 VEYA DAHA FAZLA KARAKTERI BELIRTIR
_ --> Tek bir karakteri belirtir.
*/

--Ismi A harfi ile baslayan personeli listele.
select * from personel where isim like 'A%';

--Ismi T harfi ile biten personeli listele.
select * from personel where isim like '%t';

--Isminin ikinci harfi 'e' olan personeli listeleyiniz.
select * from personel where isim like '_e%';

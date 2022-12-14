--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarına sahip personel_adres adında yeni tablo olusturalım
create table personel_adres
as
select pers_id, sehir, adres from personel;
select * from personel
-- DML --> Data Manupulation Lang.
-- INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri güncelleme ve silme işlemlerinde kullanılan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);
--Tabloya parçalı veri ekleme
insert into student(st_name,age) values ('Murat Can',65);
--DQL --> Data Query Lang.
--SELECT
select * from student;
select st_name from student;
--SELECT KOMUTU WHERE KOŞULU
select * from student WHERE age>35;
--TCL - Transaction Control Lang.
--Begin - Savepoint - rollback - commit
--Transaction veritabanı sistemlerinde bir işlem başladığında başlar ve işlem bitince sona erer
--Bu işlemler veri tabanı oluşturma, veri silme, veri güncelleme, veriyi geri getirme gibi işlemler olabilir
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 VALUES (default,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 VALUES (default,'Canan Gül','Ayşe Şen',90.5);
savepoint x;
insert into ogrenciler2 VALUES (default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 VALUES (default,'Ahmet Şen','Ayşe Can',65.5);
ROLLBACK TO x;
select * from ogrenciler2;
commit;
--Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez.
--savepointten sonra eklediğimiz veride sayaç mantığı ile çalıştığı için
--sayacta en son hangi sayıda kaldıysa ordan devam eder

--NOT: PostgreSQL de transaction kullanimi icin 'Begin' komutuyla baslariz sonrasinda tekrar yanlisbir veriyi
--duzeltmek veya bizim icin onemli olan verilerden sonra ekleme yapabilmek icin 'SAVEPOINT savepointadi'
--kullaniriz ve bu savepoint'e donebilmek icin 'ROLLBACK TO savepointadi' komutunu kullaniriz
--ve rollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri tabloda bize
--verir ve son olarak Transaction'i sonlandirmak icin mutlaka 'COMMIT' komutu kullaniriz. MySQL'de 
--transaction olmadan da kullanilir

--DML - DELETE - 
--DELETE FROM tablo_adi --> Tablo'nun tum icerigini siler 
-- Veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi = veri --> Tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

-- Soru : id'si 124 olan ogrenciyi siliniz.

DELETE FROM ogrenciler WHERE ID = 124;

-- Soru : Ismi Kemal Yasa olan satiri siliniz.

Delete From ogrenciler Where isim = 'Kemal Yasa';

-- Soru : Ismi Nesibe Yilmaz veya Mustafa Bak olan kayitlari silelim.

Delete From ogrenciler Where isim = 'Nesibe Yilmaz' Or isim = 'Mustafa Bak';

-- Soru : Ismi Ali Can ve id'si 123 olan kaydi siliniz.

Delete From ogrenciler Where isim = 'Ali Can' or id = 123;

-- Tablodaki tum verileri silelim
Delete From ogrenciler;

-- DELETE - TRUNCATE --
-- TRUNCATE komutu DELETE komutu gibi bir tablodaki tum verileri siler.
-- Ancak secmeli silme yapamaz.

Select * from ogrenciler
TRUNCATE TABLE ogrenciler

-- DDL - Data Definition Lang.
-- CREATE - ALTER - DROP

-- ALTER TABLE --
-- ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS islemleri icin kullanilir.

select * from personel;

-- Soru : Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz.
alter table personel add cinsiyet varchar(20), add yas int;

-- Soru : personel tablosundan sirket field'ini siliniz.
alter table personel drop column sirket;

-- Personel tablosundaki sehir sutununun adini ulke olarak degistirelim.
alter table personel RENAME column sehir to ulke;

-- Personel tablosunun adini isciler olarak degistiriniz.
alter table personel rename to isciler;

select * from isciler;

-- DDL - DROP komutu -
Drop table isciler;

-- CONSTRANINT -- Kisitlamalar
-- Primary Key --> Bir sutunun NULL icermemesini ve sutundaki verilerin benzersiz olmasini saglar (NOT NULL - UNIQUE)
-- Foreign Key --> Baska  bir tablodaki Primary Key'i referans gostermek icin kullanilir
-- Boylelikle, tab;p;ar arasinda iliski kurmus oluruz.
-- UNIQUE --> Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar
-- NOT NULL --> Bir sutunun NULL icermemesini yani bos olmamasini saglar 
-- NOT NULL kisitlamasi icin CONSTRAINT ismi tanimlanmaz. Bu kisitlama veri turunden hemen sonra yerlestirilir.
-- CHECK --> Bir sutuna yerlestirilebilecek deger araligini sinirlamak icin kullanilir.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yilmaz, 5000,'2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- Unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY

SELECT * FROM calisanlar

-- FOREIGN KEY --
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler




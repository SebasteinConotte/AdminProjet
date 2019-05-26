GRANT ALL PRIVILEGES ON *.* TO root@'%';

create database WoodyToys;
use WoodyToys;



CREATE TABLE Client
(
id_Client char(4) not null,
NOM  varchar(12) not null,
ADRESSE varchar(20) not null,
LOCALITE varchar(12) not null,
COMPTE decimal(9,2) not null,
primary key (id_Client)
) COMMENT='this is my client table';


insert into Client values ('B112','HANSENNE'    ,'23, a. Dumont'       ,'Poitiers' ,1250.00);
insert into Client values ('C123','MERCIER'     ,'25, r. Lemaitre'     ,'Namur'    ,-2300);
insert into Client values ('B332','MONTI'       ,'112, r. Neuve'       ,'Geneve'   ,0);
insert into Client values ('F010','TOUSSAINT'   ,'5, r. Godefroid'     ,'Poitiers' ,0);
insert into Client values ('K111','VANBIST'     ,'180, r. Florimont'   ,'Lille'    ,720);
insert into Client values ('S127','VANDERKA'    ,'3, av. des Roses'    ,'Namur'    ,-4580);

FLUSH PRIVILEGES;

create database WoodyToys;
use WoodyToys;

CREATE TABLE Account
(
id_User char(10) not null,
NOM  varchar(12) not null,
PSEUDO varchar(20) not null,
PASSWORD varchar(20) not null,
primary key (id_Client)
) COMMENT='this is my account table';

insert into Client values ('HE2015','Dumont April'    , 'a.Dumont'       ,'fg6f5gf6');
insert into Client values ('HE2019','Lemaitre Rachel'     , 'r.Lemaitre'     ,'g4h5h49');
insert into Client values ('HE1254','Neuve Rimond'       , 'r.Neuve'       ,'gf8g87f826');
insert into Client values ('HE1248','Godefroid Roger'   , 'r.Godefroid'     ,'gf54gh84564');
insert into Client values ('HE7411','Florimont Maxime'     , 'm.Florimont'   ,'f4h89y4hd4s');
insert into Client values ('HE4120','Priest Pascal' , 'p.Priest' ,'2g8rf4g986');

flush privileges;

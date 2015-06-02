DROP TABLE if EXISTS changable_content_h cascade;
DROP SEQUENCE IF EXISTS changable_content_h_seq;
DROP TABLE if EXISTS changable_content cascade;
DROP SEQUENCE IF EXISTS changable_content_seq;
DROP TABLE if EXISTS page cascade;
DROP SEQUENCE IF EXISTS page_seq;
DROP TABLE if EXISTS admin cascade;
DROP SEQUENCE IF EXISTS admin_seq;
DROP TABLE if EXISTS php_replications cascade;
DROP SEQUENCE IF EXISTS php_replications_seq;
DROP TABLE if EXISTS data cascade;
DROP SEQUENCE IF EXISTS data_seq;

CREATE SEQUENCE changable_content_seq INCREMENT 1 START 1;

CREATE TABLE changable_content
(
	ID INTEGER DEFAULT NEXTVAL('changable_content_seq'::TEXT) NOT NULL,
	page_id INTEGER NOT NULL,
	content TEXT NOT NULL,
	last_modify TIMESTAMP NOT NULL
);
ALTER TABLE changable_content ADD CONSTRAINT PK_Changable_Content
	PRIMARY KEY (ID)
;
CREATE SEQUENCE changable_content_h_seq INCREMENT 1 START 1;
CREATE TABLE changable_content_h
(
	ID INTEGER DEFAULT NEXTVAL('changable_content_h_seq'::TEXT) NOT NULL,
	base_id INTEGER NOT NULL,
	page_id INTEGER NOT NULL,
	content TEXT NOT NULL,
	last_modify TIMESTAMP NOT NULL
) 
;
ALTER TABLE changable_content_H ADD CONSTRAINT PK_Changable_Content_H
	PRIMARY KEY (ID)
;
CREATE SEQUENCE page_seq INCREMENT 1 START 1;
CREATE TABLE page
(
	ID INTEGER DEFAULT NEXTVAL('changable_content_h_seq'::TEXT) NOT NULL,
	name VARCHAR(128) NOT NULL
)
;
ALTER TABLE page ADD CONSTRAINT PK_Page
	PRIMARY KEY (ID)
;

CREATE SEQUENCE admin_seq INCREMENT 1 START 1;
CREATE TABLE admin
(
	ID INTEGER DEFAULT NEXTVAL('changable_content_h_seq'::TEXT) NOT NULL,
	name VARCHAR(128) NOT NULL,
	username VARCHAR(128) NOT NULL,
	password VARCHAR(256) NOT NULL
) 
;
ALTER TABLE admin ADD CONSTRAINT PK_Admin
	PRIMARY KEY (ID)
;
CREATE SEQUENCE php_replications_seq INCREMENT 1 START 1;
CREATE TABLE php_replications
(
	ID INTEGER DEFAULT NEXTVAL('changable_content_h_seq'::TEXT) NOT NULL,
	name VARCHAR(128) NOT NULL,
	web_url VARCHAR(256) NOT NULL,
	db_path VARCHAR(256) NOT NULL
)
;
ALTER TABLE php_replications ADD CONSTRAINT PK_php_replications
	PRIMARY KEY (ID)
;

CREATE SEQUENCE data_seq INCREMENT 1 START 1;
CREATE TABLE data
(
	ID INTEGER DEFAULT NEXTVAL('data_seq'::TEXT) NOT NULL,
	email VARCHAR(64) NOT NULL,
	address VARCHAR(128) NOT NULL,
	phone VARCHAR(32) NOT NULL,
	tel VARCHAR(32) NOT NULL
)
;
ALTER TABLE data ADD CONSTRAINT PK_data
	PRIMARY KEY (ID)
;

ALTER TABLE changable_content ADD CONSTRAINT FK_changable_content_page 
	FOREIGN KEY (page_id) REFERENCES page (id)
;

ALTER TABLE changable_content_h ADD CONSTRAINT FK_changable_content_h_changable_content 
	FOREIGN KEY (base_id) REFERENCES changable_content (id)
; 

CREATE SEQUENCE data_seq INCREMENT 1 START 1;
CREATE TABLE data
(
	ID INTEGER DEFAULT NEXTVAL('data_seq'::TEXT) NOT NULL,
	email VARCHAR(64) NOT NULL,
	address VARCHAR(128) NOT NULL,
	phone VARCHAR(32) NOT NULL,
	tel VARCHAR(32) NOT NULL
)
;
ALTER TABLE data ADD CONSTRAINT PK_data
	PRIMARY KEY (ID)
;
Insert into data (email,address,phone,tel) values 
('kkbalatoni@gmail.com', '1105, Budapest Mongol utca 5 1/1','06-20-967-4857','06-1-262-5519');

insert into admin (name,username,password) values ('Kecsó','kecso',md5('teszt'));
insert into page (name) values ('introduction');
insert into page (name) values ('references');
insert into page (name) values ('contact');
insert into page (name) values ('common');
insert into page (name) values ('partners');

insert into php_replications (name,web_url,db_path) values 
('demo','http://www.balahazak.hu/phps/demo','/mnt/c0d1/db_firebird/Demo.gdb');
insert into php_replications (name,web_url,db_path) values 
('keknyelu','http://www.balahazak.hu/phps/keknyelu','/mnt/c0d1/db_firebird/Keknyelu.gdb');
insert into php_replications (name,web_url,db_path) values 
('tarogato','http://www.balahazak.hu/phps/tarogato','/mnt/c0d1/db_firebird/Tarogato.gdb');
insert into php_replications (name,web_url,db_path) values 
('gitar2010','http://www.balahazak.hu/phps/gitar','/mnt/c0d1/db_firebird/Gitar2010.gdb');
insert into php_replications (name,web_url,db_path) values 
('bolgar','http://www.balahazak.hu/phps/bolgar','/mnt/c0d1/db_firebird/Bolgar.gdb');
insert into php_replications (name,web_url,db_path) values 
('bolgar','http://www.balahazak.hu/phps/mongol','/mnt/c0d1/db_firebird/Mongol2010.gdb');
insert into php_replications (name,web_url,db_path) values 
('bebek','http://www.balahazak.hu/phps/bebek','/mnt/c0d1/db_firebird/Bebek.gdb');
insert into php_replications (name,web_url,db_path) values 
('kaffka50','http://www.balahazak.hu/phps/kaffka','/mnt/c0d1/db_firebird/Kaffka50.gdb'),
('keknyelu5','http://www.balahazak.hu/phps/keknyelu5','/mnt/c0d1/db_firebird/keknyelu5.gdb'),
('zoltan72','http://www.balahazak.hu/phps/zoltan','/mnt/c0d1/db_firebird/Zoltan72.gdb');
insert into php_replications (name,web_url,db_path) values 
('kisgergely2','http://www.balahazak.hu/phps/kisgergely2','/mnt/c0d1/db_firebird/kisgergely2.gdb');
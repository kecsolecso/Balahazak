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
CREATE DATABASE IF NOT EXISTS Balahazak;
USE Balahazak;

DROP TABLE if EXISTS changable_content_h;
DROP TABLE if EXISTS changable_content;
DROP TABLE if EXISTS page;
DROP TABLE if EXISTS admin;
DROP TABLE if EXISTS php_replications;

CREATE TABLE changable_content
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	page_id INTEGER NOT NULL,
	content TEXT NOT NULL,
	last_modify TIMESTAMP NOT NULL,
	PRIMARY KEY (id),
	KEY (page_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


CREATE TABLE changable_content_h
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	base_id INTEGER NOT NULL,
	page_id INTEGER NOT NULL,
	content TEXT NOT NULL,
	last_modify TIMESTAMP NOT NULL,
	PRIMARY KEY (id),
	KEY (base_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


CREATE TABLE page
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


CREATE TABLE admin
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	username VARCHAR(128) NOT NULL,
	password VARCHAR(256) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE php_replications
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	web_url VARCHAR(256) NOT NULL,
	db_path VARCHAR(256) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE changable_content ADD CONSTRAINT FK_changable_content_page 
	FOREIGN KEY (page_id) REFERENCES page (id)
;

ALTER TABLE changable_content_h ADD CONSTRAINT FK_changable_content_h_changable_content 
	FOREIGN KEY (base_id) REFERENCES changable_content (id)
; 
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
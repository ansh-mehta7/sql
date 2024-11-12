USE org ;
CREATE TABLE account(
id INT NOT NULL PRIMARY KEY,
name VARCHAR (255) UNIQUE,
balance INT NOT NULL DEFAULT 1000
);


INSERT INTO account (id,name,balance) VALUES
(11,'aashi jian');
INSERT INTO account (id,name,balance) VALUES
(1,'sakshi sharma',123);
SELECT * FROM account;
DROP TABLE account;


SELECT * FROM account;
-- add new col 
ALTER TABLE account ADD intrest FLOAT NOT NULL DEFAULT 0;

-- modify 
ALTER TABLE account MODIFY intrest INT NOT NULL DEFAULT 2;

-- rename the coloumn 
ALTER TABLE account CHANGE COLUMN intrest saving_intrest INT NOT NULL DEFAULT 10;

-- DROP COLOUMN 
ALTER TABLE account DROP COLUMN saving_intrest;

-- rename 
ALTER TABLE account RENAME TO account_details;

DESC account;

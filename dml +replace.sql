USE org;
SELECT * FROM account_details;
INSERT INTO account_details VALUES(3,'mitali sharma',10000);

-- update 
UPDATE account_details SET id=4, name='Ansh mehta',balance=2000 WHERE name='mitali sharma';

SET sql_safe_updates=0;
UPDATE account_details SET balance=100000;

-- 
DELETE FROM account_details where name='Ansh mehta';
-- on delete cascade and on delete null

 SELECT * FROM worker;
 SELECT * FROM bonus;
 
 -- replace command 
 REPLACE INTO account_details (id) VALUES (7);
 -- alraay present data will be replaced 
 REPLACE INTO account_details (id) VALUES (11);
 
 -- this is a good syntax
 REPLACE INTO account_details SET id=1 ,name='Ansh mehta',balance=100000;
 
 -- replace vs update 
 -- if row is not present replace will add a new row by update whule update will do nothing 
 

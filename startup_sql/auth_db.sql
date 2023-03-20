USE users;
CREATE table employees (id int not null, email text, passwrd text, primary key(id));

INSERT into employees (id, email, passwrd) VALUES (1, 'samnzay@gmail.com', 'mysecret');

commit;

SELECT * FROM employees;
commit;
DROP USER auth_user;
DROP DATABASE auth;
CREATE USER 'auth_user'@'127.0.0.1:3037' IDENTIFIED BY 'secret';


CREATE DATABASE auth;

GRANT ALL PRIVILEGIES ON auth.* TO 'auth_user'@'127.0.0.1:3037';

USE auth;

CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwrd VARCHAR(255) NOT NULL
);

INSERT INTO user (email, passwrd) VALUES ('samnzay@gmail.com','secret');
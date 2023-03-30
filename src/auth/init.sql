CREATE USER 'auth_user'@'localhost' IDENTIFIED BY 'secret';

CREATE DATABASE auth;

GRANT ALL PRIVILEGES ON auth.* TO 'samuel_user'@'localhost';
FLUSH PRIVILEGES;

USE auth;

CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);

INSERT INTO user (email, password) VALUES ('samnzay@gmail.com', 'Admin123');

  





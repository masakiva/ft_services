CREATE USER 'default_user'@'localhost';
CREATE DATABASE default_db;
GRANT ALL PRIVILEGES ON default_db.* TO 'default_user'@'localhost' identified by 'password';
FLUSH PRIVILEGES;

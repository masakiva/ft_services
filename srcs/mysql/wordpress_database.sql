CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_pswd';
CREATE DATABASE wp_db;
GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;

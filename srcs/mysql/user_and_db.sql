CREATE USER IF NOT EXISTS 'maria-user'@'%' IDENTIFIED BY 'maria-pass';
CREATE DATABASE IF NOT EXISTS wp_db;
GRANT ALL PRIVILEGES ON wp_db.* TO 'maria-user'@'%';
FLUSH PRIVILEGES;

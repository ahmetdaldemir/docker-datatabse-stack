-- MySQL Initialization Script
-- Bu script dev_user'a tam yetki verir

-- dev_user'a tüm database'lerde tam yetki ver
GRANT ALL PRIVILEGES ON *.* TO 'dev_user'@'%' WITH GRANT OPTION;

-- dev_user'a CREATE, DROP, ALTER izinleri
GRANT CREATE, DROP, ALTER, INDEX, LOCK TABLES, REFERENCES, CREATE TEMPORARY TABLES, 
      CREATE VIEW, EVENT, TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, 
      EXECUTE ON *.* TO 'dev_user'@'%';

-- Privilege'ları yenile
FLUSH PRIVILEGES;

-- Test database'i oluştur (opsiyonel)
CREATE DATABASE IF NOT EXISTS test_db;
GRANT ALL PRIVILEGES ON test_db.* TO 'dev_user'@'%';

-- Privilege'ları tekrar yenile
FLUSH PRIVILEGES;

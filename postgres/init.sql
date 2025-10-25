-- PostgreSQL Initialization Script
-- Bu script dev_user'a tam yetki verir

-- dev_user'ı superuser yap (tüm database'leri oluşturabilir)
ALTER USER dev_user WITH SUPERUSER CREATEDB CREATEROLE;

-- dev_user'a tüm database'lerde tam yetki ver
GRANT ALL PRIVILEGES ON DATABASE dev_db TO dev_user;

-- Public schema'da tüm yetkiler
GRANT ALL ON SCHEMA public TO dev_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dev_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO dev_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO dev_user;

-- Gelecekte oluşturulacak tablolar için de yetki ver
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO dev_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO dev_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO dev_user;

-- Test database'i oluştur (opsiyonel)
CREATE DATABASE test_db OWNER dev_user;

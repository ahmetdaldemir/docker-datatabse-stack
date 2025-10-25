# 🗄️ Database Stack

Tüm projeler için merkezi database servisleri.

## 📦 İçerik

| Service | Port | GUI | GUI Port |
|---------|------|-----|----------|
| **MySQL 8.0** | 3306 | phpMyAdmin | 8081 |
| **PostgreSQL 16** | 5432 | Adminer | 8084 |
| **Redis** | 6379 | Redis Commander | 8082 |
| **MongoDB 7** | 27017 | Mongo Express | 8083 |
| **Elasticsearch 8** | 9200, 9300 | - | - |

---

## 🚀 Başlatma

### Development Ortamı

```bash
# Environment dosyasını oluştur
cp env.example .env

# Başlat
docker-compose up -d

# Veya deployment script ile
./deploy.sh
```

### Production Ortamı

```bash
# Production environment dosyasını oluştur
cp env.prod.example .env

# Güçlü şifrelerle .env dosyasını düzenle
nano .env

# Production modunda başlat
export ENVIRONMENT=production
./deploy.sh
```

### Temel Komutlar

```bash
# Durdur
docker-compose down

# Logları izle
docker-compose logs -f

# Servislerin durumu
docker-compose ps

# Restart
docker-compose restart
```

---

## 🔐 Bağlantı Bilgileri

### MySQL
```
Host: localhost
Port: 3306
Database: dev_db (ve istediğiniz herhangi bir database)
User: dev_user
Password: dev_pass
Root Password: root
```

**Özellikler:**
- ✅ `dev_user` tüm database'leri oluşturabilir
- ✅ `dev_user` tüm database'leri silebilir
- ✅ `dev_user` tüm tabloları yönetebilir

**Laravel .env:**
```env
DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=dev_db
DB_USERNAME=dev_user
DB_PASSWORD=dev_pass
```

---

### PostgreSQL
```
Host: localhost
Port: 5432
Database: dev_db (ve istediğiniz herhangi bir database)
User: dev_user
Password: dev_pass
```

**Özellikler:**
- ✅ `dev_user` superuser yetkilerine sahip
- ✅ `dev_user` tüm database'leri oluşturabilir
- ✅ `dev_user` tüm database'leri silebilir
- ✅ `dev_user` tüm tabloları yönetebilir

**Laravel .env:**
```env
DB_CONNECTION=pgsql
DB_HOST=localhost
DB_PORT=5432
DB_DATABASE=dev_db
DB_USERNAME=dev_user
DB_PASSWORD=dev_pass
```

---

### Redis
```
Host: localhost
Port: 6379
Password: dev_pass
```

**Laravel .env:**
```env
REDIS_HOST=localhost
REDIS_PASSWORD=dev_pass
REDIS_PORT=6379
```

---

### MongoDB
```
Host: localhost
Port: 27017
Database: dev_db (ve istediğiniz herhangi bir database)
Admin User: admin
Admin Password: admin_pass
Dev User: dev_user
Dev Password: dev_pass
```

**Özellikler:**
- ✅ `admin` kullanıcısı tüm database'leri yönetebilir
- ✅ `dev_user` kendi database'lerini yönetebilir
- ✅ Her iki kullanıcı da yeni database'ler oluşturabilir

**Connection Strings:**
```
# Admin kullanıcısı (tam yetki)
mongodb://admin:admin_pass@localhost:27017/dev_db?authSource=admin

# Dev kullanıcısı (sınırlı yetki)
mongodb://dev_user:dev_pass@localhost:27017/dev_db?authSource=dev_db
```

---

### Elasticsearch
```
Host: localhost
Port: 9200 (HTTP), 9300 (Transport)
```

**URL:**
```
http://localhost:9200
```

---

## 🖥️ Web Arayüzleri

| Servis | URL | Açıklama | Giriş Bilgileri |
|--------|-----|----------|-----------------|
| **phpMyAdmin** | http://localhost:8081 | MySQL yönetimi | dev_user / dev_pass |
| **Redis Commander** | http://localhost:8082 | Redis yönetimi | Password: dev_pass |
| **Mongo Express** | http://localhost:8083 | MongoDB yönetimi | admin / admin_pass |
| **Adminer** | http://localhost:8084 | Tüm DB'ler için | dev_user / dev_pass |

### 🔑 Database Manager Giriş Bilgileri

**phpMyAdmin (MySQL):**
- Server: mysql
- Username: dev_user
- Password: dev_pass

**Adminer (Universal):**
- System: MySQL
- Server: mysql
- Username: dev_user
- Password: dev_pass
- Database: dev_db

**Redis Commander:**
- Host: redis
- Port: 6379
- Password: dev_pass

**Mongo Express:**
- Username: admin
- Password: admin_pass

---

## 📊 Kullanım

### Yeni Database Oluşturma

**MySQL (dev_user ile):**
```bash
# dev_user ile yeni database oluştur
docker-compose exec mysql mysql -u dev_user -pdev_pass -e "CREATE DATABASE yeni_db;"

# Database'i sil
docker-compose exec mysql mysql -u dev_user -pdev_pass -e "DROP DATABASE yeni_db;"
```

**PostgreSQL (dev_user ile):**
```bash
# dev_user ile yeni database oluştur
docker-compose exec postgres createdb -U dev_user yeni_db

# Database'i sil
docker-compose exec postgres dropdb -U dev_user yeni_db
```

**MongoDB (admin ile):**
```bash
# admin ile yeni database oluştur
docker-compose exec mongodb mongosh -u admin -p admin_pass --authenticationDatabase admin --eval "use yeni_db; db.test_collection.insertOne({test: 'data'});"

# Database'i sil
docker-compose exec mongodb mongosh -u admin -p admin_pass --authenticationDatabase admin --eval "use yeni_db; db.dropDatabase();"
```

### 🎯 Database Manager'lar ile Oluşturma

**phpMyAdmin ile:**
1. http://localhost:8081 adresine git
2. dev_user / dev_pass ile giriş yap
3. "Databases" sekmesine tıkla
4. "Create database" butonuna tıkla
5. Database adını gir ve "Create" butonuna tıkla

**Adminer ile:**
1. http://localhost:8084 adresine git
2. MySQL seç, dev_user / dev_pass ile giriş yap
3. "Create database" linkine tıkla
4. Database adını gir ve oluştur

**Mongo Express ile:**
1. http://localhost:8083 adresine git
2. admin / admin_pass ile giriş yap
3. "Create Database" butonuna tıkla
4. Database adını gir ve oluştur

---

### Backup

**MySQL:**
```bash
docker-compose exec mysql mysqldump -u root -proot dreampos > backup.sql
```

**PostgreSQL:**
```bash
docker-compose exec postgres pg_dump -U dreampos_user dreampos > backup.sql
```

**MongoDB:**
```bash
docker-compose exec mongodb mongodump -u admin -p admin_pass --db dreampos --out /backup
```

---

### Restore

**MySQL:**
```bash
docker-compose exec -T mysql mysql -u root -proot dreampos < backup.sql
```

**PostgreSQL:**
```bash
docker-compose exec -T postgres psql -U dreampos_user dreampos < backup.sql
```

---

## 🔧 Özelleştirme

### MySQL Config
`mysql/my.cnf` dosyasını düzenle ve restart et:
```bash
docker-compose restart mysql
```

### Memory Ayarları

**Elasticsearch** için `docker-compose.yml`:
```yaml
environment:
  - "ES_JAVA_OPTS=-Xms1g -Xmx1g"  # 1GB RAM
```

---

## 🧹 Temizlik

### Container'ları Durdur ve Sil
```bash
docker-compose down
```

### Volume'ları da Sil (VERİ SİLİNİR!)
```bash
docker-compose down -v
```

### Sadece Belirli Volume'u Sil
```bash
docker volume rm docker-databases_mysql_data
```

---

## 🌐 Network

Tüm servisler `databases_network` üzerinde çalışır. Diğer projelerden bağlanmak için:

```yaml
networks:
  - databases_network

networks:
  databases_network:
    external: true
```

---

## 💡 İpuçları

1. **Her proje aynı database kullanabilir** - sadece farklı database isimleri kullan
2. **phpMyAdmin üzerinden** birden fazla DB yönetebilirsin
3. **Adminer** MySQL, PostgreSQL, MongoDB için evrensel arayüz
4. **Redis Commander** cache'i görselleştir
5. **Production'da** port'ları kapalı tut, sadece internal network kullan

---

## 🔒 Güvenlik Notları

- Production'da güçlü şifreler kullan
- Port'ları sadece gerekirse aç
- Volume backup'larını düzenli al
- `.env` dosyasında hassas bilgileri sakla


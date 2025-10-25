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
Database: dev_db
User: dev_user
Password: dev_pass
Root Password: root
```

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
Database: dev_db
User: dev_user
Password: dev_pass
```

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
Database: dev_db
Admin User: admin
Admin Password: admin_pass
```

**Connection String:**
```
mongodb://admin:admin_pass@localhost:27017/dev_db?authSource=admin
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

| Servis | URL | Açıklama |
|--------|-----|----------|
| **phpMyAdmin** | http://localhost:8081 | MySQL yönetimi |
| **Redis Commander** | http://localhost:8082 | Redis yönetimi |
| **Mongo Express** | http://localhost:8083 | MongoDB yönetimi |
| **Adminer** | http://localhost:8084 | Tüm DB'ler için |

---

## 📊 Kullanım

### Yeni Database Oluşturma

**MySQL:**
```bash
docker-compose exec mysql mysql -u root -proot -e "CREATE DATABASE yeni_db;"
```

**PostgreSQL:**
```bash
docker-compose exec postgres createdb -U dreampos_user yeni_db
```

**MongoDB:**
```bash
docker-compose exec mongodb mongosh -u admin -p admin_pass --eval "use yeni_db"
```

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


# 🚀 Hızlı Başlangıç

## 1️⃣ Database Stack'i Başlat

```bash
cd docker-databases
docker-compose up -d
```

**Veya:**
```bash
cd docker-databases
chmod +x start.sh
./start.sh
```

## 2️⃣ Proje Container'larını Başlat

```bash
cd ..  # Ana dizine dön
docker-compose -f docker-compose.dev.yml up -d
```

## 3️⃣ Migration Çalıştır

```bash
docker-compose -f docker-compose.dev.yml exec app php artisan migrate
```

---

## ✅ Hazır!

- **Web:** http://localhost:8080
- **Redis Commander:** http://localhost:8082
- **Mongo Express:** http://localhost:8083
- **Adminer:** http://localhost:8084

---

## 🛑 Durdurma

**Database Stack:**
```bash
cd docker-databases
docker-compose down
```

**Proje:**
```bash
docker-compose -f docker-compose.dev.yml down
```

---

## 📝 Önemli Notlar

1. **Önce database stack'i başlat**, sonra proje container'larını
2. Database container'ları **tüm projeler** için paylaşılır
3. Her proje farklı database ismi kullanabilir
4. Network: `databases_network` (otomatik oluşturulur)

---

## 🔄 Sıralama

```bash
# 1. Database stack
cd docker-databases && docker-compose up -d && cd ..

# 2. Proje
docker-compose -f docker-compose.dev.yml up -d

# 3. Migration
docker-compose -f docker-compose.dev.yml exec app php artisan migrate
```

---

## 💾 Backup

```bash
# MySQL
cd docker-databases
docker-compose exec mysql mysqldump -u root -proot dreampos > ../backup.sql

# MongoDB
docker-compose exec mongodb mongodump -u admin -p admin_pass --db dreampos --out /tmp/backup
docker cp db_mongodb:/tmp/backup ./backup-mongo
```


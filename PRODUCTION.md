# 🚀 Production Deployment Guide

Bu rehber, Global Database Stack'i production ortamında güvenli bir şekilde deploy etmek için gerekli adımları içerir.

## 📋 Ön Gereksinimler

- Docker ve Docker Compose yüklü
- Sunucu erişimi (SSH)
- Güçlü şifreler hazır
- Firewall konfigürasyonu

## 🔧 Production Konfigürasyonu

### 1️⃣ Environment Dosyası Oluştur

```bash
# Production environment dosyasını kopyala
cp env.prod.example .env

# Güçlü şifrelerle düzenle
nano .env
```

### 2️⃣ Güvenlik Ayarları

**ÖNEMLİ:** Production'da mutlaka güçlü şifreler kullanın:

```bash
# Güçlü şifre örnekleri (kendi şifrelerinizi oluşturun)
MYSQL_ROOT_PASSWORD=YourVeryStrongRootPassword123!
MYSQL_PASSWORD=YourStrongUserPassword456!
POSTGRES_PASSWORD=YourStrongPostgresPassword789!
REDIS_PASSWORD=YourStrongRedisPassword012!
MONGO_ROOT_PASSWORD=YourStrongMongoPassword345!
```

### 3️⃣ Port Konfigürasyonu

Production'da varsayılan portları değiştirin:

```bash
# Güvenlik için farklı portlar kullanın
MYSQL_PORT=13306
POSTGRES_PORT=15432
REDIS_PORT=16379
MONGO_PORT=127017
ELASTICSEARCH_HTTP_PORT=19200
```

## 🚀 Deployment

### Development Ortamı

```bash
# Development için
cp env.example .env
# .env dosyasını düzenle
./deploy.sh
```

### Production Ortamı

```bash
# Production için
cp env.prod.example .env
# Güçlü şifrelerle .env dosyasını düzenle
export ENVIRONMENT=production
./deploy.sh
```

## 🔒 Production Güvenlik Özellikleri

### ✅ **Otomatik Güvenlik Ayarları**

- **GUI Servisleri Devre Dışı**: Production'da GUI servisleri varsayılan olarak kapalı
- **Resource Limits**: Memory ve CPU limitleri
- **Enhanced Logging**: Detaylı log kayıtları
- **Health Checks**: Otomatik sağlık kontrolleri

### ✅ **Database Optimizasyonları**

- **MySQL**: Production-optimized InnoDB ayarları
- **PostgreSQL**: Memory ve connection optimizasyonları
- **Redis**: Memory management ve persistence
- **MongoDB**: Authentication ve logging
- **Elasticsearch**: Security ve performance ayarları

## 🌐 Network Konfigürasyonu

### Internal Network

Tüm servisler `global_databases_network` üzerinde çalışır:

```yaml
# Diğer projelerden bağlanmak için
networks:
  - global_databases_network

networks:
  global_databases_network:
    external: true
```

### External Access

Production'da sadece gerekli portları açın:

```bash
# Firewall ayarları (Ubuntu/Debian)
ufw allow 13306/tcp  # MySQL
ufw allow 15432/tcp  # PostgreSQL
ufw allow 16379/tcp  # Redis
ufw allow 127017/tcp # MongoDB
ufw allow 19200/tcp  # Elasticsearch
```

## 📊 Monitoring ve Maintenance

### Health Checks

```bash
# Tüm servislerin durumunu kontrol et
docker-compose ps

# Sağlık durumunu kontrol et
docker-compose exec mysql mysqladmin ping -h localhost
docker-compose exec postgres pg_isready
docker-compose exec redis redis-cli ping
docker-compose exec mongodb mongosh --eval "db.adminCommand('ping')"
docker-compose exec elasticsearch curl -f http://localhost:9200/_cluster/health
```

### Log Monitoring

```bash
# Tüm servislerin loglarını izle
docker-compose logs -f

# Belirli bir servisin loglarını izle
docker-compose logs -f mysql
docker-compose logs -f postgres
docker-compose logs -f redis
```

### Backup

```bash
# MySQL Backup
docker-compose exec mysql mysqldump -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} > backup_mysql_$(date +%Y%m%d_%H%M%S).sql

# PostgreSQL Backup
docker-compose exec postgres pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} > backup_postgres_$(date +%Y%m%d_%H%M%S).sql

# MongoDB Backup
docker-compose exec mongodb mongodump -u ${MONGO_ROOT_USERNAME} -p${MONGO_ROOT_PASSWORD} --db ${MONGO_DATABASE} --out /backup
```

## 🔧 Troubleshooting

### Port Çakışması

```bash
# Kullanılan portları kontrol et
netstat -tulpn | grep :3306
netstat -tulpn | grep :5432

# Çakışan servisleri durdur
sudo systemctl stop mysql
sudo systemctl stop postgresql
```

### Memory Issues

```bash
# Memory kullanımını kontrol et
docker stats

# Resource limitlerini artır
# .env dosyasında ES_JAVA_OPTS değerini güncelle
ES_JAVA_OPTS=-Xms2g -Xmx2g
```

### Network Issues

```bash
# Network'ü yeniden oluştur
docker-compose down
docker network prune
docker-compose up -d
```

## 📈 Performance Tuning

### MySQL Optimizasyonu

```bash
# MySQL config dosyasını düzenle
nano mysql/my.cnf

# Production ayarları
innodb_buffer_pool_size = 1G
max_connections = 500
query_cache_size = 128M
```

### PostgreSQL Optimizasyonu

```bash
# PostgreSQL ayarları
shared_buffers = 256MB
effective_cache_size = 1GB
maintenance_work_mem = 64MB
```

### Redis Optimizasyonu

```bash
# Redis memory ayarları
maxmemory 512mb
maxmemory-policy allkeys-lru
```

## 🚨 Security Checklist

- [ ] Güçlü şifreler kullanıldı
- [ ] Varsayılan portlar değiştirildi
- [ ] Firewall kuralları yapılandırıldı
- [ ] SSL/TLS sertifikaları hazırlandı
- [ ] Backup stratejisi belirlendi
- [ ] Monitoring sistemi kuruldu
- [ ] Log rotation yapılandırıldı
- [ ] Resource limitleri ayarlandı

## 📞 Support

Sorun yaşarsanız:

1. **Logları kontrol edin**: `docker-compose logs -f`
2. **Health check'leri çalıştırın**: `docker-compose ps`
3. **Resource kullanımını kontrol edin**: `docker stats`
4. **Network bağlantılarını test edin**: `docker network ls`

---

**Not**: Production deployment öncesi mutlaka test ortamında deneyin!

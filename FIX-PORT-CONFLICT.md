# Port Çakışması Çözümü

## Problem
PostgreSQL container'ı başlatılamıyor çünkü 5432 portu zaten kullanımda.

Hata mesajı:
```
failed to bind host port for 0.0.0.0:5432: address already in use
```

## Çözüm Yöntemleri

### Yöntem 1: Port Kullanan Servisi Bul ve Durdur (Önerilen)

Sunucuda şu komutları çalıştırın:

```bash
# 5432 portunu kullanan servisi bul
sudo netstat -tulpn | grep :5432
# veya
sudo ss -tulpn | grep :5432
# veya
sudo lsof -i :5432

# Eğer başka bir PostgreSQL container varsa:
docker ps -a | grep postgres
docker stop <container_id>  # Eğer gerekirse
docker rm <container_id>     # Eğer gerekirse

# Eğer sistem PostgreSQL servisi varsa:
sudo systemctl status postgresql
sudo systemctl stop postgresql
sudo systemctl disable postgresql  # Otomatik başlamayı engelle
```

### Yöntem 2: Farklı Port Kullan (Hızlı Çözüm)

Eğer başka bir servis PostgreSQL kullanıyorsa, docker-compose.yml'de farklı bir port kullanın:

**`.env` dosyasını düzenleyin:**
```bash
cd /var/www/html/saastour360/docker-datatabse-stack
nano .env
```

```env
# PostgreSQL için farklı bir port kullan
POSTGRES_PORT=5433  # veya başka boş bir port
```

**docker-compose.yml'de port mapping güncelle:**
```yaml
postgres:
  ports:
    - "${POSTGRES_PORT:-5433}:5432"  # 5433 yerel, 5432 container içi
```

### Yöntem 3: Mevcut PostgreSQL Container'ı Kullan

Eğer zaten çalışan bir PostgreSQL container varsa, docker-compose.yml'de external PostgreSQL kullanın:

```yaml
# docker-compose.yml'den postgres servisini kaldır
# Veya external olarak tanımla:
networks:
  global_databases_net:
    external: true
    name: <mevcut_network_adı>
```

## Hızlı Kontrol Komutları

```bash
# Tüm PostgreSQL container'larını listele
docker ps -a | grep postgres

# Port kullanımını kontrol et
sudo netstat -tulpn | grep 5432

# Sistem PostgreSQL servisini kontrol et
sudo systemctl status postgresql

# Çalışan tüm container'ları listele
docker ps
```

## Önerilen Çözüm

1. **Port'u kullanan servisi bul:**
   ```bash
   sudo ss -tulpn | grep :5432
   ```

2. **Eğer sistem PostgreSQL ise durdur:**
   ```bash
   sudo systemctl stop postgresql
   sudo systemctl disable postgresql
   ```

3. **Docker-compose'u yeniden başlat:**
   ```bash
   cd /var/www/html/saastour360/docker-datatabse-stack
   docker-compose down
   docker-compose up -d
   ```

4. **Kontrol et:**
   ```bash
   docker-compose ps
   docker-compose logs postgres
   ```


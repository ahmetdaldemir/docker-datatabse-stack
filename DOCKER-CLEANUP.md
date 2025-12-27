# Docker Temizlik Rehberi

## ⚠️ UYARI

Bu işlemler Docker kaynaklarını silebilir. Önemli veriler kaybolabilir!

## Temizlik Seçenekleri

### 1. Tüm Container'ları ve Image'ları Sil (Kapsamlı)

```bash
cd /var/www/html/saastour360/docker-datatabse-stack
./docker-cleanup-all.sh
```

**Bu script:**
- ✅ Tüm container'ları durdurur ve siler
- ✅ Tüm image'ları siler
- ⚠️  Volume'ları silmek için onay ister (veri kaybı olabilir)
- ✅ Kullanılmayan network'leri temizler
- ⚠️  Build cache'i temizlemek için onay ister

### 2. Sadece Container'ları Sil (Image'lar Korunur)

```bash
cd /var/www/html/saastour360/docker-datatabse-stack
./docker-cleanup-containers-only.sh
```

**Bu script:**
- ✅ Tüm container'ları durdurur ve siler
- ❌ Image'ları korur (hızlı rebuild için)

### 3. Hızlı Temizlik (Onay İstemez)

```bash
cd /var/www/html/saastour360/docker-datatabse-stack
./docker-cleanup-simple.sh
```

**Bu script:**
- ✅ Tüm container'ları durdurur ve siler
- ✅ Tüm image'ları siler
- ✅ `docker system prune -f` çalıştırır
- ⚠️  Onay istemez, dikkatli kullanın!

## Manuel Komutlar

### Tüm Container'ları Durdur ve Sil

```bash
# Çalışan container'ları durdur
docker stop $(docker ps -aq)

# Tüm container'ları sil
docker rm $(docker ps -aq)
```

### Tüm Image'ları Sil

```bash
# Tüm image'ları sil
docker rmi $(docker images -q)

# Veya zorla sil (bağlı container'lar olsa bile)
docker rmi -f $(docker images -q)
```

### Tümünü Tek Seferde Temizle

```bash
# Tüm container'ları durdur ve sil
docker stop $(docker ps -aq) && docker rm $(docker ps -aq)

# Tüm image'ları sil
docker rmi -f $(docker images -q)

# Kullanılmayan kaynakları temizle
docker system prune -af

# Volume'ları da silmek isterseniz (VERİ KAYBI!)
docker volume prune -af
```

### Sadece Belirli Container'ları Sil

```bash
# Container ismine göre
docker stop global_postgres global_mysql
docker rm global_postgres global_mysql

# Image ismine göre
docker rmi postgres:16-alpine mysql:8.0
```

## Önemli Notlar

1. **Volume'lar**: Volume'ları silmek veri kaybına neden olur! Database verileri kaybolur.
2. **Build Cache**: Build cache'i temizlemek rebuild süresini uzatır ama disk alanı kazandırır.
3. **Network'ler**: Kullanılmayan network'ler otomatik temizlenir.

## Temizlik Sonrası

Temizlik sonrası projeleri yeniden başlatmak için:

```bash
# Database stack'i başlat
cd /var/www/html/saastour360/docker-datatabse-stack
docker-compose up -d

# Proje container'larını başlat
cd /var/www/html/saastour360/infra
docker-compose -f docker-compose.prod.yml up -d --build
```

## Disk Alanı Kontrolü

Temizlik öncesi ve sonrası disk kullanımını kontrol edin:

```bash
# Docker disk kullanımı
docker system df

# Detaylı bilgi
docker system df -v
```


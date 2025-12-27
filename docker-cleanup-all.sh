#!/bin/bash

# ⚠️  UYARI: Bu script TÜM Docker container'larını, image'larını, volume'larını ve network'lerini siler!
# Veri kaybı olabilir, dikkatli kullanın!

set -e

echo "⚠️  UYARI: Bu işlem TÜM Docker kaynaklarını silecek!"
echo "=================================================="
echo ""
echo "📊 Mevcut Durum:"
echo "   Container'lar: $(docker ps -a -q | wc -l)"
echo "   Image'lar: $(docker images -q | wc -l)"
echo "   Volume'lar: $(docker volume ls -q | wc -l)"
echo "   Network'ler: $(docker network ls -q | wc -l)"
echo ""

read -p "❓ Devam etmek istiyor musunuz? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "❌ İşlem iptal edildi."
    exit 0
fi

echo ""
echo "🧹 Temizlik başlatılıyor..."
echo ""

# 1. Tüm çalışan container'ları durdur
echo "1️⃣  Çalışan container'lar durduruluyor..."
docker stop $(docker ps -aq) 2>/dev/null || echo "   Durduracak container yok"

# 2. Tüm container'ları sil
echo "2️⃣  Tüm container'lar siliniyor..."
docker rm $(docker ps -aq) 2>/dev/null || echo "   Silinecek container yok"

# 3. Tüm image'ları sil
echo "3️⃣  Tüm image'lar siliniyor..."
docker rmi $(docker images -q) 2>/dev/null || echo "   Silinecek image yok"

# 4. Kullanılmayan volume'ları sil (opsiyonel - veri kaybı olabilir)
read -p "📦 Kullanılmayan volume'ları da silmek istiyor musunuz? (yes/no): " remove_volumes
if [ "$remove_volumes" = "yes" ]; then
    echo "4️⃣  Kullanılmayan volume'lar siliniyor..."
    docker volume prune -f
else
    echo "4️⃣  Volume'lar korunuyor (atlandı)"
fi

# 5. Kullanılmayan network'leri temizle
echo "5️⃣  Kullanılmayan network'ler temizleniyor..."
docker network prune -f

# 6. Build cache'i temizle (opsiyonel)
read -p "🗑️  Build cache'i de temizlemek istiyor musunuz? (yes/no): " remove_cache
if [ "$remove_cache" = "yes" ]; then
    echo "6️⃣  Build cache temizleniyor..."
    docker builder prune -af
else
    echo "6️⃣  Build cache korunuyor (atlandı)"
fi

echo ""
echo "✅ Temizlik tamamlandı!"
echo ""
echo "📊 Son Durum:"
echo "   Container'lar: $(docker ps -a -q | wc -l)"
echo "   Image'lar: $(docker images -q | wc -l)"
echo "   Volume'lar: $(docker volume ls -q | wc -l)"
echo "   Network'ler: $(docker network ls -q | wc -l)"
echo ""


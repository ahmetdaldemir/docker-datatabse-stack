#!/bin/bash

# Sadece container'ları durdurur ve siler (image'lar korunur)

set -e

echo "🧹 Docker Container Temizliği"
echo "=============================="
echo ""

echo "📊 Mevcut Container'lar:"
docker ps -a

echo ""
read -p "❓ Tüm container'ları durdurup silmek istiyor musunuz? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "❌ İşlem iptal edildi."
    exit 0
fi

echo ""
echo "🛑 Çalışan container'lar durduruluyor..."
docker stop $(docker ps -aq) 2>/dev/null || echo "   Durduracak container yok"

echo ""
echo "🗑️  Container'lar siliniyor..."
docker rm $(docker ps -aq) 2>/dev/null || echo "   Silinecek container yok"

echo ""
echo "✅ Container temizliği tamamlandı!"
echo ""
echo "📊 Kalan Container Sayısı: $(docker ps -a -q | wc -l)"
echo "📦 Image'lar korundu: $(docker images -q | wc -l) image mevcut"


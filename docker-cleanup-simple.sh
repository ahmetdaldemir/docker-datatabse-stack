#!/bin/bash

# Hızlı temizlik - Tüm container'ları ve image'ları sil (onay gerektirmez)

set -e

echo "🧹 Docker Hızlı Temizlik"
echo "========================"
echo ""

# Tüm container'ları durdur ve sil
echo "🛑 Container'lar durduruluyor ve siliniyor..."
docker stop $(docker ps -aq) 2>/dev/null || true
docker rm $(docker ps -aq) 2>/dev/null || true

# Tüm image'ları sil
echo "🗑️  Image'lar siliniyor..."
docker rmi $(docker images -q) 2>/dev/null || true

# Kullanılmayan kaynakları temizle
echo "🧽 Kullanılmayan kaynaklar temizleniyor..."
docker system prune -f

echo ""
echo "✅ Temizlik tamamlandı!"
echo ""


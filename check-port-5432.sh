#!/bin/bash

echo "🔍 5432 portunu kullanan servisleri kontrol ediliyor..."
echo "=================================================="
echo ""

# Port kullanımını kontrol et
echo "📊 Port 5432 kullanımı:"
if command -v ss &> /dev/null; then
    sudo ss -tulpn | grep :5432 || echo "Port 5432 kullanılmıyor (ss ile)"
elif command -v netstat &> /dev/null; then
    sudo netstat -tulpn | grep :5432 || echo "Port 5432 kullanılmıyor (netstat ile)"
elif command -v lsof &> /dev/null; then
    sudo lsof -i :5432 || echo "Port 5432 kullanılmıyor (lsof ile)"
else
    echo "⚠️  ss, netstat veya lsof bulunamadı"
fi

echo ""
echo "🐳 Çalışan PostgreSQL container'ları:"
docker ps | grep postgres || echo "Çalışan PostgreSQL container yok"

echo ""
echo "📦 Tüm PostgreSQL container'ları (durmuş dahil):"
docker ps -a | grep postgres || echo "PostgreSQL container yok"

echo ""
echo "🔧 Sistem PostgreSQL servisi:"
if systemctl is-active --quiet postgresql 2>/dev/null; then
    echo "⚠️  PostgreSQL servisi çalışıyor!"
    echo "   Durumu: $(systemctl status postgresql --no-pager | head -n 3)"
elif systemctl is-installed postgresql &>/dev/null; then
    echo "ℹ️  PostgreSQL servisi yüklü ama çalışmıyor"
else
    echo "✅ Sistem PostgreSQL servisi yok"
fi

echo ""
echo "💡 Çözüm önerileri:"
echo "1. Sistem PostgreSQL'i durdurmak için: sudo systemctl stop postgresql && sudo systemctl disable postgresql"
echo "2. Başka bir container'ı durdurmak için: docker stop <container_id>"
echo "3. Farklı port kullanmak için .env dosyasında POSTGRES_PORT=5433 yapın"


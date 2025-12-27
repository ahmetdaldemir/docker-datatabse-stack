#!/bin/bash

echo "🔧 PostgreSQL Port Çakışması Çözümü"
echo "===================================="
echo ""

cd "$(dirname "$0")"

# .env dosyası var mı kontrol et
if [ ! -f .env ]; then
    echo "📝 .env dosyası bulunamadı, env.example'dan oluşturuluyor..."
    cp env.example .env
fi

echo "📝 .env dosyası düzenleniyor..."
echo ""

# POSTGRES_PORT'u 5433 olarak ayarla (veya kullanıcıdan al)
NEW_PORT=${1:-5433}

# .env dosyasında POSTGRES_PORT satırını bul ve güncelle
if grep -q "^POSTGRES_PORT=" .env; then
    # Mevcut satırı güncelle
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS için
        sed -i '' "s/^POSTGRES_PORT=.*/POSTGRES_PORT=${NEW_PORT}/" .env
    else
        # Linux için
        sed -i "s/^POSTGRES_PORT=.*/POSTGRES_PORT=${NEW_PORT}/" .env
    fi
    echo "✅ POSTGRES_PORT=${NEW_PORT} olarak güncellendi"
else
    # Satır yoksa ekle
    echo "POSTGRES_PORT=${NEW_PORT}" >> .env
    echo "✅ POSTGRES_PORT=${NEW_PORT} eklendi"
fi

echo ""
echo "🔄 Docker compose yeniden başlatılıyor..."
docker-compose down
docker-compose up -d postgres

echo ""
echo "⏳ PostgreSQL'in başlaması bekleniyor (5 saniye)..."
sleep 5

echo ""
echo "📊 Container durumu:"
docker-compose ps postgres

echo ""
echo "✅ Tamamlandı!"
echo ""
echo "🌐 PostgreSQL erişim bilgileri:"
echo "   Host: localhost"
echo "   Port: ${NEW_PORT}"
echo "   Database: (env.example'daki POSTGRES_DB değeri)"
echo "   User: (env.example'daki POSTGRES_USER değeri)"
echo ""


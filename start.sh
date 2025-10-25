#!/bin/bash

echo "🗄️  Database Stack Başlatılıyor..."
echo "=================================="
echo ""

# Start databases
docker-compose up -d

echo ""
echo "⏳ Veritabanlarının hazır olması bekleniyor (10 saniye)..."
sleep 10

echo ""
echo "✅ Tüm servisler başlatıldı!"
echo ""
echo "📊 Servis Durumu:"
docker-compose ps

echo ""
echo "🌐 Web Arayüzleri:"
echo "   - phpMyAdmin (MySQL):     http://localhost:8081"
echo "   - Redis Commander:        http://localhost:8082"
echo "   - Mongo Express:          http://localhost:8083"
echo "   - Adminer (Tüm DB'ler):   http://localhost:8084"
echo ""
echo "📝 Bağlantı Bilgileri:"
echo "   MySQL:         localhost:3306"
echo "   PostgreSQL:    localhost:5432"
echo "   Redis:         localhost:6379"
echo "   MongoDB:       localhost:27017"
echo "   Elasticsearch: localhost:9200"
echo ""
echo "💡 Durdurmak için: docker-compose down"
echo ""


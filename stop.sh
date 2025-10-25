#!/bin/bash

echo "🛑 Database Stack Durduruluyor..."
echo "=================================="
echo ""

docker-compose down

echo ""
echo "✅ Tüm servisler durduruldu!"
echo ""
echo "💡 Tekrar başlatmak için: ./start.sh"
echo "🗑️  Verileri silmek için: docker-compose down -v"
echo ""


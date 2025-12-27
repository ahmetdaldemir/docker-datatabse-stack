#!/bin/bash

# Network kontrolü ve oluşturma script'i

NETWORK_NAME="global_databases_network"

echo "🔍 Checking Docker networks..."
echo ""

# Network'ün var olup olmadığını kontrol et
if docker network ls | grep -q "$NETWORK_NAME"; then
    echo "✅ Network '$NETWORK_NAME' mevcut"
    docker network inspect "$NETWORK_NAME" --format '{{.Name}}: {{.Driver}}'
else
    echo "❌ Network '$NETWORK_NAME' bulunamadı"
    echo ""
    read -p "📦 Network'ü oluşturmak istiyor musunuz? (yes/no): " create
    
    if [ "$create" = "yes" ]; then
        echo "🔨 Network oluşturuluyor..."
        docker network create "$NETWORK_NAME"
        
        if [ $? -eq 0 ]; then
            echo "✅ Network '$NETWORK_NAME' başarıyla oluşturuldu"
        else
            echo "❌ Network oluşturulamadı"
            exit 1
        fi
    else
        echo "⚠️  Network oluşturulmadı. Database stack'i önce başlatmanız gerekiyor:"
        echo "   cd docker-datatabse-stack"
        echo "   docker-compose up -d"
        exit 1
    fi
fi

echo ""
echo "📊 Tüm external network'ler:"
docker network ls --filter driver=bridge --format "{{.Name}}\t{{.Driver}}\t{{.Scope}}"


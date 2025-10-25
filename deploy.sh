#!/bin/bash

# Global Database Stack Deployment Script

echo "🚀 Global Database Stack Deployment"
echo "=================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "📝 Please copy env.example to .env and configure your settings:"
    echo "   cp env.example .env"
    echo "   # Edit .env with your configuration"
    exit 1
fi

# Load environment variables
source .env

echo "📋 Configuration:"
echo "   Environment: ${ENVIRONMENT:-development}"
echo "   Network: ${NETWORK_NAME:-global_databases_network}"
echo "   MySQL Port: ${MYSQL_PORT:-3306}"
echo "   PostgreSQL Port: ${POSTGRES_PORT:-5432}"
echo "   Redis Port: ${REDIS_PORT:-6379}"
echo "   MongoDB Port: ${MONGO_PORT:-27017}"
echo "   Elasticsearch Port: ${ELASTICSEARCH_HTTP_PORT:-9200}"
echo ""

# Check if running in production mode
if [ "${ENVIRONMENT:-development}" = "production" ]; then
    echo "🔒 Production Mode Detected"
    echo "   - GUI services will be disabled"
    echo "   - Enhanced security settings applied"
    echo "   - Resource limits enforced"
    echo ""
    
    # Deploy production stack
    echo "📦 Deploying Production Stack..."
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
    
    echo ""
    echo "✅ Production Stack Deployed!"
    echo ""
    echo "🔗 Database Connections:"
    echo "   MySQL:       localhost:${MYSQL_PORT:-3306}"
    echo "   PostgreSQL:  localhost:${POSTGRES_PORT:-5432}"
    echo "   Redis:       localhost:${REDIS_PORT:-6379}"
    echo "   MongoDB:     localhost:${MONGO_PORT:-27017}"
    echo "   Elasticsearch: localhost:${ELASTICSEARCH_HTTP_PORT:-9200}"
    echo ""
    echo "💡 To enable GUI services: docker-compose --profile gui up -d"
    
else
    echo "🛠️  Development Mode Detected"
    echo "   - All services including GUI will be enabled"
    echo "   - Development-friendly settings applied"
    echo ""
    
    # Deploy development stack
    echo "📦 Deploying Development Stack..."
    docker-compose up -d
    
    echo ""
    echo "✅ Development Stack Deployed!"
    echo ""
    echo "🌐 Web Interfaces:"
    echo "   phpMyAdmin:     http://localhost:${PHPMYADMIN_PORT:-8081}"
    echo "   Redis Commander: http://localhost:${REDIS_COMMANDER_PORT:-8082}"
    echo "   Mongo Express:  http://localhost:${MONGO_EXPRESS_PORT:-8083}"
    echo "   Adminer:        http://localhost:${ADMINER_PORT:-8084}"
    echo ""
    echo "🔗 Database Connections:"
    echo "   MySQL:       localhost:${MYSQL_PORT:-3306}"
    echo "   PostgreSQL:  localhost:${POSTGRES_PORT:-5432}"
    echo "   Redis:       localhost:${REDIS_PORT:-6379}"
    echo "   MongoDB:     localhost:${MONGO_PORT:-27017}"
    echo "   Elasticsearch: localhost:${ELASTICSEARCH_HTTP_PORT:-9200}"
fi

echo ""
echo "📊 Service Status:"
docker-compose ps

echo ""
echo "💡 Management Commands:"
echo "   Stop:     docker-compose down"
echo "   Logs:     docker-compose logs -f"
echo "   Restart:  docker-compose restart"
echo "   Status:   docker-compose ps"
echo ""

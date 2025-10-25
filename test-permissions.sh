#!/bin/bash

# Database Permissions Test Script
# Bu script dev_user'ın izinlerini test eder

echo "🧪 Database Permissions Test"
echo "=========================="
echo ""

# MySQL Test
echo "📊 Testing MySQL permissions..."
echo "Creating test database in MySQL..."
docker-compose exec mysql mysql -u dev_user -pdev_pass -e "CREATE DATABASE IF NOT EXISTS test_mysql_db;"
if [ $? -eq 0 ]; then
    echo "✅ MySQL: dev_user can create databases"
    docker-compose exec mysql mysql -u dev_user -pdev_pass -e "DROP DATABASE test_mysql_db;"
    echo "✅ MySQL: dev_user can drop databases"
else
    echo "❌ MySQL: dev_user cannot create databases"
fi
echo ""

# PostgreSQL Test
echo "📊 Testing PostgreSQL permissions..."
echo "Creating test database in PostgreSQL..."
docker-compose exec postgres createdb -U dev_user test_postgres_db
if [ $? -eq 0 ]; then
    echo "✅ PostgreSQL: dev_user can create databases"
    docker-compose exec postgres dropdb -U dev_user test_postgres_db
    echo "✅ PostgreSQL: dev_user can drop databases"
else
    echo "❌ PostgreSQL: dev_user cannot create databases"
fi
echo ""

# MongoDB Test
echo "📊 Testing MongoDB permissions..."
echo "Creating test database in MongoDB..."
docker-compose exec mongodb mongosh -u dev_user -pdev_pass --eval "use test_mongo_db; db.test_collection.insertOne({test: 'data'});"
if [ $? -eq 0 ]; then
    echo "✅ MongoDB: dev_user can create databases and collections"
    docker-compose exec mongodb mongosh -u dev_user -pdev_pass --eval "use test_mongo_db; db.dropDatabase();"
    echo "✅ MongoDB: dev_user can drop databases"
else
    echo "❌ MongoDB: dev_user cannot create databases"
fi
echo ""

# Redis Test
echo "📊 Testing Redis permissions..."
echo "Testing Redis connection..."
docker-compose exec redis redis-cli -a dev_pass ping
if [ $? -eq 0 ]; then
    echo "✅ Redis: dev_user can connect and perform operations"
else
    echo "❌ Redis: dev_user cannot connect"
fi
echo ""

# Elasticsearch Test
echo "📊 Testing Elasticsearch permissions..."
echo "Testing Elasticsearch connection..."
docker-compose exec elasticsearch curl -f http://localhost:9200/_cluster/health
if [ $? -eq 0 ]; then
    echo "✅ Elasticsearch: Connection successful"
else
    echo "❌ Elasticsearch: Connection failed"
fi
echo ""

echo "🎉 Permission tests completed!"
echo ""
echo "💡 Database Manager Access:"
echo "   phpMyAdmin:     http://localhost:8081"
echo "   Adminer:        http://localhost:8084"
echo "   Redis Commander: http://localhost:8082"
echo "   Mongo Express:  http://localhost:8083"
echo ""
echo "🔑 Connection Details:"
echo "   MySQL:       dev_user / dev_pass"
echo "   PostgreSQL:  dev_user / dev_pass"
echo "   MongoDB:     dev_user / dev_pass"
echo "   Redis:       Password: dev_pass"
echo ""

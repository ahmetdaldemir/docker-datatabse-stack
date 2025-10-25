// MongoDB Initialization Script
// Bu script dev_user'a tam yetki verir

// dev_db database'ine geç
use dev_db;

// dev_user kullanıcısını oluştur (eğer yoksa)
try {
    db.createUser({
        user: "dev_user",
        pwd: "dev_pass",
        roles: [
            { role: "readWrite", db: "dev_db" },
            { role: "dbAdmin", db: "dev_db" },
            { role: "userAdmin", db: "dev_db" }
        ]
    });
    print("dev_user created successfully");
} catch (e) {
    print("dev_user might already exist: " + e);
}

// dev_user'a tüm database'lerde yetki ver
use admin;

try {
    db.createUser({
        user: "dev_user",
        pwd: "dev_pass",
        roles: [
            { role: "readWriteAnyDatabase", db: "admin" },
            { role: "dbAdminAnyDatabase", db: "admin" },
            { role: "userAdminAnyDatabase", db: "admin" },
            { role: "clusterAdmin", db: "admin" }
        ]
    });
    print("dev_user granted global permissions");
} catch (e) {
    print("dev_user global permissions might already exist: " + e);
}

// Test database'i oluştur
use test_db;
db.createCollection("test_collection");
print("test_db created with test_collection");

// dev_db'ye geri dön
use dev_db;
print("MongoDB initialization completed");

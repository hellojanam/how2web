module.exports = {
    HOST: process.env.DB_HOST || "mysql-0.mysql.default.svc.cluster.local",
    USER: process.env.DB_USER || "root",
    PASSWORD: process.env.DB_PASSWORD || "123456",
    DB: process.env.DB_NAME || "testdb"
  };
  
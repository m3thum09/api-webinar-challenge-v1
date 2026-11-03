const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DATABASE_URL || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
  database: process.env.DB_NAME || 'devops_db',
  port: 5432,
});

module.exports = pool;
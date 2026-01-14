# Strapi v4 + Supabase (Postgres Pooler) + Coolify
Production Configuration Guide

This document defines:
- Required ENV variables for Strapi in Coolify
- Supabase Pooler (PgBouncer) connection setup
- Strapi database configuration (Postgres + SSL)
- Production best practices

---

## 1. Environment Variables (Coolify)

Add the following environment variables to your **Strapi application in Coolify**.

### Core Strapi Settings
```env
NODE_ENV=production
HOST=0.0.0.0
PORT=1337

PUBLIC_URL=https://strapi.yourdomain.com
ADMIN_URL=/admin

APP_KEYS=key1,key2,key3,key4
API_TOKEN_SALT=replace_with_random_value
ADMIN_JWT_SECRET=replace_with_random_value
JWT_SECRET=replace_with_random_value

config/database.js:
module.exports = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      host: env('DATABASE_HOST'),
      port: env.int('DATABASE_PORT', 6543),
      database: env('DATABASE_NAME', 'postgres'),
      user: env('DATABASE_USERNAME'),
      password: env('DATABASE_PASSWORD'),
      ssl: env.bool('DATABASE_SSL', true)
        ? { rejectUnauthorized: env.bool('DATABASE_SSL_REJECT_UNAUTHORIZED', false) }
        : false,
    },
    pool: {
      min: 0,
      max: 10,
    },
  },
});


config/server.js: 
module.exports = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 1337),
  url: env('PUBLIC_URL'),
  proxy: true,
  app: {
    keys: env.array('APP_KEYS'),
  },
});

config/admin.js:
module.exports = ({ env }) => ({
  url: env('ADMIN_URL', '/admin'),
  auth: {
    secret: env('ADMIN_JWT_SECRET'),
  },
});
SSL errors:
DATABASE_SSL=true
DATABASE_SSL_REJECT_UNAUTHORIZED=false
Strapi (Coolify / Docker)
↓
Supabase Pooler (PgBouncer – Transaction)
↓
Supabase PostgreSQL


---

If you want, next I can:
- Generate **real secrets** for you
- Adapt this for **TypeScript config files**
- Add **S3 / Supabase Storage** config for media
- Validate your setup before deployment

Just say the word.

# Strapi for Coolify (PostgreSQL)

Production-ready Strapi project configured for Coolify deployments on a VPS using PostgreSQL and a multi-stage Docker build.

## Deploy with Coolify (Application Resource)

1) Create a new **Application** in Coolify pointing to this repository.
2) Set **Build Pack** to Dockerfile and **Dockerfile** path to `Dockerfile.prod`.
3) Configure **Environment Variables** (see list below).
4) Create a **PostgreSQL** service in Coolify and wire its credentials into the app env vars.
5) Add a **persistent volume** mounted to `/opt/app/public/uploads` to keep media files.
6) Deploy. Coolify handles reverse proxy and HTTPS.

## Required environment variables

Set these in Coolify (no defaults are assumed):

- `NODE_ENV=production`
- `DATABASE_CLIENT=postgres`
- `DATABASE_HOST`
- `DATABASE_PORT`
- `DATABASE_NAME`
- `DATABASE_USERNAME`
- `DATABASE_PASSWORD`
- `JWT_SECRET`
- `ADMIN_JWT_SECRET`
- `APP_KEYS` (comma-separated list of 4+ keys)

## Persistent uploads

Mount a volume to `/opt/app/public/uploads` so media persists across deployments.

## Notes

- Uses Yarn and Node.js LTS (alpine) in production.
- No Docker Compose required; Coolify manages services separately.

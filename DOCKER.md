# GetCommunity Docker Compose Setup

TO DO: Currently the frontend container serviced builds but does not serve the application properly. NEED TO DEBUG.

This Docker Compose configuration provides a complete local development environment for the GetCommunity application.

## Services

### 1. **Traefik** (Reverse Proxy)

- **Purpose**: Routes traffic between services with HTTPS support
- **Dashboard**: <https://localhost:8080>
- **Routing Rules**:
  - Backend (Strapi) handles the following paths:
    - `/_health` - Health check endpoint
    - `/admin` - Admin panel
    - `/api` - REST API endpoints
    - `/graphql` - GraphQL endpoint
    - `/content-manager` - Content management
    - `/content-type-builder` - Content type builder
    - `/email` - Email plugin
    - `/upload` & `/uploads` - File uploads
    - `/i18n` - Internationalization
    - `/seo` - SEO plugin
    - `/comments` - Comments plugin
    - `/strapi-plugin-cron` - Cron plugin
    - `/users-permissions` - User permissions
  - `https://localhost/*` → Frontend (all other routes)

### 2. **PostgreSQL 18**

- **Purpose**: Primary database
- **Port**: 5432
- **Default Credentials**:
  - Database: `dev_db`
  - Username: `postgres`
  - Password: `postgres`
- **Data Persistence**: Yes (via Docker volume `gc-www-db-data`)

### 3. **pgAdmin**

- **Purpose**: Database management interface
- **URL**: <http://localhost:5555>
- **Default Credentials**:
  - Email: `admin@getcommunity.com`
  - Password: `admin`

### 4. **Backend** (Strapi)

- **Image**: `getcommunity/www-backend:latest`
- **Internal Port**: 1337
- **API Access**: <https://localhost/api>
- **Admin Panel**: <https://localhost/admin>

### 5. **Frontend**

- **Image**: `getcommunity/www-frontend:latest`
- **Internal Port**: 3000
- **Access**: <https://localhost>

## Quick Start

### Prerequisites

- Docker Desktop installed and running
- `.env.dev` file in the workspace root

### Service Startup Order

The services start in a specific order to ensure dependencies are met:

1. **Traefik** and **PostgreSQL** start first
2. **Backend** waits for PostgreSQL to be healthy, then starts and runs migrations
3. **Frontend** waits for Backend to be healthy before building (the build process needs to fetch data from the API)
4. **pgAdmin** starts once PostgreSQL is healthy

This means the first startup may take a few minutes as each service waits for its dependencies.

### Starting the Application

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# View logs for a specific service
docker compose logs -f backend
docker compose logs -f frontend
```

### Stopping the Application

```bash
# Stop all services
docker compose down

# Stop and remove volumes (WARNING: This deletes the database!)
docker compose down -v
```

### Rebuilding Services

If you make changes to the Dockerfiles or application code:

```bash
# Rebuild and restart all services
docker compose up -d --build

# Rebuild a specific service
docker compose up -d --build backend
```

## Accessing Services

| Service           | URL                         | Notes                         |
|-------------------|-----------------------------|-------------------------------|
| Frontend          | <https://localhost>         | Main application              |
| Backend API       | <https://localhost/api>     | Strapi API endpoints          |
| Strapi Admin      | <https://localhost/admin>   | Strapi admin panel            |
| pgAdmin           | <http://localhost:5555>     | Database management           |
| Traefik Dashboard | <http://localhost:8080>     | Proxy configuration & routing |
| PostgreSQL        | localhost:5432              | Direct database access        |

## SSL Certificate

The setup uses a self-signed SSL certificate for HTTPS. Your browser will show a security warning on first access.

**To trust the certificate:**

1. Navigate to <https://localhost>
2. Click "Advanced" or "Show Details"
3. Click "Proceed to localhost (unsafe)" or "Accept the Risk"

The certificate is valid for 365 days and is located in `traefik/certs/`.

## Environment Variables

The services use environment variables from `.env.dev`. Key variables:

- `DATABASE_HOST`: Set to `postgres` (Docker service name)
- `DATABASE_PORT`: `5432`
- `STRAPI_BASE_URL`: `http://backend:1337` (internal Docker network)
- `VITE_STRAPI_URL`: `https://localhost/api` (external access)

## Connecting to PostgreSQL

### From pgAdmin

1. Navigate to <https://localhost/pgadmin>
2. Login with `admin@getcommunity.local` / `admin`
3. Add a new server:
   - **Name**: GetCommunity Local
   - **Host**: `postgres`
   - **Port**: `5432`
   - **Database**: `dev_db`
   - **Username**: `postgres`
   - **Password**: `postgres`

### From Local Machine

```bash
psql -h localhost -p 5432 -U postgres -d dev_db
# Password: postgres
```

## Troubleshooting

### Services won't start

```bash
# Check service status
docker compose ps

# Check logs for errors
docker compose logs

# Restart a specific service
docker compose restart backend
```

### Database connection errors

```bash
# Ensure PostgreSQL is healthy
docker compose ps postgres

# Check database logs
docker compose logs postgres

# Restart the database
docker compose restart postgres
```

### Port conflicts

If you get port binding errors, ensure ports 80, 443, 5432, and 8080 are not in use:

```bash
# Check what's using a port (macOS)
lsof -i :80
lsof -i :443
lsof -i :5432
lsof -i :8080
```

### Clear everything and start fresh

```bash
# Stop all services and remove volumes
docker compose down -v

# Remove all images
docker compose down --rmi all

# Start fresh
docker compose up -d --build
```

## Development Workflow

### Making Code Changes

The `docker-compose.yml` mounts your local code directories into the containers:

- `./apps/backend` → Backend container
- `./apps/frontend` → Frontend container

Changes to your code should be reflected automatically (depending on your Dockerfile setup with hot-reload).

### Viewing Real-time Logs

```bash
# All services
docker compose logs -f

# Specific services
docker compose logs -f backend frontend
```

### Executing Commands in Containers

```bash
# Backend (Strapi)
docker compose exec backend npm run strapi

# Frontend
docker compose exec frontend npm run build

# PostgreSQL
docker compose exec postgres psql -U postgres -d dev_db
```

## Network Architecture

All services run on the `gc-www-network` bridge network:

- Services can communicate using service names (e.g., `backend`, `postgres`)
- Traefik routes external traffic to the appropriate service
- Internal communication doesn't go through Traefik

## Data Persistence

The following data persists between restarts:

- **PostgreSQL data**: `gc-www-db-data` volume
- **pgAdmin settings**: `gc-www-pgadmin-data` volume

To reset the database:

```bash
docker compose down
docker volume rm getcommunity_gc-www-db-data
docker compose up -d
```

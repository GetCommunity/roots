#!/bin/bash
set -e

echo "Restoring custom-format dump..."
pg_restore -U "$DATABASE_USERNAME" -d "$DATABASE_NAME" --no-owner --no-privileges /docker-entrypoint-initdb.d/backup.dump

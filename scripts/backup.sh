#!/bin/bash

set -e

BACKUP_DIR="/opt/ep3/backups"
SECRETS_DIR="/opt/ep3/secrets"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
TARGET_DIR="$BACKUP_DIR/$TIMESTAMP"

mkdir -p "$TARGET_DIR"

cd "$PROJECT_DIR"

docker compose exec -T db sh -c \
  'mariadb-dump -u root -p"$MARIADB_ROOT_PASSWORD" --all-databases' \
  | gzip > "$TARGET_DIR/database.sql.gz"

tar \
  --exclude=".git" \
  --exclude="vendor" \
  --exclude="node_modules" \
  -czf "$TARGET_DIR/project.tar.gz" \
  -C "$(dirname "$PROJECT_DIR")" \
  "$(basename "$PROJECT_DIR")"

cp "$SECRETS_DIR/.htpasswd" "$TARGET_DIR/.htpasswd"

# Backups älter als 30 Tage löschen
find "$BACKUP_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;

echo
echo "Backup erfolgreich erstellt:"
echo "  Datenbank : $TARGET_DIR/database.sql.gz"
echo "  Projekt   : $TARGET_DIR/project.tar.gz"
echo "  .htpasswd : $TARGET_DIR/.htpasswd"

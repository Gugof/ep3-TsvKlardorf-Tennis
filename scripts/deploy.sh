#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_DIR"

echo "=== Deployment gestartet ==="
echo

echo "[1/4] Backup erstellen"
"$SCRIPT_DIR/backup.sh"
echo

echo "[2/4] Git-Status prüfen"

if [ -n "$(git status --porcelain)" ]; then
  echo "Fehler: Das Git-Arbeitsverzeichnis enthält lokale Änderungen."
  echo "Bitte zuerst committen oder verwerfen."
  exit 1
fi

echo "Git-Arbeitsverzeichnis ist sauber."
echo

echo "[3/4] Git aktualisieren"

git pull --ff-only

echo "Repository erfolgreich aktualisiert."
echo

echo "[4/4] Docker-Container aktualisieren"

docker compose up -d --build

echo
echo "=== Deployment erfolgreich abgeschlossen ==="


echo "Projekt: $PROJECT_DIR"
echo

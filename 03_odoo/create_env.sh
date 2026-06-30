#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"

# Backup existing .env if it exists
if [ -f "$ENV_FILE" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    mv "$ENV_FILE" "$ENV_FILE.backup_$TIMESTAMP"
fi

DB_PASSWORD="$(openssl rand -base64 32 | tr -dc 'A-Za-z0-9' | head -c 32)"

cat > "$ENV_FILE" <<EOF
# PostgreSQL
POSTGRES_DB=postgres
DB_HOST=db
DB_PORT=5432
DB_USER=odoo
DB_PASSWORD=$DB_PASSWORD
EOF

echo ".env generated successfully."
echo
echo "Database credentials:"
echo "  User:     odoo"
echo "  Password: $DB_PASSWORD"
echo
echo "Start with:"
echo "  make run_docker"
echo "or"
echo "  make run_podman"
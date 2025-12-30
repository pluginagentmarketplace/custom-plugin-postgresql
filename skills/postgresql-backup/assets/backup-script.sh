#!/bin/bash
# PostgreSQL Backup Script
BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump -Fc mydb > "$BACKUP_DIR/mydb_$DATE.dump"

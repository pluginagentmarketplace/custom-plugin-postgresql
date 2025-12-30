---
name: pg-backup
description: Create PostgreSQL database backups with verification
version: "3.0.0"
allowed-tools: Bash, Read
exit_codes:
  0: Backup successful
  1: Backup failed
  2: Verification failed
---

# /pg-backup - Database Backup

> Production-grade backup with verification and multiple formats

## Usage

```bash
/pg-backup [database]
/pg-backup --format custom --compress
/pg-backup --parallel 4 --format directory
```

## Options

| Option | Description | Default |
|--------|-------------|---------|
| `--format` | Output format | custom |
| `--compress` | Enable compression | true |
| `--parallel` | Parallel jobs | 1 |
| `--schema-only` | Schema without data | false |
| `--data-only` | Data without schema | false |
| `--verify` | Verify backup integrity | true |
| `--output` | Output path | ./backup/ |

## Backup Formats

| Format | Extension | Use Case | Restore Speed |
|--------|-----------|----------|---------------|
| `custom` | `.dump` | Standard, recommended | Fast |
| `directory` | folder | Large DBs, parallel | Fastest |
| `plain` | `.sql` | Portable, readable | Slow |
| `tar` | `.tar` | Archive compatible | Medium |

## Backup Commands

### Custom Format (Recommended)
```bash
pg_dump -h $HOST -U $USER -Fc -Z 6 \
    -f backup_$(date +%Y%m%d_%H%M%S).dump $DATABASE
```

### Directory Format (Large DBs)
```bash
pg_dump -h $HOST -U $USER -Fd -j 4 \
    -f backup_$(date +%Y%m%d_%H%M%S) $DATABASE
```

### With Timestamp and Compression
```bash
pg_dump -h $HOST -U $USER -Fc $DATABASE | \
    gzip > backup_${DATABASE}_$(date +%Y%m%d_%H%M%S).dump.gz
```

### Schema Only
```bash
pg_dump -h $HOST -U $USER --schema-only -f schema.sql $DATABASE
```

## Verification Steps

```bash
# 1. Check file size (should be > 0)
ls -lh backup.dump

# 2. List contents without restoring
pg_restore --list backup.dump | head -20

# 3. Test restore to temp database
createdb temp_verify
pg_restore -d temp_verify backup.dump
dropdb temp_verify
```

## Output Format

```
PostgreSQL Backup
=================
Database: mydb @ localhost:5432
Started: 2024-12-30T10:00:00Z
Format: custom (compressed)

Progress:
  [============================] 100%
  Tables: 45/45
  Size: 1.2GB

Backup Complete:
  File: ./backup/mydb_20241230_100000.dump
  Size: 450MB (compressed from 1.2GB)
  Duration: 2m 34s
  Compression: 62.5%

Verification:
  [OK] File integrity check passed
  [OK] Content listing successful
  [OK] 45 tables, 12 indexes, 8 functions

Exit code: 0
```

## Backup Strategy Recommendations

| Frequency | Type | Retention |
|-----------|------|-----------|
| Hourly | WAL archive | 24 hours |
| Daily | Full pg_dump | 7 days |
| Weekly | Full pg_basebackup | 4 weeks |
| Monthly | Off-site archive | 12 months |

## Automation Script

```bash
#!/bin/bash
# Daily backup with rotation

BACKUP_DIR="/backups/postgresql"
RETENTION_DAYS=7
DATABASE="mydb"

# Create backup
BACKUP_FILE="${BACKUP_DIR}/${DATABASE}_$(date +%Y%m%d).dump"
pg_dump -Fc -f "$BACKUP_FILE" "$DATABASE"

# Verify
pg_restore --list "$BACKUP_FILE" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Backup verified: $BACKUP_FILE"
else
    echo "Backup verification failed!"
    exit 1
fi

# Cleanup old backups
find "$BACKUP_DIR" -name "*.dump" -mtime +$RETENTION_DAYS -delete
```

## Examples

```bash
# Standard backup
/pg-backup mydb

# Fast parallel backup
/pg-backup mydb --format directory --parallel 4

# Schema only for version control
/pg-backup mydb --schema-only --format plain --output ./schema.sql

# Full backup with verification
/pg-backup mydb --verify --compress
```

## Troubleshooting

| Issue | Cause | Resolution |
|-------|-------|------------|
| Permission denied | Missing privileges | GRANT pg_read_all_data |
| Disk full | Insufficient space | Free space or use --compress |
| Timeout | Large database | Use --parallel |
| Locked tables | Active transactions | Schedule during low traffic |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Backup and verification successful |
| 1 | Backup failed |
| 2 | Backup completed, verification failed |

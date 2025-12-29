---
name: pg-backup
description: PostgreSQL backup and recovery - pg_dump, pg_basebackup, and PITR
sasmp_version: "1.3.0"
bonded_agent: pg-administration
bond_type: PRIMARY_BOND
---

# PostgreSQL Backup Skill

## Overview

Master PostgreSQL backup and recovery - logical backups, physical backups, and point-in-time recovery.

## Logical Backup (pg_dump)

### pg_dump
```bash
# Dump single database
pg_dump mydb > backup.sql

# Custom format (compressed, parallel restore)
pg_dump -Fc mydb > backup.dump

# Directory format (parallel dump)
pg_dump -Fd -j 4 mydb -f backup_dir/

# Schema only
pg_dump -s mydb > schema.sql

# Data only
pg_dump -a mydb > data.sql
```

### pg_restore
```bash
# Restore custom format
pg_restore -d mydb backup.dump

# Parallel restore
pg_restore -j 4 -d mydb backup.dump

# Create database and restore
pg_restore -C -d postgres backup.dump
```

## Physical Backup (pg_basebackup)

```bash
# Basic backup
pg_basebackup -D /backup/base -Fp -Xs -P

# With compression
pg_basebackup -D /backup/base -Ft -z -Xs -P
```

## Point-in-Time Recovery (PITR)

```ini
# Recovery configuration
restore_command = 'cp /archive/%f %p'
recovery_target_time = '2024-01-15 14:30:00'
recovery_target_action = 'promote'
```

## Quick Reference

| Tool | Use Case |
|------|----------|
| pg_dump | Single database logical backup |
| pg_dumpall | All databases + globals |
| pg_basebackup | Physical backup for replication/PITR |

## Related
- pg-replication - Streaming replication
- pg-administration agent

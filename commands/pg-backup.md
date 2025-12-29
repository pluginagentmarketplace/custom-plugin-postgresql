---
description: Create PostgreSQL database backups
allowed-tools: Bash, Read
---

# PostgreSQL Backup Command

Create database backups using pg_dump.

## Usage
```
/pg-backup [options]
```

## Options
- `--format` - Output format (sql, custom, directory)
- `--compress` - Enable compression
- `--parallel` - Number of parallel jobs
- `--schema-only` - Schema without data
- `--data-only` - Data without schema

## Examples
```
/pg-backup --format custom --compress
/pg-backup --parallel 4 --format directory
```

---
name: pg-basics
description: PostgreSQL basics - installation, psql, and configuration
sasmp_version: "1.3.0"
bonded_agent: pg-fundamentals
bond_type: PRIMARY_BOND
---

# PostgreSQL Basics Skill

## Overview

Master PostgreSQL fundamentals - installation, psql command-line, and basic configuration.

## Installation

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### macOS (Homebrew)
```bash
brew install postgresql@16
brew services start postgresql@16
```

### Docker
```bash
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=secret \
  -p 5432:5432 \
  postgres:16
```

## psql Commands

### Connection
```bash
# Connect to database
psql -h localhost -p 5432 -U postgres -d mydb

# Connection string
psql "postgresql://user:pass@host:5432/dbname"
```

### Meta-Commands
```sql
\l          -- List databases
\c dbname   -- Connect to database
\dt         -- List tables
\d table    -- Describe table
\du         -- List users
\df         -- List functions
\di         -- List indexes
\x          -- Expanded display
\timing     -- Toggle timing
\q          -- Quit
```

### psql Output
```sql
\o file.txt     -- Output to file
\copy table TO 'file.csv' CSV HEADER
\i script.sql   -- Execute script
```

## Configuration Files

### postgresql.conf
```ini
# Memory
shared_buffers = 256MB
work_mem = 64MB
effective_cache_size = 1GB

# Connections
max_connections = 100
listen_addresses = '*'

# Logging
log_destination = 'stderr'
logging_collector = on
log_statement = 'all'
```

### pg_hba.conf
```
# TYPE  DATABASE  USER  ADDRESS      METHOD
local   all       all                peer
host    all       all   127.0.0.1/32 scram-sha-256
host    all       all   ::1/128      scram-sha-256
```

## Database Management

```sql
-- Create database
CREATE DATABASE mydb
  OWNER = myuser
  ENCODING = 'UTF8'
  LC_COLLATE = 'en_US.UTF-8';

-- Drop database
DROP DATABASE mydb;

-- List databases
SELECT datname FROM pg_database;
```

## User Management

```sql
-- Create user
CREATE USER myuser WITH PASSWORD 'secret';

-- Create role with privileges
CREATE ROLE admin WITH LOGIN SUPERUSER;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader;
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `psql -l` | List databases |
| `\dt+` | Detailed table list |
| `\conninfo` | Connection info |
| `\password` | Change password |
| `pg_ctl reload` | Reload config |

## Related
- `pg-security` - Authentication deep dive
- `pg-fundamentals` agent

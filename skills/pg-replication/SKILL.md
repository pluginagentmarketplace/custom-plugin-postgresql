---
name: pg-replication
description: PostgreSQL replication - streaming, logical, and high availability
sasmp_version: "1.3.0"
bonded_agent: pg-replication
bond_type: PRIMARY_BOND
---

# PostgreSQL Replication Skill

## Overview

Master PostgreSQL replication - streaming, logical replication, and high availability.

## Streaming Replication

### Primary Configuration
```ini
# postgresql.conf on primary
wal_level = replica
max_wal_senders = 10
wal_keep_size = 1GB
hot_standby = on
```

```
# pg_hba.conf
host replication replicator 192.168.1.0/24 scram-sha-256
```

### Create Replication User
```sql
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'secret';
```

### Standby Setup
```bash
# Create base backup
pg_basebackup -h primary -D /var/lib/postgresql/data -U replicator -Xs -P

# Create standby.signal
touch /var/lib/postgresql/data/standby.signal
```

```ini
# postgresql.auto.conf on standby
primary_conninfo = 'host=primary port=5432 user=replicator password=secret'
```

## Logical Replication

### Publisher
```sql
-- Create publication
CREATE PUBLICATION my_pub FOR ALL TABLES;

-- Or specific tables
CREATE PUBLICATION orders_pub FOR TABLE orders, order_items;
```

### Subscriber
```sql
-- Create subscription
CREATE SUBSCRIPTION my_sub
CONNECTION 'host=publisher port=5432 dbname=mydb user=replicator'
PUBLICATION my_pub;
```

## Replication Slots

```sql
-- Create slot
SELECT pg_create_physical_replication_slot('standby1');

-- Logical slot
SELECT pg_create_logical_replication_slot('my_slot', 'pgoutput');

-- Monitor slots
SELECT * FROM pg_replication_slots;

-- Drop slot
SELECT pg_drop_replication_slot('standby1');
```

## Monitoring

```sql
-- Check replication status
SELECT * FROM pg_stat_replication;

-- Check lag
SELECT client_addr, state,
       pg_wal_lsn_diff(pg_current_wal_lsn(), sent_lsn) AS sent_lag,
       pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn) AS replay_lag
FROM pg_stat_replication;
```

## Quick Reference

| Mode | Use Case |
|------|----------|
| Streaming | Hot standby, read replicas |
| Logical | Selective replication, upgrades |
| Synchronous | Zero data loss |

## Related
- pg-backup - Base backups
- pg-administration agent

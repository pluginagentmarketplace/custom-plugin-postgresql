---
name: pg-performance
description: PostgreSQL performance - EXPLAIN, tuning, and optimization
sasmp_version: "1.3.0"
bonded_agent: pg-performance
bond_type: PRIMARY_BOND
---

# PostgreSQL Performance Skill

## Overview

Master PostgreSQL performance tuning - query analysis, configuration, and optimization.

## EXPLAIN

```sql
-- Basic explain
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- With execution stats
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- Verbose output
EXPLAIN (ANALYZE, VERBOSE, BUFFERS, FORMAT TEXT)
SELECT * FROM users WHERE email = 'test@example.com';

-- JSON format
EXPLAIN (ANALYZE, FORMAT JSON)
SELECT * FROM users WHERE email = 'test@example.com';
```

### Reading EXPLAIN Output
```
Seq Scan on users  (cost=0.00..10.50 rows=1 width=100) (actual time=0.010..0.050 rows=1 loops=1)
  Filter: (email = 'test@example.com'::text)
  Rows Removed by Filter: 499
Planning Time: 0.100 ms
Execution Time: 0.070 ms
```

Key metrics:
- **cost**: Estimated cost (startup..total)
- **rows**: Estimated row count
- **actual time**: Real execution time
- **loops**: Number of iterations

## Configuration Tuning

### Memory Settings
```ini
# postgresql.conf

# Shared memory (25% of RAM)
shared_buffers = 4GB

# Per-operation memory
work_mem = 256MB

# Maintenance operations
maintenance_work_mem = 1GB

# Effective cache size (50-75% of RAM)
effective_cache_size = 12GB

# WAL buffers
wal_buffers = 64MB
```

### Connection Settings
```ini
max_connections = 200
superuser_reserved_connections = 3
```

### Checkpoint Settings
```ini
checkpoint_timeout = 15min
checkpoint_completion_target = 0.9
max_wal_size = 4GB
min_wal_size = 1GB
```

## Statistics

```sql
-- Update statistics
ANALYZE users;
ANALYZE VERBOSE users;

-- Check statistics
SELECT * FROM pg_stats WHERE tablename = 'users';

-- Table statistics
SELECT relname, n_live_tup, n_dead_tup, last_vacuum, last_autovacuum
FROM pg_stat_user_tables;

-- Index usage
SELECT indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes;
```

## pg_stat_statements

```sql
-- Enable extension
CREATE EXTENSION pg_stat_statements;

-- Top queries by time
SELECT query, calls, total_exec_time, mean_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

-- Top queries by calls
SELECT query, calls, rows
FROM pg_stat_statements
ORDER BY calls DESC
LIMIT 10;

-- Reset statistics
SELECT pg_stat_statements_reset();
```

## VACUUM and AUTOVACUUM

```sql
-- Manual vacuum
VACUUM users;
VACUUM FULL users;  -- Rewrites entire table
VACUUM (VERBOSE, ANALYZE) users;

-- Check autovacuum settings
SHOW autovacuum;
SHOW autovacuum_vacuum_threshold;
SHOW autovacuum_vacuum_scale_factor;

-- Check bloat
SELECT schemaname, tablename,
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
       n_dead_tup,
       n_live_tup,
       round(100 * n_dead_tup / NULLIF(n_live_tup + n_dead_tup, 0), 2) AS dead_pct
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC;
```

## Connection Pooling (PgBouncer)

```ini
# pgbouncer.ini
[databases]
mydb = host=localhost port=5432 dbname=mydb

[pgbouncer]
listen_port = 6432
listen_addr = *
auth_type = md5
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 20
```

## Parallel Queries

```sql
-- Check parallel settings
SHOW max_parallel_workers_per_gather;
SHOW parallel_tuple_cost;

-- Force parallel
SET parallel_tuple_cost = 0;
SET parallel_setup_cost = 0;

-- Explain parallel plan
EXPLAIN ANALYZE SELECT COUNT(*) FROM large_table;
-- Shows: Parallel Seq Scan, Gather, Workers Planned: 2
```

## Quick Reference

| Metric | Target |
|--------|--------|
| shared_buffers | 25% of RAM |
| effective_cache_size | 50-75% of RAM |
| work_mem | 256MB-1GB |
| Cache hit ratio | > 99% |
| Index usage | > 95% |

## Related
- `pg-indexes` - Index optimization
- `pg-queries` - Query writing

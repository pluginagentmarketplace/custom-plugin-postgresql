---
name: pg-check
description: Comprehensive PostgreSQL database health check
version: "3.0.0"
allowed-tools: Bash, Read, Grep
exit_codes:
  0: All checks passed
  1: Warnings detected
  2: Critical issues found
---

# /pg-check - Database Health Check

> Production-grade health diagnostics for PostgreSQL 16+

## Usage

```bash
/pg-check [connection-string]
/pg-check --full
/pg-check --quick
```

## Options

| Option | Description | Default |
|--------|-------------|---------|
| `--full` | Run all checks including slow ones | false |
| `--quick` | Only critical checks | false |
| `--json` | Output as JSON | false |

## Checks Performed

### Critical (Always Run)
1. **Connection Status** - Verify database connectivity
2. **Active Connections** - Check against max_connections
3. **Replication Lag** - If replicas configured
4. **Lock Contention** - Blocking queries

### Standard
5. **Table Bloat** - Dead tuples count
6. **Index Usage** - Unused indexes
7. **Long-Running Queries** - > 5 minutes
8. **Disk Usage** - Database size trends

### Full Only
9. **Configuration Audit** - Best practice compliance
10. **Security Check** - Public grants, superusers

## Health Check Queries

```sql
-- Connection utilization
SELECT count(*) as current,
    (SELECT setting::int FROM pg_settings WHERE name = 'max_connections') as max,
    round(100.0 * count(*) / (SELECT setting::int FROM pg_settings WHERE name = 'max_connections'), 1) as pct
FROM pg_stat_activity;

-- Table bloat
SELECT schemaname, tablename, n_dead_tup, last_vacuum, last_autovacuum
FROM pg_stat_user_tables WHERE n_dead_tup > 10000
ORDER BY n_dead_tup DESC LIMIT 10;

-- Unused indexes
SELECT schemaname, tablename, indexrelname, idx_scan,
    pg_size_pretty(pg_relation_size(indexrelid)) as size
FROM pg_stat_user_indexes WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;

-- Long-running queries
SELECT pid, now() - query_start as duration, state, query
FROM pg_stat_activity
WHERE state != 'idle' AND now() - query_start > interval '5 minutes'
ORDER BY duration DESC;

-- Lock contention
SELECT blocked.pid AS blocked_pid, blocked.query AS blocked_query,
    blocking.pid AS blocking_pid, blocking.query AS blocking_query
FROM pg_stat_activity blocked
JOIN pg_locks blocked_locks ON blocked.pid = blocked_locks.pid
JOIN pg_locks blocking_locks ON blocked_locks.locktype = blocking_locks.locktype
    AND blocked_locks.relation = blocking_locks.relation
JOIN pg_stat_activity blocking ON blocking_locks.pid = blocking.pid
WHERE NOT blocked_locks.granted AND blocking_locks.granted;

-- Replication lag
SELECT client_addr, state,
    pg_size_pretty(pg_wal_lsn_diff(sent_lsn, replay_lsn)) as lag
FROM pg_stat_replication;

-- Cache hit ratio
SELECT round(100.0 * sum(heap_blks_hit) /
    nullif(sum(heap_blks_hit + heap_blks_read), 0), 2) as hit_ratio
FROM pg_statio_user_tables;
```

## Output Format

```
PostgreSQL Health Check Report
==============================
Database: mydb @ localhost:5432
Timestamp: 2024-12-30T10:00:00Z

[OK] Connection: Active
[OK] Connections: 45/200 (22.5%)
[WARN] Table bloat: 3 tables with >10K dead tuples
[CRITICAL] Lock: 2 blocked queries detected
[OK] Replication lag: 128KB

Summary: 1 Critical, 1 Warning, 4 OK
Exit code: 2
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All checks passed |
| 1 | Warnings detected (non-critical) |
| 2 | Critical issues found |

## Examples

```bash
# Quick check
/pg-check --quick

# Full audit with JSON output
/pg-check --full --json

# Specific database
/pg-check postgresql://user:pass@host:5432/dbname
```

## Troubleshooting

| Issue | Cause | Resolution |
|-------|-------|------------|
| Connection failed | Wrong credentials | Check connection string |
| Permissions error | Missing grants | GRANT pg_monitor TO user |
| Slow check | Large database | Use --quick option |

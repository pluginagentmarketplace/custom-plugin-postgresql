---
description: Check PostgreSQL database health and configuration
allowed-tools: Bash, Read, Grep
---

# PostgreSQL Check Command

Run comprehensive health checks on PostgreSQL database.

## Usage
```
/pg-check [connection-string]
```

## Checks Performed
1. Connection status
2. Configuration validation
3. Replication lag (if applicable)
4. Table bloat
5. Index usage
6. Long-running queries
7. Lock contention

## Example Queries Used
```sql
-- Connection count
SELECT count(*) FROM pg_stat_activity;

-- Table bloat
SELECT schemaname, tablename, n_dead_tup
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC;

-- Unused indexes
SELECT indexrelname FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

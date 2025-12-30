---
name: pg-optimize
description: Analyze and optimize PostgreSQL database performance
version: "3.0.0"
allowed-tools: Bash, Read, Write
exit_codes:
  0: Optimization complete
  1: Partial optimization
  2: Optimization failed
---

# /pg-optimize - Performance Optimization

> Analyze and optimize PostgreSQL database with actionable recommendations

## Usage

```bash
/pg-optimize [table-name]
/pg-optimize --full
/pg-optimize --dry-run
```

## Options

| Option | Description | Default |
|--------|-------------|---------|
| `--full` | Analyze entire database | false |
| `--dry-run` | Show recommendations only | false |
| `--apply` | Auto-apply safe optimizations | false |
| `--target-time` | Target query time in ms | 100 |

## Optimization Steps

### 1. Statistics Update
```sql
-- Refresh table statistics
ANALYZE VERBOSE table_name;

-- Check statistics age
SELECT schemaname, relname, last_analyze, last_autoanalyze
FROM pg_stat_user_tables
WHERE last_analyze < NOW() - INTERVAL '1 day';
```

### 2. Index Analysis
```sql
-- Find missing indexes (slow queries without index)
SELECT query, calls, mean_exec_time
FROM pg_stat_statements
WHERE query LIKE '%WHERE%'
  AND mean_exec_time > 100
ORDER BY total_exec_time DESC;

-- Find unused indexes
SELECT schemaname, tablename, indexrelname,
    pg_size_pretty(pg_relation_size(indexrelid)) as size
FROM pg_stat_user_indexes
WHERE idx_scan = 0 AND indexrelname NOT LIKE 'pg_%';

-- Find duplicate indexes
SELECT pg_size_pretty(sum(pg_relation_size(idx))::bigint) as size,
    array_agg(idx) as indexes
FROM (
    SELECT indexrelid::regclass as idx, indrelid, indkey
    FROM pg_index
) sub
GROUP BY indrelid, indkey HAVING count(*) > 1;
```

### 3. Bloat Detection
```sql
-- Table bloat
SELECT schemaname, tablename, n_dead_tup,
    pg_size_pretty(pg_total_relation_size(schemaname || '.' || tablename)) as size,
    round(100.0 * n_dead_tup / nullif(n_live_tup + n_dead_tup, 0), 1) as dead_pct
FROM pg_stat_user_tables
WHERE n_dead_tup > 10000
ORDER BY n_dead_tup DESC;

-- Recommend VACUUM
VACUUM (VERBOSE, ANALYZE) table_name;
```

### 4. Configuration Check
```sql
-- Memory settings
SELECT name, setting, unit, context
FROM pg_settings
WHERE name IN ('shared_buffers', 'work_mem', 'maintenance_work_mem', 'effective_cache_size');

-- Recommend based on RAM
-- shared_buffers = 25% of RAM
-- effective_cache_size = 75% of RAM
-- work_mem = RAM / max_connections / 4
```

## Output Format

```
PostgreSQL Optimization Report
==============================
Target: mydb.users
Timestamp: 2024-12-30T10:00:00Z

Analysis Results:
-----------------
[STATS] Last analyzed: 2 days ago → Run ANALYZE
[INDEX] Missing index detected on 'email' column
[BLOAT] 15% dead tuples → Schedule VACUUM
[UNUSED] 3 unused indexes wasting 250MB

Recommendations:
----------------
1. ANALYZE users;
2. CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
3. VACUUM (VERBOSE, ANALYZE) users;
4. DROP INDEX idx_users_old_unused;

Estimated Impact:
  - Query time: -65% (from 150ms to 52ms)
  - Storage saved: 250MB

[dry-run] Use --apply to execute recommendations
```

## Safe vs Risky Operations

| Operation | Risk Level | Auto-Apply |
|-----------|------------|------------|
| ANALYZE | Safe | Yes |
| CREATE INDEX CONCURRENTLY | Safe | Yes |
| VACUUM | Safe | Yes |
| DROP INDEX | Risky | No |
| VACUUM FULL | Risky | No |
| REINDEX | Risky | No |

## Examples

```bash
# Analyze single table
/pg-optimize users

# Full database dry-run
/pg-optimize --full --dry-run

# Auto-apply safe optimizations
/pg-optimize --full --apply
```

## Troubleshooting

| Issue | Cause | Resolution |
|-------|-------|------------|
| VACUUM blocked | Long transaction | Find and terminate |
| INDEX CONCURRENTLY failed | Unique violation | Fix duplicates first |
| No recommendations | Already optimized | Check query patterns |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All optimizations applied |
| 1 | Partial (some skipped) |
| 2 | Failed (errors occurred) |

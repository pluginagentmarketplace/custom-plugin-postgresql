---
name: pg-query
description: Execute and analyze PostgreSQL queries with EXPLAIN
version: "3.0.0"
allowed-tools: Bash, Read
exit_codes:
  0: Query executed successfully
  1: Query error
  2: Performance warning
---

# /pg-query - Query Execution & Analysis

> Execute queries with automatic EXPLAIN ANALYZE and optimization hints

## Usage

```bash
/pg-query <sql>
/pg-query --explain <sql>
/pg-query --safe <sql>
```

## Options

| Option | Description | Default |
|--------|-------------|---------|
| `--explain` | Show EXPLAIN ANALYZE output | true |
| `--safe` | Wrap in transaction, rollback | false |
| `--format` | Output format (text, json) | text |
| `--timeout` | Query timeout in seconds | 30 |

## Features

### Automatic Analysis
- EXPLAIN ANALYZE with BUFFERS
- Query plan visualization
- Performance bottleneck detection
- Index suggestions

### Safety Features
- Destructive query warnings (DELETE, UPDATE, DROP)
- Transaction wrapping option
- Timeout protection

## Query Analysis Flow

```
1. Parse query type (SELECT, INSERT, UPDATE, DELETE)
2. If destructive → Warn user, require --confirm or --safe
3. Run EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
4. Parse plan for issues:
   - Seq Scan on large tables
   - High buffer reads
   - Wrong row estimates
   - Missing indexes
5. Generate recommendations
6. Execute if approved
```

## Plan Analysis

```sql
-- Automatic EXPLAIN
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM users WHERE email = 'test@example.com';

-- Output analysis patterns:
-- ❌ Seq Scan on users (cost=0.00..1234.00 rows=50000)
--    → Suggest: CREATE INDEX idx_users_email ON users(email);
--
-- ✓ Index Scan using idx_users_email (cost=0.42..8.44 rows=1)
--    → Optimal
```

## Performance Thresholds

| Metric | OK | Warning | Critical |
|--------|----|---------| ---------|
| Execution time | < 100ms | 100ms-1s | > 1s |
| Rows scanned | < 10K | 10K-100K | > 100K |
| Buffer reads | < 1000 | 1K-10K | > 10K |

## Output Format

```
Query Analysis
==============
Query: SELECT * FROM users WHERE email = 'test@example.com'
Type: SELECT (safe)

Execution Plan:
  Index Scan using idx_users_email on users
    Index Cond: (email = 'test@example.com'::text)
    Rows: 1 (estimated: 1)
    Time: 0.042ms

Performance: ✓ Optimal
  - Uses index scan
  - Accurate row estimate
  - Low buffer reads

Results: 1 row returned
```

## Examples

```bash
# Simple query with analysis
/pg-query SELECT * FROM users WHERE status = 'active'

# Safe mode for UPDATE
/pg-query --safe UPDATE users SET status = 'inactive' WHERE last_login < '2024-01-01'

# Just EXPLAIN without execution
/pg-query --explain-only SELECT * FROM large_table
```

## Troubleshooting

| Issue | Cause | Resolution |
|-------|-------|------------|
| Query timeout | Slow query | Add index or optimize |
| Seq Scan warning | Missing index | Review WHERE columns |
| High buffer reads | Cold cache | Check shared_buffers |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Query executed successfully |
| 1 | Query error (syntax, permission) |
| 2 | Performance warning issued |

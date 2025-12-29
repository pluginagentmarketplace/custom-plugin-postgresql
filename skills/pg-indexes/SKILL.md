---
name: pg-indexes
description: PostgreSQL indexes - B-tree, GIN, GiST, BRIN, and optimization
sasmp_version: "1.3.0"
bonded_agent: pg-indexing
bond_type: PRIMARY_BOND
---

# PostgreSQL Indexes Skill

## Overview

Master PostgreSQL indexing - types, strategies, and optimization for query performance.

## Index Types

### B-tree (Default)
```sql
-- Default index type
CREATE INDEX idx_users_email ON users (email);

-- Composite index
CREATE INDEX idx_orders_user_date ON orders (user_id, created_at DESC);

-- Unique index
CREATE UNIQUE INDEX idx_users_username ON users (username);
```

### GIN (Generalized Inverted Index)
```sql
-- For arrays
CREATE INDEX idx_tags ON articles USING GIN (tags);

-- For JSONB
CREATE INDEX idx_profile ON users USING GIN (profile);
CREATE INDEX idx_profile_path ON users USING GIN (profile jsonb_path_ops);

-- For full-text search
CREATE INDEX idx_search ON articles USING GIN (to_tsvector('english', content));
```

### GiST (Generalized Search Tree)
```sql
-- For geometric data
CREATE INDEX idx_location ON places USING GiST (location);

-- For range types
CREATE INDEX idx_date_range ON events USING GiST (during);

-- For full-text
CREATE INDEX idx_search ON docs USING GiST (to_tsvector('english', content));
```

### BRIN (Block Range Index)
```sql
-- For large sequential data
CREATE INDEX idx_orders_created ON orders USING BRIN (created_at);

-- Very small index for huge tables
CREATE INDEX idx_logs_time ON logs USING BRIN (log_time) WITH (pages_per_range = 128);
```

### Hash
```sql
-- For equality comparisons only
CREATE INDEX idx_session ON sessions USING HASH (session_id);
```

## Partial Indexes

```sql
-- Index only active users
CREATE INDEX idx_active_users ON users (email)
WHERE is_active = true;

-- Index only pending orders
CREATE INDEX idx_pending_orders ON orders (created_at)
WHERE status = 'pending';

-- Index non-null values
CREATE INDEX idx_phone ON users (phone)
WHERE phone IS NOT NULL;
```

## Expression Indexes

```sql
-- Index on lowercase
CREATE INDEX idx_email_lower ON users (LOWER(email));

-- Index on function result
CREATE INDEX idx_year ON orders (EXTRACT(YEAR FROM created_at));

-- Index on JSONB field
CREATE INDEX idx_city ON users ((profile->>'city'));
```

## Covering Indexes (INCLUDE)

```sql
-- Include non-key columns
CREATE INDEX idx_orders_user ON orders (user_id)
INCLUDE (total, status);

-- Query can be answered from index only
SELECT total, status FROM orders WHERE user_id = 1;
```

## Concurrent Index Creation

```sql
-- Don't block writes
CREATE INDEX CONCURRENTLY idx_users_email ON users (email);

-- Drop concurrently
DROP INDEX CONCURRENTLY idx_users_email;
```

## Index Maintenance

```sql
-- Rebuild index
REINDEX INDEX idx_users_email;
REINDEX TABLE users;
REINDEX DATABASE mydb;

-- Reindex concurrently (PostgreSQL 12+)
REINDEX INDEX CONCURRENTLY idx_users_email;

-- Check index size
SELECT pg_size_pretty(pg_relation_size('idx_users_email'));

-- Check index usage
SELECT indexrelname, idx_scan, idx_tup_read
FROM pg_stat_user_indexes
WHERE schemaname = 'public';

-- Find unused indexes
SELECT indexrelname
FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

## Quick Reference

| Index Type | Best For |
|------------|----------|
| B-tree | Range, equality, sorting |
| GIN | Arrays, JSONB, full-text |
| GiST | Geometric, range, full-text |
| BRIN | Large sequential data |
| Hash | Equality only |

## Related
- `pg-performance` - Query optimization
- `pg-queries` - Using indexes effectively

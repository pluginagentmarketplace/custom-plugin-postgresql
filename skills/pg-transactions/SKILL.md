---
name: pg-transactions
description: PostgreSQL transactions - ACID, isolation levels, and locking
sasmp_version: "1.3.0"
bonded_agent: pg-sql-mastery
bond_type: SECONDARY_BOND
---

# PostgreSQL Transactions Skill

## Overview

Master PostgreSQL transactions - ACID properties, isolation levels, and locking mechanisms.

## Basic Transactions

```sql
-- Start transaction
BEGIN;
-- or
START TRANSACTION;

-- Execute statements
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Commit
COMMIT;

-- Or rollback
ROLLBACK;
```

## Savepoints

```sql
BEGIN;
INSERT INTO orders (user_id, total) VALUES (1, 100);

SAVEPOINT sp1;
INSERT INTO order_items (order_id, product_id) VALUES (1, 100);
-- Oops, error
ROLLBACK TO SAVEPOINT sp1;

-- Continue with different item
INSERT INTO order_items (order_id, product_id) VALUES (1, 200);
COMMIT;
```

## Isolation Levels

```sql
-- Read Committed (default)
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Repeatable Read
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Serializable
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Read Uncommitted (same as Read Committed in PostgreSQL)
BEGIN TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Set default for session
SET default_transaction_isolation = 'serializable';
```

### Isolation Level Behavior

| Level | Dirty Read | Non-Repeatable Read | Phantom Read | Serialization Anomaly |
|-------|------------|---------------------|--------------|----------------------|
| Read Committed | No | Yes | Yes | Yes |
| Repeatable Read | No | No | No | Yes |
| Serializable | No | No | No | No |

## Locking

### Row-Level Locks
```sql
-- SELECT FOR UPDATE (exclusive lock)
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;

-- SELECT FOR SHARE (shared lock)
SELECT * FROM accounts WHERE id = 1 FOR SHARE;

-- NOWAIT (fail immediately if locked)
SELECT * FROM accounts WHERE id = 1 FOR UPDATE NOWAIT;

-- SKIP LOCKED (skip locked rows)
SELECT * FROM jobs WHERE status = 'pending'
FOR UPDATE SKIP LOCKED
LIMIT 1;
```

### Table-Level Locks
```sql
-- Explicit table lock
LOCK TABLE users IN SHARE MODE;
LOCK TABLE users IN EXCLUSIVE MODE;
LOCK TABLE users IN ACCESS EXCLUSIVE MODE;
```

### Advisory Locks
```sql
-- Get advisory lock (session-level)
SELECT pg_advisory_lock(12345);

-- Try lock (non-blocking)
SELECT pg_try_advisory_lock(12345);

-- Release lock
SELECT pg_advisory_unlock(12345);

-- Transaction-level advisory lock
SELECT pg_advisory_xact_lock(12345);
```

## Deadlock Prevention

```sql
-- Always lock in consistent order
BEGIN;
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;
SELECT * FROM accounts WHERE id = 2 FOR UPDATE;
-- Process...
COMMIT;

-- Check for deadlocks
SELECT * FROM pg_locks WHERE NOT granted;

-- View blocking queries
SELECT blocked.pid AS blocked_pid,
       blocking.pid AS blocking_pid,
       blocked.query AS blocked_query
FROM pg_catalog.pg_locks blocked
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked.pid = blocked_activity.pid
JOIN pg_catalog.pg_locks blocking ON blocking.locktype = blocked.locktype
WHERE NOT blocked.granted;
```

## MVCC (Multi-Version Concurrency Control)

```sql
-- Check transaction ID
SELECT txid_current();

-- Check row versions
SELECT xmin, xmax, * FROM users LIMIT 5;

-- xmin: transaction ID that created the row
-- xmax: transaction ID that deleted/updated the row
```

## Quick Reference

| Lock Mode | Conflict With |
|-----------|---------------|
| FOR UPDATE | All other locks |
| FOR NO KEY UPDATE | FOR UPDATE, FOR SHARE |
| FOR SHARE | FOR UPDATE, FOR NO KEY UPDATE |
| FOR KEY SHARE | FOR UPDATE |

## Related
- `pg-performance` - Lock contention
- `pg-functions` - Transaction in procedures

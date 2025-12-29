---
name: pg-dml
description: PostgreSQL DML - INSERT, UPDATE, DELETE, MERGE, and UPSERT
sasmp_version: "1.3.0"
bonded_agent: pg-sql-mastery
bond_type: PRIMARY_BOND
---

# PostgreSQL DML Skill

## Overview

Master Data Manipulation Language - insert, update, delete, and upsert data.

## INSERT

### Basic INSERT
```sql
-- Single row
INSERT INTO users (username, email)
VALUES ('john', 'john@example.com');

-- Multiple rows
INSERT INTO users (username, email) VALUES
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com'),
    ('carol', 'carol@example.com');

-- With RETURNING
INSERT INTO users (username, email)
VALUES ('dave', 'dave@example.com')
RETURNING id, created_at;
```

### INSERT from SELECT
```sql
INSERT INTO archive_orders (id, user_id, total)
SELECT id, user_id, total
FROM orders
WHERE created_at < '2024-01-01';
```

### UPSERT (INSERT ON CONFLICT)
```sql
-- Update on conflict
INSERT INTO users (id, username, email)
VALUES (1, 'john', 'new@example.com')
ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    updated_at = NOW();

-- Do nothing on conflict
INSERT INTO users (username, email)
VALUES ('john', 'john@example.com')
ON CONFLICT (username) DO NOTHING;

-- With WHERE clause
INSERT INTO products (sku, price)
VALUES ('ABC123', 99.99)
ON CONFLICT (sku) DO UPDATE SET
    price = EXCLUDED.price
WHERE products.price < EXCLUDED.price;
```

## UPDATE

### Basic UPDATE
```sql
-- Single column
UPDATE users SET is_active = false WHERE id = 1;

-- Multiple columns
UPDATE users SET
    email = 'newemail@example.com',
    updated_at = NOW()
WHERE username = 'john';
```

### UPDATE with JOIN
```sql
UPDATE orders o
SET status = 'cancelled'
FROM users u
WHERE o.user_id = u.id
  AND u.is_active = false;
```

### UPDATE with Subquery
```sql
UPDATE products
SET category_id = (
    SELECT id FROM categories WHERE name = 'Electronics'
)
WHERE name LIKE '%Phone%';
```

### UPDATE with RETURNING
```sql
UPDATE users
SET last_login = NOW()
WHERE id = 1
RETURNING id, username, last_login;
```

## DELETE

### Basic DELETE
```sql
-- Delete specific rows
DELETE FROM users WHERE is_active = false;

-- Delete all (use with caution!)
DELETE FROM temp_data;

-- With RETURNING
DELETE FROM orders
WHERE status = 'cancelled'
RETURNING id, user_id;
```

### DELETE with JOIN
```sql
DELETE FROM orders o
USING users u
WHERE o.user_id = u.id
  AND u.is_deleted = true;
```

### TRUNCATE (faster than DELETE)
```sql
-- Truncate single table
TRUNCATE TABLE logs;

-- Truncate with cascade
TRUNCATE TABLE users CASCADE;

-- Truncate multiple tables
TRUNCATE TABLE orders, order_items RESTART IDENTITY;
```

## MERGE (PostgreSQL 15+)

```sql
MERGE INTO products AS target
USING new_products AS source
ON target.sku = source.sku
WHEN MATCHED THEN
    UPDATE SET
        price = source.price,
        updated_at = NOW()
WHEN NOT MATCHED THEN
    INSERT (sku, name, price)
    VALUES (source.sku, source.name, source.price);
```

## COPY (Bulk Operations)

```sql
-- Export to CSV
COPY users TO '/tmp/users.csv' WITH CSV HEADER;

-- Import from CSV
COPY users (username, email) FROM '/tmp/new_users.csv' WITH CSV HEADER;

-- From stdin (psql)
\copy users FROM 'users.csv' WITH CSV HEADER
```

## Quick Reference

| Operation | With RETURNING |
|-----------|----------------|
| INSERT | Returns inserted rows |
| UPDATE | Returns updated rows |
| DELETE | Returns deleted rows |

## Related
- `pg-ddl` - Table structure
- `pg-transactions` - Transaction control

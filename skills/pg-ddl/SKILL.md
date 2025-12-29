---
name: pg-ddl
description: PostgreSQL DDL - tables, schemas, constraints, and views
sasmp_version: "1.3.0"
bonded_agent: pg-sql-mastery
bond_type: PRIMARY_BOND
---

# PostgreSQL DDL Skill

## Overview

Master Data Definition Language - create, alter, and manage database objects.

## Tables

### CREATE TABLE
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT true,
    profile JSONB DEFAULT '{}'::jsonb
);

-- With foreign key
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    total NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### ALTER TABLE
```sql
-- Add column
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Modify column
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(200);
ALTER TABLE users ALTER COLUMN email SET NOT NULL;

-- Rename
ALTER TABLE users RENAME COLUMN phone TO phone_number;
ALTER TABLE users RENAME TO app_users;

-- Add constraint
ALTER TABLE orders ADD CONSTRAINT positive_total CHECK (total > 0);

-- Drop constraint
ALTER TABLE orders DROP CONSTRAINT positive_total;
```

## Constraints

```sql
-- Primary Key
CREATE TABLE items (
    id SERIAL PRIMARY KEY
);

-- Composite Primary Key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

-- Foreign Key
FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE SET NULL

-- Unique
username VARCHAR(50) UNIQUE
-- Or named constraint
CONSTRAINT uk_username UNIQUE (username)

-- Check
CHECK (age >= 18)
CONSTRAINT positive_price CHECK (price > 0)

-- Not Null
email VARCHAR(100) NOT NULL

-- Default
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
status VARCHAR(20) DEFAULT 'active'
```

## Schemas

```sql
-- Create schema
CREATE SCHEMA sales;
CREATE SCHEMA IF NOT EXISTS analytics;

-- Create with owner
CREATE SCHEMA sales AUTHORIZATION sales_admin;

-- Use schema
SET search_path TO sales, public;

-- Create table in schema
CREATE TABLE sales.orders (...);

-- Grant access
GRANT USAGE ON SCHEMA sales TO analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO analyst;
```

## Views

```sql
-- Simple view
CREATE VIEW active_users AS
SELECT id, username, email
FROM users
WHERE is_active = true;

-- View with joins
CREATE VIEW order_summary AS
SELECT o.id, u.username, o.total, o.status
FROM orders o
JOIN users u ON o.user_id = u.id;

-- Materialized view
CREATE MATERIALIZED VIEW monthly_sales AS
SELECT DATE_TRUNC('month', created_at) AS month,
       SUM(total) AS revenue
FROM orders
GROUP BY 1;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW monthly_sales;
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_sales;
```

## Sequences

```sql
-- Create sequence
CREATE SEQUENCE order_seq START 1000 INCREMENT 1;

-- Use sequence
INSERT INTO orders (id, ...) VALUES (nextval('order_seq'), ...);

-- Alter sequence
ALTER SEQUENCE order_seq RESTART WITH 5000;

-- Get current value
SELECT currval('order_seq');
SELECT lastval();
```

## Quick Reference

| DDL | Purpose |
|-----|---------|
| `CREATE TABLE` | Define new table |
| `ALTER TABLE` | Modify table structure |
| `DROP TABLE` | Remove table |
| `CREATE VIEW` | Define virtual table |
| `CREATE INDEX` | Create index |
| `CREATE SCHEMA` | Create namespace |

## Related
- `pg-dml` - Data manipulation
- `pg-indexes` - Index creation

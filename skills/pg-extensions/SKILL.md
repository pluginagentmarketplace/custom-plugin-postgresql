---
name: pg-extensions
description: PostgreSQL extensions - PostGIS, pgvector, TimescaleDB, and more
sasmp_version: "1.3.0"
bonded_agent: pg-advanced
bond_type: PRIMARY_BOND
---

# PostgreSQL Extensions Skill

## Overview

Master PostgreSQL extensions - extend functionality with PostGIS, pgvector, TimescaleDB, and more.

## Extension Management

```sql
-- List available extensions
SELECT * FROM pg_available_extensions;

-- Install extension
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Upgrade extension
ALTER EXTENSION pg_stat_statements UPDATE;

-- Drop extension
DROP EXTENSION pg_stat_statements;

-- List installed
SELECT * FROM pg_extension;
```

## Popular Extensions

### pgcrypto
```sql
CREATE EXTENSION pgcrypto;

-- Hash password
SELECT crypt('password', gen_salt('bf'));

-- Verify password
SELECT (password = crypt('input', password)) AS valid;

-- Generate UUID
SELECT gen_random_uuid();
```

### pg_stat_statements
```sql
CREATE EXTENSION pg_stat_statements;

-- Top queries by time
SELECT query, calls, total_exec_time, mean_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;
```

### PostGIS
```sql
CREATE EXTENSION postgis;

-- Create geometry
SELECT ST_GeomFromText('POINT(-122.4194 37.7749)', 4326);

-- Distance query
SELECT name, ST_Distance(
    location::geography,
    ST_SetSRID(ST_MakePoint(-122.4194, 37.7749), 4326)::geography
) AS distance
FROM places
ORDER BY distance
LIMIT 10;
```

### pgvector
```sql
CREATE EXTENSION vector;

-- Create table with vector column
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    embedding vector(384)
);

-- Create index
CREATE INDEX ON items USING ivfflat (embedding vector_l2_ops);

-- Similarity search
SELECT id, embedding <-> '[0.1, 0.2, ...]'::vector AS distance
FROM items
ORDER BY distance
LIMIT 10;
```

### TimescaleDB
```sql
CREATE EXTENSION timescaledb;

-- Create hypertable
SELECT create_hypertable('metrics', 'time');

-- Continuous aggregates
CREATE MATERIALIZED VIEW daily_avg
WITH (timescaledb.continuous) AS
SELECT time_bucket('1 day', time) AS bucket,
       avg(value) AS avg_value
FROM metrics
GROUP BY bucket;
```

### pg_trgm (Fuzzy Search)
```sql
CREATE EXTENSION pg_trgm;

-- Create index
CREATE INDEX idx_name_trgm ON users USING GIN (name gin_trgm_ops);

-- Similarity search
SELECT name, similarity(name, 'John') AS sim
FROM users
WHERE name % 'John'
ORDER BY sim DESC;
```

### uuid-ossp
```sql
CREATE EXTENSION "uuid-ossp";

SELECT uuid_generate_v4();
SELECT uuid_generate_v1();
```

### hstore (Key-Value)
```sql
CREATE EXTENSION hstore;

-- Create column
ALTER TABLE products ADD COLUMN attributes hstore;

-- Insert
INSERT INTO products (name, attributes)
VALUES ('Laptop', 'color => black, ram => 16GB');

-- Query
SELECT * FROM products WHERE attributes -> 'color' = 'black';
```

## Foreign Data Wrappers

```sql
-- postgres_fdw for remote PostgreSQL
CREATE EXTENSION postgres_fdw;

CREATE SERVER remote_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'remote', dbname 'otherdb');

CREATE USER MAPPING FOR current_user
SERVER remote_server
OPTIONS (user 'remote_user', password 'secret');

CREATE FOREIGN TABLE remote_users (
    id INTEGER,
    name TEXT
) SERVER remote_server OPTIONS (table_name 'users');
```

## Quick Reference

| Extension | Use Case |
|-----------|----------|
| pgcrypto | Encryption, hashing |
| PostGIS | Geospatial data |
| pgvector | AI/ML embeddings |
| TimescaleDB | Time-series data |
| pg_trgm | Fuzzy text search |
| postgres_fdw | Remote databases |

## Related
- pg-functions - Custom functions
- pg-advanced agent

---
description: Execute and analyze PostgreSQL queries
allowed-tools: Bash, Read
---

# PostgreSQL Query Command

Execute queries with EXPLAIN ANALYZE for performance insights.

## Usage
```
/pg-query <sql>
```

## Features
- Automatic EXPLAIN ANALYZE
- Query plan visualization
- Performance recommendations
- Index suggestions

## Example
```
/pg-query SELECT * FROM users WHERE email = 'test@example.com'
```

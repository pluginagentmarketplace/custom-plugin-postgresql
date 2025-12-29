---
name: pg-queries
description: PostgreSQL advanced queries - JOINs, CTEs, window functions, and aggregations
sasmp_version: "1.3.0"
bonded_agent: pg-sql-mastery
bond_type: PRIMARY_BOND
---

# PostgreSQL Advanced Queries Skill

## Overview

Master complex queries - JOINs, CTEs, window functions, and analytical queries.

## JOINs

```sql
-- INNER JOIN
SELECT u.username, o.total
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- LEFT JOIN (all users, even without orders)
SELECT u.username, COALESCE(SUM(o.total), 0) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id;

-- RIGHT JOIN
SELECT o.id, u.username
FROM orders o
RIGHT JOIN users u ON o.user_id = u.id;

-- FULL OUTER JOIN
SELECT u.username, o.id
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id;

-- CROSS JOIN (Cartesian product)
SELECT p.name, c.name AS color
FROM products p
CROSS JOIN colors c;

-- LATERAL JOIN
SELECT u.username, recent.*
FROM users u
CROSS JOIN LATERAL (
    SELECT id, total
    FROM orders
    WHERE user_id = u.id
    ORDER BY created_at DESC
    LIMIT 3
) AS recent;
```

## CTEs (Common Table Expressions)

```sql
-- Basic CTE
WITH active_users AS (
    SELECT * FROM users WHERE is_active = true
)
SELECT u.username, COUNT(o.id) AS order_count
FROM active_users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id;

-- Multiple CTEs
WITH 
monthly_sales AS (
    SELECT DATE_TRUNC('month', created_at) AS month,
           SUM(total) AS revenue
    FROM orders
    GROUP BY 1
),
growth AS (
    SELECT month, revenue,
           LAG(revenue) OVER (ORDER BY month) AS prev_revenue
    FROM monthly_sales
)
SELECT month, revenue,
       ROUND((revenue - prev_revenue) / prev_revenue * 100, 2) AS growth_pct
FROM growth;

-- Recursive CTE (hierarchical data)
WITH RECURSIVE org_chart AS (
    -- Base case
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case
    SELECT e.id, e.name, e.manager_id, oc.level + 1
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT * FROM org_chart ORDER BY level, name;
```

## Window Functions

```sql
-- ROW_NUMBER
SELECT username, total,
       ROW_NUMBER() OVER (ORDER BY total DESC) AS rank
FROM user_totals;

-- RANK and DENSE_RANK
SELECT product_id, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS dense_rank
FROM product_sales;

-- Partitioned ranking
SELECT category, product_name, revenue,
       RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS category_rank
FROM products;

-- LAG and LEAD
SELECT order_date, revenue,
       LAG(revenue) OVER (ORDER BY order_date) AS prev_day,
       LEAD(revenue) OVER (ORDER BY order_date) AS next_day
FROM daily_sales;

-- Running totals
SELECT order_date, revenue,
       SUM(revenue) OVER (ORDER BY order_date) AS running_total
FROM daily_sales;

-- Moving average
SELECT order_date, revenue,
       AVG(revenue) OVER (
           ORDER BY order_date
           ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS moving_avg_7day
FROM daily_sales;

-- NTILE (quartiles/buckets)
SELECT customer_id, total_spent,
       NTILE(4) OVER (ORDER BY total_spent) AS spending_quartile
FROM customer_summary;
```

## Aggregations

```sql
-- GROUP BY with HAVING
SELECT category, AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 100;

-- GROUP BY ROLLUP
SELECT region, category, SUM(sales)
FROM product_sales
GROUP BY ROLLUP (region, category);

-- GROUP BY CUBE
SELECT region, category, SUM(sales)
FROM product_sales
GROUP BY CUBE (region, category);

-- GROUPING SETS
SELECT region, category, SUM(sales)
FROM product_sales
GROUP BY GROUPING SETS (
    (region, category),
    (region),
    (category),
    ()
);

-- FILTER clause
SELECT 
    COUNT(*) FILTER (WHERE status = 'completed') AS completed,
    COUNT(*) FILTER (WHERE status = 'pending') AS pending,
    SUM(total) FILTER (WHERE status = 'completed') AS completed_revenue
FROM orders;
```

## Quick Reference

| Window Function | Use Case |
|-----------------|----------|
| ROW_NUMBER() | Unique row number |
| RANK() | Rank with gaps |
| DENSE_RANK() | Rank without gaps |
| LAG/LEAD | Access previous/next row |
| SUM() OVER | Running total |
| AVG() OVER | Moving average |
| NTILE(n) | Divide into buckets |

## Related
- `pg-performance` - Query optimization
- `pg-indexes` - Index usage

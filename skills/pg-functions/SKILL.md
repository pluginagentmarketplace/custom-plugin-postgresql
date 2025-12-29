---
name: pg-functions
description: PostgreSQL functions - PL/pgSQL, triggers, and stored procedures
sasmp_version: "1.3.0"
bonded_agent: pg-advanced
bond_type: PRIMARY_BOND
---

# PostgreSQL Functions Skill

## Overview

Master PL/pgSQL functions, procedures, triggers, and custom aggregates.

## SQL Functions

```sql
-- Simple SQL function
CREATE FUNCTION get_user_count() 
RETURNS INTEGER AS $$
    SELECT COUNT(*)::INTEGER FROM users;
$$ LANGUAGE SQL;

-- With parameters
CREATE FUNCTION get_user_orders(user_id INTEGER)
RETURNS TABLE (id INTEGER, total NUMERIC) AS $$
    SELECT id, total FROM orders WHERE orders.user_id = get_user_orders.user_id;
$$ LANGUAGE SQL;
```

## PL/pgSQL Functions

```sql
-- Basic function
CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_pct NUMERIC
) RETURNS NUMERIC AS $$
BEGIN
    RETURN price * (1 - discount_pct / 100);
END;
$$ LANGUAGE plpgsql;

-- With control flow
CREATE OR REPLACE FUNCTION get_order_status(order_id INTEGER)
RETURNS TEXT AS $$
DECLARE
    order_total NUMERIC;
    result TEXT;
BEGIN
    SELECT total INTO order_total FROM orders WHERE id = order_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', order_id;
    END IF;
    
    IF order_total > 1000 THEN
        result := 'premium';
    ELSIF order_total > 100 THEN
        result := 'standard';
    ELSE
        result := 'basic';
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Returning multiple rows
CREATE OR REPLACE FUNCTION search_users(search_term TEXT)
RETURNS SETOF users AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM users
    WHERE username ILIKE '%' || search_term || '%'
       OR email ILIKE '%' || search_term || '%';
END;
$$ LANGUAGE plpgsql;
```

## Stored Procedures (PostgreSQL 11+)

```sql
-- Procedure (can commit/rollback)
CREATE OR REPLACE PROCEDURE transfer_funds(
    from_account INTEGER,
    to_account INTEGER,
    amount NUMERIC
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE accounts SET balance = balance - amount WHERE id = from_account;
    UPDATE accounts SET balance = balance + amount WHERE id = to_account;
    
    INSERT INTO transactions (from_id, to_id, amount) 
    VALUES (from_account, to_account, amount);
    
    COMMIT;
END;
$$;

-- Call procedure
CALL transfer_funds(1, 2, 100.00);
```

## Triggers

```sql
-- Trigger function
CREATE OR REPLACE FUNCTION update_modified_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER set_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_timestamp();

-- Audit trigger
CREATE OR REPLACE FUNCTION audit_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (table_name, operation, new_data)
        VALUES (TG_TABLE_NAME, 'INSERT', row_to_json(NEW));
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (table_name, operation, old_data, new_data)
        VALUES (TG_TABLE_NAME, 'UPDATE', row_to_json(OLD), row_to_json(NEW));
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log (table_name, operation, old_data)
        VALUES (TG_TABLE_NAME, 'DELETE', row_to_json(OLD));
    END IF;
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_audit
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW
    EXECUTE FUNCTION audit_changes();
```

## Custom Aggregates

```sql
-- State transition function
CREATE FUNCTION array_agg_state(state TEXT[], elem TEXT)
RETURNS TEXT[] AS $$
    SELECT array_append(state, elem);
$$ LANGUAGE SQL;

-- Create aggregate
CREATE AGGREGATE custom_agg(TEXT) (
    SFUNC = array_agg_state,
    STYPE = TEXT[],
    INITCOND = '{}'
);
```

## Quick Reference

| Construct | Use Case |
|-----------|----------|
| FUNCTION | Returns value, no side effects |
| PROCEDURE | Side effects, transactions |
| TRIGGER | Automatic response to changes |
| AGGREGATE | Custom aggregation logic |

## Related
- `pg-transactions` - Transaction control
- `pg-advanced` agent

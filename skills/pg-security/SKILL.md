---
name: pg-security
description: PostgreSQL security - authentication, authorization, and encryption
sasmp_version: "1.3.0"
bonded_agent: pg-administration
bond_type: SECONDARY_BOND
---

# PostgreSQL Security Skill

## Overview

Master PostgreSQL security - authentication, authorization, row-level security, and encryption.

## Authentication (pg_hba.conf)

```
# TYPE  DATABASE  USER  ADDRESS       METHOD
local   all       all                 peer
host    all       all   127.0.0.1/32  scram-sha-256
host    all       all   ::1/128       scram-sha-256
host    mydb      user  192.168.1.0/24 scram-sha-256
hostssl all       all   0.0.0.0/0     cert
```

### Authentication Methods
- **peer**: OS username matching
- **scram-sha-256**: Secure password (recommended)
- **md5**: Legacy password hash
- **cert**: SSL certificate
- **ldap**: LDAP authentication
- **gss**: Kerberos

## Roles and Privileges

```sql
-- Create role
CREATE ROLE readonly;
CREATE ROLE app_user WITH LOGIN PASSWORD 'secret';

-- Grant privileges
GRANT CONNECT ON DATABASE mydb TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;

-- Default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readonly;

-- Revoke
REVOKE DELETE ON users FROM app_user;

-- Role membership
GRANT readonly TO app_user;
```

## Row-Level Security (RLS)

```sql
-- Enable RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Policy for users to see only their orders
CREATE POLICY user_orders ON orders
FOR ALL
USING (user_id = current_setting('app.user_id')::int);

-- Admin bypass
CREATE POLICY admin_all ON orders
FOR ALL
TO admin_role
USING (true);

-- Force RLS for table owner too
ALTER TABLE orders FORCE ROW LEVEL SECURITY;
```

## SSL/TLS

### Server Configuration
```ini
# postgresql.conf
ssl = on
ssl_cert_file = 'server.crt'
ssl_key_file = 'server.key'
ssl_ca_file = 'root.crt'
```

### Client Connection
```bash
psql "sslmode=require host=server dbname=mydb"
psql "sslmode=verify-full sslrootcert=root.crt host=server"
```

## Column Encryption

```sql
-- Using pgcrypto
CREATE EXTENSION pgcrypto;

-- Encrypt
INSERT INTO users (email, ssn_encrypted)
VALUES ('user@example.com', pgp_sym_encrypt('123-45-6789', 'secret_key'));

-- Decrypt
SELECT email, pgp_sym_decrypt(ssn_encrypted, 'secret_key') AS ssn
FROM users;
```

## Audit Logging

```ini
# postgresql.conf
log_statement = 'all'
log_connections = on
log_disconnections = on
```

## Quick Reference

| Security Layer | Implementation |
|----------------|----------------|
| Network | pg_hba.conf, SSL |
| Authentication | Passwords, certificates |
| Authorization | GRANT, REVOKE |
| Row-Level | RLS policies |
| Column | pgcrypto encryption |

## Related
- pg-basics - Configuration
- pg-administration agent

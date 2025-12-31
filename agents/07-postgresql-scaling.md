---
name: 07-postgresql-scaling
description: PostgreSQL scaling specialist - partitioning, sharding, high availability, connection pooling
version: "3.0.0"
model: sonnet
tools: Read, Write, Bash, Glob, Grep
sasmp_version: "1.3.0"
eqhm_enabled: true
skills:
  - postgresql-backup
  - postgresql-advanced-queries
  - postgresql-replication
  - postgresql-plpgsql
  - postgresql-performance
  - postgresql-extensions
  - postgresql-fundamentals
  - postgresql-monitoring
  - postgresql-json
  - postgresql-scaling
  - postgresql-docker
  - postgresql-admin
triggers:
  - "postgresql postgresql"
  - "postgresql"
  - "postgres"
context_tokens: 8192
max_iterations: 20
---

# PostgreSQL Scaling Agent

> Production-grade horizontal and vertical scaling specialist

## Role & Responsibilities

| Boundary | Scope |
|----------|-------|
| **Primary** | Partitioning, connection pooling, read replicas |
| **Secondary** | Sharding strategies, caching |
| **Out of Scope** | Basic queries, security setup |

## Input Schema

```yaml
input:
  type: object
  required: [scaling_goal]
  properties:
    scaling_goal:
      enum: [partition_table, setup_pooling, configure_ha, design_sharding, add_replica]
    current_metrics:
      type: object
      properties:
        table_size_gb: { type: number }
        rows_millions: { type: number }
        connections_peak: { type: integer }
        read_write_ratio: { type: string }
    constraints:
      type: array
      items: { type: string }
```

## Output Schema

```yaml
output:
  type: object
  properties:
    architecture:
      type: string
      description: Scaling solution diagram
    implementation_steps:
      type: array
    configuration:
      type: object
    rollback_plan:
      type: string
```

## Table Partitioning

### Range Partitioning (Time-Series)
```sql
-- Create partitioned table
CREATE TABLE events (
    id BIGINT GENERATED ALWAYS AS IDENTITY,
    event_type TEXT NOT NULL,
    data JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE events_2024_q1 PARTITION OF events
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');
CREATE TABLE events_2024_q2 PARTITION OF events
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');
CREATE TABLE events_2024_q3 PARTITION OF events
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');
CREATE TABLE events_2024_q4 PARTITION OF events
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Create default partition for overflow
CREATE TABLE events_default PARTITION OF events DEFAULT;

-- Create indexes on parent (automatically created on children)
CREATE INDEX idx_events_created ON events (created_at);
CREATE INDEX idx_events_type ON events (event_type);

-- Auto-create partitions (pg_partman extension)
CREATE EXTENSION pg_partman;
SELECT create_parent('public.events', 'created_at', 'native', 'monthly');
```

### List Partitioning (Category-Based)
```sql
CREATE TABLE orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY,
    region TEXT NOT NULL,
    total NUMERIC,
    created_at TIMESTAMPTZ DEFAULT NOW()
) PARTITION BY LIST (region);

CREATE TABLE orders_us PARTITION OF orders FOR VALUES IN ('US', 'CA');
CREATE TABLE orders_eu PARTITION OF orders FOR VALUES IN ('UK', 'DE', 'FR');
CREATE TABLE orders_asia PARTITION OF orders FOR VALUES IN ('JP', 'CN', 'KR');
```

### Hash Partitioning (Even Distribution)
```sql
CREATE TABLE user_sessions (
    id BIGINT,
    user_id BIGINT NOT NULL,
    data JSONB
) PARTITION BY HASH (user_id);

CREATE TABLE user_sessions_0 PARTITION OF user_sessions
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE user_sessions_1 PARTITION OF user_sessions
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE user_sessions_2 PARTITION OF user_sessions
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE user_sessions_3 PARTITION OF user_sessions
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);
```

## Connection Pooling

### PgBouncer Configuration
```ini
# /etc/pgbouncer/pgbouncer.ini

[databases]
appdb = host=localhost port=5432 dbname=appdb

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 6432
auth_type = scram-sha-256
auth_file = /etc/pgbouncer/userlist.txt

# Pool settings
pool_mode = transaction  # Best for web apps
default_pool_size = 20
max_client_conn = 1000
min_pool_size = 5
reserve_pool_size = 5
reserve_pool_timeout = 3

# Timeouts
server_idle_timeout = 600
server_lifetime = 3600
query_timeout = 300

# Logging
log_connections = 1
log_disconnections = 1
log_pooler_errors = 1
stats_period = 60
```

### Pool Mode Selection
| Mode | Use Case | Session State |
|------|----------|---------------|
| `session` | Long-lived connections | Preserved |
| `transaction` | Web applications (recommended) | Reset per txn |
| `statement` | Simple queries only | Reset per stmt |

## High Availability with Patroni

### Patroni Architecture
```yaml
# /etc/patroni/patroni.yml
scope: postgres-cluster
name: node1

restapi:
  listen: 0.0.0.0:8008
  connect_address: node1:8008

etcd3:
  hosts:
    - etcd1:2379
    - etcd2:2379
    - etcd3:2379

bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 10
    maximum_lag_on_failover: 1048576
    postgresql:
      use_pg_rewind: true
      parameters:
        max_connections: 200
        shared_buffers: 4GB
        wal_level: replica
        max_wal_senders: 10
        max_replication_slots: 10
        hot_standby: on

postgresql:
  listen: 0.0.0.0:5432
  connect_address: node1:5432
  data_dir: /var/lib/postgresql/data
  authentication:
    replication:
      username: replicator
      password: secret
    superuser:
      username: postgres
      password: secret

tags:
  nofailover: false
  noloadbalance: false
  clonefrom: false
```

### HAProxy for Load Balancing
```
# /etc/haproxy/haproxy.cfg
frontend postgresql_front
    bind *:5000
    mode tcp
    default_backend postgresql_primary

frontend postgresql_read
    bind *:5001
    mode tcp
    default_backend postgresql_replicas

backend postgresql_primary
    mode tcp
    option httpchk GET /primary
    http-check expect status 200
    server node1 node1:5432 check port 8008
    server node2 node2:5432 check port 8008
    server node3 node3:5432 check port 8008

backend postgresql_replicas
    mode tcp
    balance roundrobin
    option httpchk GET /replica
    http-check expect status 200
    server node1 node1:5432 check port 8008
    server node2 node2:5432 check port 8008
    server node3 node3:5432 check port 8008
```

## Read Replicas

### Streaming Replication Setup
```sql
-- On Primary: Create replication user
CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'secret';

-- On Primary: postgresql.conf
wal_level = replica
max_wal_senders = 10
max_replication_slots = 10
wal_keep_size = 1GB

-- On Primary: Create replication slot
SELECT pg_create_physical_replication_slot('replica1');

-- On Replica: pg_basebackup
pg_basebackup -h primary -D /var/lib/postgresql/data -U replicator -v -P -R

-- On Replica: recovery settings in postgresql.auto.conf
primary_conninfo = 'host=primary port=5432 user=replicator password=secret'
primary_slot_name = 'replica1'
```

### Monitor Replication Lag
```sql
-- On Primary
SELECT
    client_addr,
    state,
    sent_lsn,
    write_lsn,
    flush_lsn,
    replay_lsn,
    pg_size_pretty(pg_wal_lsn_diff(sent_lsn, replay_lsn)) as lag
FROM pg_stat_replication;

-- On Replica
SELECT
    pg_is_in_recovery() as is_replica,
    pg_last_wal_receive_lsn() as received,
    pg_last_wal_replay_lsn() as replayed,
    pg_last_xact_replay_timestamp() as last_replay_time;
```

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| `40001` | Serialization failure | Retry transaction |
| `57P01` | Admin shutdown | Reconnect with backoff |
| `08006` | Connection failure | Failover to replica |
| `53300` | Too many connections | Use connection pooler |

## Troubleshooting

### Decision Tree
```
Connection Issues?
├─ Check PgBouncer: SHOW POOLS;
├─ Check max_connections
├─ Monitor pg_stat_activity
└─ Review connection timeout settings

Replication Lag?
├─ Check network latency
├─ Verify WAL sender active
├─ Check disk I/O on replica
└─ Consider synchronous_commit

Partition Not Used?
├─ Check enable_partition_pruning = on
├─ Verify constraint_exclusion
├─ Review WHERE clause matches partition key
└─ Check EXPLAIN for partition scans
```

### Debug Checklist
- [ ] PgBouncer stats: `SHOW STATS; SHOW POOLS;`
- [ ] Replica lag: `SELECT * FROM pg_stat_replication;`
- [ ] Partition pruning: `EXPLAIN SELECT ... WHERE partition_key = ...`
- [ ] Connection count: `SELECT count(*) FROM pg_stat_activity;`

## Usage

```
Task(subagent_type="postgresql:07-postgresql-scaling")
```

## References

- [Table Partitioning](https://www.postgresql.org/docs/16/ddl-partitioning.html)
- [High Availability](https://www.postgresql.org/docs/16/high-availability.html)
- [PgBouncer](https://www.pgbouncer.org/)
- [Patroni](https://patroni.readthedocs.io/)

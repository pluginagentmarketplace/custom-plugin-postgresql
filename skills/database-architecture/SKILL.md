---
name: database-architecture
description: Master database design, SQL optimization, system architecture, and design patterns. Learn PostgreSQL, MongoDB, Redis, and distributed system design.
sasmp_version: "1.3.0"
bonded_agent: 01-frontend-web
bond_type: PRIMARY_BOND
---

# Database & System Architecture

## Quick Start

### SQL Fundamentals
```sql
-- Create table with constraints
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT email_format CHECK (email LIKE '%@%.%')
);

-- Create index
CREATE INDEX idx_users_email ON users(email);

-- Query with JOIN
SELECT u.name, COUNT(p.id) as post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) > 5
ORDER BY post_count DESC;
```

### Database Relationships
```sql
-- One-to-Many
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    title VARCHAR(255),
    content TEXT
);

-- Many-to-Many
CREATE TABLE user_roles (
    user_id INTEGER REFERENCES users(id),
    role_id INTEGER REFERENCES roles(id),
    PRIMARY KEY (user_id, role_id)
);
```

### MongoDB (NoSQL)
```javascript
// Insert document
db.users.insertOne({
    name: "John",
    email: "john@example.com",
    posts: [
        { id: 1, title: "Post 1" },
        { id: 2, title: "Post 2" }
    ]
});

// Query with aggregation
db.users.aggregate([
    { $match: { created_at: { $gte: new Date("2024-01-01") } } },
    { $group: { _id: "$email", count: { $sum: 1 } } },
    { $sort: { count: -1 } }
]);
```

### Redis Operations
```javascript
// String operations
SET user:1:email "john@example.com"
GET user:1:email

// List operations
LPUSH messages:1 "Hello"
LPUSH messages:1 "World"
LRANGE messages:1 0 -1

// Hash operations
HSET user:1 name "John" email "john@example.com"
HGETALL user:1

// Set operations
SADD tags:post:1 "nodejs" "javascript" "web"
SMEMBERS tags:post:1
```

### System Design Pattern
```
User -> API Gateway -> Load Balancer
       -> Service 1 (Cache: Redis)
       -> Service 2 (Database: PostgreSQL)
       -> Queue (RabbitMQ)
       -> Consumer Service
```

## Core Concepts

### 1. Relational Databases
- Normalization (1NF, 2NF, 3NF, BCNF)
- Primary and foreign keys
- Indexes and query optimization
- Transactions (ACID properties)
- Locking and isolation levels
- Replication and failover

### 2. NoSQL Databases
- Document-oriented (MongoDB)
- Key-value stores (Redis)
- Graph databases (Neo4j)
- Time-series databases
- Eventual consistency
- Sharding strategies

### 3. Query Optimization
- Query plans and EXPLAIN
- Index design
- Denormalization
- Caching strategies
- Batch processing
- Pagination patterns

### 4. System Design Patterns
- Microservices architecture
- Event-driven systems
- CQRS pattern
- Saga pattern
- API gateway
- Service mesh

### 5. Scalability
- Horizontal scaling
- Database sharding
- Read replicas
- Caching layers
- Load balancing
- Connection pooling

## Tools & Technologies

### Relational Databases
- **PostgreSQL**: Advanced features, reliability
- **MySQL**: Widespread, good performance
- **SQL Server**: Enterprise, Windows integration

### NoSQL Databases
- **MongoDB**: Document storage
- **Redis**: In-memory cache
- **Cassandra**: Distributed storage
- **Neo4j**: Graph database

### Tools
- **pgAdmin**: PostgreSQL management
- **MongoDB Atlas**: Cloud MongoDB
- **Redis CLI**: Command-line client
- **DBeaver**: Database IDE

## Design Patterns

### API Patterns
- REST conventions
- GraphQL schema design
- Pagination (offset, cursor-based)
- Rate limiting

### Database Patterns
- Repository pattern
- DAO pattern
- Lazy loading
- Eager loading
- Query object pattern

### Architecture Patterns
- Strangler fig pattern
- Circuit breaker
- Bulkhead pattern
- Retry pattern

## Projects to Build

1. **Relational Database Design**
   - Complex schema
   - Proper relationships
   - Optimized queries

2. **NoSQL Data Model**
   - Document structure
   - Embedding vs referencing
   - Aggregation pipeline

3. **Caching Layer**
   - Redis implementation
   - Cache invalidation
   - Performance improvement

4. **System Architecture**
   - Multiple services
   - API gateway
   - Database replication

5. **Search System**
   - Elasticsearch
   - Full-text search
   - Faceted search

## Interview Tips

### Common Database Questions
- Explain database normalization
- What is an index and how does it work?
- Difference between SQL and NoSQL
- Explain ACID properties
- How would you handle high concurrency?

### System Design
- Design user management system
- Build scalable database
- Handle millions of requests
- Design event streaming system

## Best Practices

- Proper indexing strategy
- Data validation at application level
- Backup and recovery planning
- Monitoring and alerting
- Security (encryption, access control)
- Documentation
- Version control for schema

## Advanced Topics

- Database sharding
- Distributed transactions
- Event sourcing
- Data warehouse design
- Column-oriented databases
- Time-series optimization
- Graph algorithms

## Performance Optimization

- Query optimization
- Connection pooling
- Batch operations
- Denormalization where needed
- Caching strategies
- Partitioning
- Replication strategies

---

For detailed information, visit the **PostgreSQL DBA** roadmap at https://roadmap.sh/postgresql-dba or **System Design** at https://roadmap.sh/system-design

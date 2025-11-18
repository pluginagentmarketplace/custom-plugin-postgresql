---
name: backend-api
description: Master backend development with Node.js, Python, Java, Go, and PHP. Learn API design, database optimization, authentication, microservices, and server-side best practices.
---

# Backend & API Development

## Quick Start

### Node.js with Express
```javascript
const express = require('express');
const app = express();

app.use(express.json());

// GET endpoint
app.get('/api/users/:id', (req, res) => {
    const userId = req.params.id;
    // Fetch from database
    res.json({ id: userId, name: 'John' });
});

// POST endpoint
app.post('/api/users', (req, res) => {
    const { name, email } = req.body;
    // Save to database
    res.status(201).json({ id: 1, name, email });
});

app.listen(3000, () => console.log('Server running'));
```

### Python with FastAPI
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    name: str
    email: str

@app.get('/api/users/{user_id}')
async def get_user(user_id: int):
    return {'id': user_id, 'name': 'John'}

@app.post('/api/users')
async def create_user(user: User):
    return {'id': 1, **user.dict()}
```

### SQL Database Operations
```sql
-- Create table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Query
SELECT * FROM users WHERE email = 'john@example.com';

-- Index for performance
CREATE INDEX idx_users_email ON users(email);
```

### REST API Design
```
GET    /api/users              # List all users
POST   /api/users              # Create user
GET    /api/users/{id}         # Get specific user
PUT    /api/users/{id}         # Update user
DELETE /api/users/{id}         # Delete user
```

### GraphQL Query
```graphql
query {
    users(limit: 10) {
        id
        name
        email
        posts {
            id
            title
        }
    }
}
```

## Core Concepts

### 1. HTTP & REST
- HTTP methods (GET, POST, PUT, DELETE)
- Status codes (200, 201, 400, 401, 404, 500)
- Headers and content negotiation
- Caching strategies
- CORS handling

### 2. Authentication & Authorization
- JWT tokens
- OAuth 2.0
- Session management
- Role-based access control (RBAC)
- API keys

### 3. Database Design
- Normalization principles
- Foreign keys and relationships
- Indexing strategies
- Query optimization
- Transaction management

### 4. API Design
- RESTful conventions
- GraphQL fundamentals
- Version management
- Rate limiting
- Error handling

### 5. Performance
- Database query optimization
- Caching (Redis, Memcached)
- Load balancing
- Async processing
- Connection pooling

## Frameworks & Tools

### Backend Frameworks
- **Node.js**: Express, NestJS, Fastify
- **Python**: Django, FastAPI, Flask
- **Java**: Spring Boot, Quarkus
- **Go**: Gin, Echo
- **PHP**: Laravel, Symfony

### Databases
- **Relational**: PostgreSQL, MySQL, SQL Server
- **NoSQL**: MongoDB, Cassandra
- **Cache**: Redis, Memcached
- **Search**: Elasticsearch

### API Tools
- Postman / Insomnia
- GraphQL Playground
- API documentation (Swagger/OpenAPI)

## Common Patterns

### Middleware Pattern
- Authentication middleware
- Logging middleware
- Error handling
- Request validation

### Repository Pattern
- Database abstraction
- Query optimization
- Transaction handling
- Data access layer

### Service Layer
- Business logic isolation
- Dependency injection
- Testing isolation
- Code reusability

## Projects to Build

1. **REST API with Authentication**
   - User registration/login
   - JWT tokens
   - Protected routes

2. **E-commerce Backend**
   - Product catalog
   - Shopping cart
   - Order management
   - Payment integration

3. **Real-time Chat API**
   - WebSocket support
   - Message persistence
   - User presence
   - Notifications

4. **GraphQL Server**
   - Query and mutation
   - Resolvers
   - Authentication
   - Real-time subscriptions

5. **Microservices Architecture**
   - Service communication
   - API Gateway
   - Message queues
   - Service discovery

## Interview Tips

### Common Backend Questions
- Explain RESTful API design
- How would you design a database schema?
- What is an N+1 query problem?
- Explain JWT authentication
- How do you handle concurrency?

### System Design
- Scale a social media backend
- Design a payment system
- Build a real-time notification system
- Create a recommendation engine

## Security Best Practices

- Input validation and sanitization
- SQL injection prevention
- CORS configuration
- Rate limiting
- Environment variables for secrets
- HTTPS enforcement
- Regular security updates

## Advanced Topics

- Event-driven architecture
- CQRS pattern
- Database replication
- Distributed transactions
- Message queues (RabbitMQ, Kafka)
- Microservices patterns
- API versioning strategies

## Performance Optimization

- Query optimization
- Caching strategies
- Compression
- CDN for static assets
- Load balancing
- Database indexing
- Connection pooling

---

For detailed information, visit the **Backend Developer** roadmap at https://roadmap.sh/backend

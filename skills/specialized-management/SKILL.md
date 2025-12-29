---
name: specialized-management
description: Master full-stack development, QA testing, engineering management, product management, and specialized technical leadership roles.
sasmp_version: "1.3.0"
bonded_agent: 01-frontend-web
bond_type: PRIMARY_BOND
---

# Specialized & Management Skills

## Quick Start

### Full-Stack Development
```javascript
// Frontend (React)
import { useState } from 'react';

function TodoApp() {
    const [todos, setTodos] = useState([]);

    const addTodo = async (title) => {
        // Call backend API
        const response = await fetch('/api/todos', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ title })
        });
        const newTodo = await response.json();
        setTodos([...todos, newTodo]);
    };

    return (
        <div>
            {todos.map(todo => <div key={todo.id}>{todo.title}</div>)}
        </div>
    );
}
```

### Backend (Node.js)
```javascript
// Express API endpoint
app.post('/api/todos', async (req, res) => {
    const { title } = req.body;

    // Validate
    if (!title) return res.status(400).json({ error: 'Title required' });

    // Save to database
    const todo = await db.todos.create({ title });

    res.status(201).json(todo);
});
```

### QA Test Case
```javascript
// Jest unit test
describe('Todo functionality', () => {
    test('should add todo successfully', () => {
        const { getByText, getByPlaceholder } = render(<TodoApp />);
        const input = getByPlaceholderText('Enter todo');
        const button = getByText('Add');

        fireEvent.change(input, { target: { value: 'Test todo' } });
        fireEvent.click(button);

        expect(getByText('Test todo')).toBeInTheDocument();
    });

    test('should not add empty todo', () => {
        const { getByText } = render(<TodoApp />);
        const button = getByText('Add');

        fireEvent.click(button);

        expect(getByText('Title required')).toBeInTheDocument();
    });
});
```

## Core Concepts

### 1. Full-Stack Development
- Frontend and backend integration
- Database to UI architecture
- API design and consumption
- State management across layers
- Deployment pipeline
- Debugging across layers

### 2. QA & Testing
- **Unit Testing**: Test individual functions
- **Integration Testing**: Test components together
- **E2E Testing**: Test complete workflows
- **Performance Testing**: Load and stress tests
- **Security Testing**: Vulnerability scanning
- **Accessibility Testing**: WCAG compliance

### 3. Engineering Management
- Team leadership
- Career development
- Code review culture
- Hiring and evaluation
- Technical decision making
- Conflict resolution
- Mentoring

### 4. Product Management
- Product strategy
- User research
- Feature prioritization
- Roadmap planning
- Metrics and KPIs
- Stakeholder communication
- Release management

### 5. UX/Design
- User research
- Wireframing
- Prototyping
- Accessibility (a11y)
- Design systems
- Interaction design
- Usability testing

### 6. Technical Writing
- API documentation
- User guides
- Architecture docs
- Blog posts
- README files
- Code comments
- Video scripts

### 7. Developer Relations
- Community management
- Content creation
- Event management
- Developer advocacy
- Technical support
- Feedback collection

## Testing Frameworks

### Frontend Testing
- **Jest**: Unit testing framework
- **React Testing Library**: Component testing
- **Cypress**: E2E testing
- **Playwright**: Browser automation
- **Lighthouse**: Performance testing

### Backend Testing
- **Jest**: Node.js testing
- **Mocha**: Test framework
- **Chai**: Assertion library
- **Supertest**: HTTP testing
- **Artillery**: Load testing

### Mobile Testing
- **XCTest**: iOS testing
- **Espresso**: Android testing
- **Detox**: E2E mobile
- **Appium**: Cross-platform

## Management Frameworks

### Leadership
- 1-on-1 meetings
- Feedback culture
- Team retrospectives
- Planning processes
- Performance evaluations
- Succession planning

### Product Management
- OKR (Objectives and Key Results)
- Agile/Scrum methodology
- User story mapping
- Release planning
- Stakeholder engagement
- Analytics dashboard

### Design System
- Component library
- Design tokens
- Style guide
- Documentation
- Version control
- Accessibility standards

## Projects to Build

### Full-Stack
1. **Complete CRUD Application**
   - Frontend interface
   - Backend API
   - Database
   - Deployment

2. **Real-time Application**
   - WebSocket integration
   - State synchronization
   - Performance optimization

### QA
1. **Test Automation Suite**
   - Unit tests
   - Integration tests
   - E2E tests
   - CI/CD integration

2. **Performance Testing**
   - Load test setup
   - Performance reporting
   - Optimization recommendations

### Management
1. **Team Development Plan**
   - Growth paths
   - Skill matrix
   - Training plans

2. **Product Roadmap**
   - Strategy document
   - Feature breakdown
   - Timeline planning

## Interview Tips

### Full-Stack Developer
- Design complete system end-to-end
- Handle edge cases
- Discuss deployment
- Explain technology choices

### Engineering Manager
- Team dynamics scenarios
- Technical decision making
- Conflict resolution
- Career development
- Mentoring approach

### Product Manager
- Feature prioritization
- User needs analysis
- Go-to-market strategy
- Metrics definition
- Roadmap planning

## Best Practices

### Development
- Code review standards
- Testing coverage (80%+)
- Documentation
- Performance monitoring
- Security checks
- Version control

### Testing
- Test early, test often
- Test behavior, not implementation
- Meaningful assertions
- Test isolation
- Clear test names
- CI/CD integration

### Management
- Clear communication
- Psychological safety
- Data-driven decisions
- Transparent processes
- Continuous feedback
- Growth mindset

## Advanced Topics

### Architecture
- Full-stack patterns
- Error handling
- Monitoring and logging
- Security considerations
- Scalability planning

### Leadership
- Organizational design
- Cross-functional alignment
- Change management
- Building culture
- Remote team management

### Product Strategy
- Market analysis
- Competitive advantage
- User segmentation
- Pricing strategy
- Expansion opportunities

## Tools & Technologies

### Development
- VS Code, IDEs
- Git, GitHub
- Docker, Kubernetes
- CI/CD tools

### Testing
- Testing frameworks
- Coverage tools
- Monitoring platforms
- Analytics tools

### Management
- Jira, Linear
- Figma, Sketch
- Slack, Teams
- Analytics platforms

---

For detailed information, visit the **Full Stack Developer** roadmap at https://roadmap.sh/full-stack or **Engineering Manager** at https://roadmap.sh/engineering-manager

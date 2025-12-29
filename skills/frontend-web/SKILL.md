---
name: frontend-web
description: Master frontend development with HTML, CSS, JavaScript, TypeScript, and modern frameworks like React, Vue, and Angular. Covers web standards, responsive design, accessibility, and performance optimization.
sasmp_version: "1.3.0"
bonded_agent: 01-frontend-web
bond_type: PRIMARY_BOND
---

# Frontend & Web Development

## Quick Start

### Essential Tools & Environment
```bash
# Node.js and npm for development
node --version
npm --version

# Create React app
npx create-react-app my-app

# Or Next.js
npx create-next-app@latest my-app
```

### HTML Fundamentals
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Web Page</title>
</head>
<body>
    <header>
        <nav>Navigation</nav>
    </header>
    <main>Content</main>
    <footer>Footer</footer>
</body>
</html>
```

### Modern CSS
```css
/* Grid Layout */
.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

/* Flexbox */
.flex-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* CSS Variables */
:root {
    --primary-color: #0066cc;
    --font-size: 16px;
}
```

### Modern JavaScript (ES6+)
```javascript
// Arrow functions
const greet = (name) => `Hello, ${name}!`;

// Destructuring
const { name, age } = person;

// Promises and async/await
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
    }
}
```

### React Fundamentals
```javascript
import React, { useState } from 'react';

function Counter() {
    const [count, setCount] = useState(0);

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={() => setCount(count + 1)}>
                Increment
            </button>
        </div>
    );
}

export default Counter;
```

### TypeScript Basics
```typescript
interface User {
    id: number;
    name: string;
    email: string;
}

function getUser(id: number): User {
    return { id, name: 'John', email: 'john@example.com' };
}
```

## Core Concepts

### 1. Web Standards
- HTML5 semantic elements
- WCAG accessibility guidelines
- SEO best practices
- Web APIs (DOM, Fetch, Storage)

### 2. Responsive Design
- Mobile-first approach
- Media queries
- Viewport configuration
- Flexible layouts
- Responsive images

### 3. Performance Optimization
- Code splitting
- Lazy loading
- Image optimization
- Minification and compression
- Critical rendering path

### 4. State Management
- Props drilling
- Context API (React)
- Redux / Vuex
- Zustand / Pinia
- Recoil

### 5. Testing
- Unit testing (Jest, Vitest)
- Component testing (React Testing Library)
- E2E testing (Cypress, Playwright)
- Accessibility testing

## Common Resources

### Learning Resources
- MDN Web Docs (HTML, CSS, JavaScript)
- React Documentation
- CSS-Tricks blog
- Web.dev (Google)
- Wesbos courses

### Developer Tools
- Chrome DevTools
- VS Code
- ESLint & Prettier
- Webpack / Vite
- Storybook

### Frameworks & Libraries
- **React**: Facebook's component library
- **Vue**: Progressive framework
- **Angular**: Full-featured framework
- **Svelte**: Compiler approach
- **Next.js**: React meta-framework

## Projects to Build

1. **Personal Portfolio Website**
   - Responsive design
   - Smooth scrolling
   - Contact form

2. **E-commerce Product Page**
   - Filter functionality
   - Shopping cart
   - Product reviews

3. **Real-time Chat Application**
   - WebSocket integration
   - Message history
   - User presence

4. **Progressive Web App (PWA)**
   - Service workers
   - Offline support
   - Install prompt

5. **Social Media Dashboard**
   - API integration
   - Data visualization
   - User interactions

## Interview Tips

### Frontend Interview Questions
- Explain the React component lifecycle
- What is the virtual DOM?
- Difference between var, let, const
- Explain CSS specificity
- How does async/await work?

### Coding Challenges
- Build a todo list app
- Create a form with validation
- Implement debouncing/throttling
- Build a state management system
- Create a custom hook

## Advanced Topics

- Web Components and Custom Elements
- WebAssembly (WASM)
- Advanced browser APIs
- Cross-origin resource sharing (CORS)
- Content Security Policy (CSP)
- Web Workers and Threading

## Next Steps

1. Master one framework deeply (React recommended)
2. Learn TypeScript for type safety
3. Master CSS and responsive design
4. Learn testing frameworks
5. Build full-stack applications
6. Contribute to open-source projects

---

For more detailed information, visit the **Frontend Developer** roadmap at https://roadmap.sh/frontend

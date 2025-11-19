# ultrathink Style Guide

This document provides guidelines for maintaining consistency across the ultrathink plugin.

## 📄 Document Structure

### Agent Files (`.md`)
```markdown
---
description: Clear, concise description
domain: Category
tier: specialized-agent
complexity: low|high|very-high
capabilities:
  - Capability 1
  - Capability 2
---

# 🎨 Agent Name

## 📋 Overview
[2-3 sentence overview]

## 🎯 Covered Roadmaps (X Paths)
[Table with roadmaps]

## 🔑 Key Areas of Expertise
[8-12 main expertise areas with sub-points]

## 📚 Learning Paths
[Beginner, Intermediate, Advanced, Expert paths]

## 🛠️ Essential Tech Stack
[Organized by category]

## 💼 Career Prospects
[Job market, salary, progression]

## 🎓 Interview Preparation
[Questions and scenarios]

## 🔗 Related Paths
[Connected learning paths]

**[Motivational closing line]**
```

### Skill Files (`SKILL.md`)
```markdown
---
name: skill-id
description: What this skill covers and when to use it
---

# Skill Name

## Quick Start
[Code example with explanation]

## Core Concepts
[3-5 main concept areas]

## Tools & Technologies
[Organized list of tools]

## Common Patterns
[Design patterns and best practices]

## Projects to Build
[5-7 project ideas]

## Resources
[Free and paid learning resources]

## Next Steps
[Progression path]
```

### Command Files (`.md`)
```markdown
# Command Name

## Overview
[Brief description]

## Command Usage
[How to use]

## Features
[Main features]

## Examples
[Usage examples]

## Tips
[Helpful tips]

## See Also
[Related commands]
```

## 📝 Writing Conventions

### Tone & Voice
- **Professional yet friendly**: Avoid overly casual language
- **Clear and concise**: Remove unnecessary words
- **Action-oriented**: Use active voice
- **Encouraging**: Support learners at all levels

### Structure
- Use headers appropriately (h1 for titles, h2 for sections, h3 for subsections)
- Keep paragraphs short (2-3 sentences max)
- Use bullet points for lists
- Use numbered lists only for ordered steps

### Formatting
| Element | Format | Example |
|---------|--------|---------|
| Tools/Tech | **bold** | **React**, **Python** |
| Code | `backticks` | `useState`, `props` |
| Emphasis | *italic* | *important*, *note* |
| Quotes | > prefix | > Remember to practice |
| Links | [text](url) | [MDN Web Docs](https://mdn.org) |

### Code Examples
```javascript
// Use appropriate language identifier
// Keep examples focused and clear
// Include comments for non-obvious code
const example = () => {
  return "Clear, working code";
};
```

### Lists
Good:
- Item one
- Item two
- Item three

Avoid:
- Item one,
- Item two,
- Item three.

## 🎨 Emoji Usage

Use emojis for visual hierarchy:
- **Agents**: 🎨 Frontend, 🔧 Backend, ☁️ DevOps, etc.
- **Sections**: 📋 Overview, 🎯 Goals, 🔑 Key, 📚 Learning, etc.
- **Status**: ✅ Completed, ⏳ In Progress, ⭐ Important
- **Callouts**: 💡 Tip, ⚠️ Warning, 🚀 Quick Start

## 💻 Code Style

### JavaScript/TypeScript
```javascript
// Use arrow functions
const getName = (user) => user.name;

// Use const by default
const API_KEY = "key";

// Use template literals
const message = `Hello, ${name}!`;

// Descriptive names
const isUserAuthenticated = false;
```

### Python
```python
# Use snake_case
def get_user_by_id(user_id):
    return User.query.get(user_id)

# Docstrings for functions
def calculate_total(items):
    """Calculate total cost of items."""
    return sum(item.price for item in items)

# Type hints
def process_data(data: list) -> dict:
    pass
```

## 📊 Tables

Use clean, readable tables:

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Left     | Center   | Right    |
| Data     | Data     | Data     |
```

Good table:
| Level | Duration | Commitment |
|-------|----------|------------|
| Beginner | 3-4 months | 15-20h/week |
| Intermediate | 3-4 months | 10-15h/week |
| Advanced | 2-3 months | 8-12h/week |

## 🔗 Links

- Link to internal resources: `[text](relative/path/file.md)`
- Link to external resources: `[text](https://example.com)`
- Always use descriptive link text, not "click here"

Good: [Learn more about React hooks](https://react.dev)
Bad: [Click here](https://react.dev)

## 📋 Checklist Standards

For assessment lists:
```markdown
- ✅ Skill 1 - Complete
- ⏳ Skill 2 - In Progress
- 📝 Skill 3 - Not Started
```

For requirement lists:
```markdown
- [ ] Requirement 1
- [x] Requirement 2 (Completed)
- [ ] Requirement 3
```

## 🎯 Content Guidelines

### Length
- **Overview**: 2-3 sentences
- **Section**: 3-5 bullet points
- **Example code**: 5-15 lines
- **Projects**: 3-5 lines description

### Accuracy
- Verify all code examples work
- Check external links are valid
- Confirm tool versions are current
- Review for technical accuracy

### Completeness
- Include beginner and advanced perspectives
- Provide multiple examples
- Link to resources
- Suggest next steps

## 🔄 Review Checklist

Before submitting content:
- [ ] Follows this style guide
- [ ] No spelling or grammar errors
- [ ] Links are valid and relevant
- [ ] Code examples are tested
- [ ] Tone is appropriate
- [ ] Structure is logical
- [ ] Formatting is consistent
- [ ] Emojis used appropriately

## 🚀 Quick Start Template

```markdown
---
description: [Clear description]
domain: [Category]
complexity: [low|high|very-high]
---

# [Title with emoji]

## Overview
[2-3 sentences]

## Quick Start
```code block```

## Key Topics
- Topic 1
- Topic 2

## Resources
- Resource 1
- Resource 2

---

**[Closing encouragement]**
```

## 📞 Questions?

For style guide questions:
1. Check existing similar content
2. Review examples in the codebase
3. Open a GitHub issue
4. Contact maintainers

---

**Last Updated**: November 18, 2024
**Version**: 1.0
**Status**: Active

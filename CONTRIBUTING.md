# Contributing to ultrathink

Thank you for your interest in contributing to **ultrathink**! We welcome contributions from developers of all levels. This document provides guidelines for contributing.

## 🎯 Code of Conduct

- Be respectful and inclusive
- No harassment or discrimination
- Welcome diverse perspectives
- Focus on constructive feedback
- Maintain professional communication

## 🚀 Getting Started

### Prerequisites
- Git and GitHub account
- Claude Code environment
- Basic markdown knowledge
- Familiarity with plugin structure

### Development Setup

```bash
# Clone the repository
git clone https://github.com/pluginagentmarketplace/custom-plugin-postgresql
cd custom-plugin-postgresql

# Create feature branch
git checkout -b feature/your-feature-name

# Make your changes
# Test locally in Claude Code

# Commit and push
git add .
git commit -m "feat: describe your changes"
git push origin feature/your-feature-name
```

## 📋 Types of Contributions

### 1. Content Improvements
- **Agent Enhancements**: Add more details, examples, or learning resources
- **Skill Expansions**: Improve SKILL.md files with advanced topics
- **Command Enhancements**: Add new commands or improve existing ones
- **Project Ideas**: Add hands-on project ideas to `/projects`

### 2. Bug Fixes
- Report issues through GitHub Issues
- Include reproduction steps
- Provide error messages and logs
- Submit PR with fix

### 3. New Features
- Suggest features in GitHub Discussions
- Discuss implementation approach
- Follow plugin architecture
- Add tests and documentation

### 4. Documentation
- Improve README files
- Add code examples
- Create tutorials or guides
- Fix typos and grammar

## 📝 Contribution Guidelines

### For Agent Files

```yaml
---
description: Clear, concise description
domain: Agent domain/category
tier: specialized-agent
complexity: low|high|very-high
capabilities:
  - Capability 1
  - Capability 2
---

# Agent Name

## Overview
[Detailed overview]

## Key Areas
[Main expertise areas]

## Learning Paths
[Organized by level]

## Tech Stack
[Tools and technologies]

## Career Prospects
[Job market and opportunities]
```

### For Skill Files

SKILL.md should include:
- Quick start section with examples
- Core concepts explanation
- Tools and technologies
- Code examples (with syntax highlighting)
- Best practices
- Common patterns
- Resources and references

### For Commands

Command markdown files should include:
- Clear description
- Usage examples
- Interactive workflows
- Feature lists
- Tips and tricks

### Code Quality Standards

- **Clarity**: Code examples should be clear and well-commented
- **Accuracy**: Ensure all information is current and correct
- **Completeness**: Provide comprehensive coverage of topics
- **Testing**: Verify examples work correctly
- **Formatting**: Follow markdown conventions

## 🔄 PR Process

### Step 1: Create PR
```bash
git push origin feature/your-feature-name
```

### Step 2: Fill PR Template
```markdown
## Description
Brief summary of changes

## Type
- [ ] Content improvement
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation

## Changes
- Change 1
- Change 2

## Testing
How to test this change?

## Checklist
- [ ] Content is accurate
- [ ] Follows style guide
- [ ] No spelling errors
- [ ] Links are valid
```

### Step 3: Review Process
- Reviewers will check for:
  - Technical accuracy
  - Consistency with existing content
  - Quality and clarity
  - Proper formatting
- Address feedback constructively
- Update PR as needed

### Step 4: Merge
Once approved, maintainers will merge to main branch.

## 📚 Content Style Guide

### Writing Style
- **Clear & Concise**: Use simple language
- **Active Voice**: Prefer "Learn Python" over "Python can be learned"
- **Present Tense**: Use current descriptions
- **Professional**: Maintain technical accuracy

### Formatting
- Use **bold** for emphasis
- Use `code` for technical terms
- Use > for quotes
- Use numbered lists for steps
- Use bullet points for items

### Examples

Good example:
```javascript
// Clear, concise, functional
const greet = (name) => `Hello, ${name}!`;
```

Poor example:
```javascript
// Some comment
const greet = (name) => {
  let greeting = "Hello, " + name + "!";
  return greeting;
};
```

## 🐛 Reporting Issues

### Bug Report Template
```markdown
**Describe the bug**
Brief description

**Steps to reproduce**
1. Step 1
2. Step 2

**Expected behavior**
What should happen

**Actual behavior**
What actually happens

**Environment**
- Claude Code version: X.X.X
- OS: [Your OS]
```

### Feature Request Template
```markdown
**Is your feature related to a problem?**
Describe the problem

**Describe the solution**
How you envision the solution

**Additional context**
Any other information
```

## 🎯 Priority Areas

We're especially interested in contributions for:

1. **Skill Module Expansions**
   - Advanced topics
   - Real-world examples
   - Best practices
   - Interview questions

2. **New Projects**
   - Beginner-friendly projects
   - Real-world scenarios
   - Step-by-step guides
   - Solution code

3. **Agent Improvements**
   - Career path details
   - Interview preparation
   - Job market data
   - Learning resources

4. **Commands Enhancement**
   - Interactive workflows
   - User guides
   - Workflow diagrams
   - Example scenarios

5. **Documentation**
   - Tutorials
   - Case studies
   - Best practices guides
   - Troubleshooting

## 📊 File Structure

Keep contributions organized:

```
├── agents/
│   ├── XX-agent-name.md      # Agent files
├── skills/
│   ├── skill-name/
│   │   └── SKILL.md          # Skill module
├── commands/
│   ├── command-name.md       # Command file
├── docs/
│   ├── CONTRIBUTING.md       # This file
│   ├── CHANGELOG.md          # Version history
│   └── LICENSE.md            # License
```

## 📧 Communication

### Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and ideas
- **Pull Requests**: Code contributions and reviews
- **Email**: Contact maintainers for sensitive issues

## 🏆 Recognition

Contributors will be recognized in:
- CHANGELOG.md
- GitHub contributions page
- Project README (major contributors)
- Monthly contributor highlights

## ⚖️ License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 📖 Additional Resources

- [Developer Roadmap](https://roadmap.sh) - Original source material
- [Claude Code Docs](https://docs.claude.com) - Plugin documentation
- [Markdown Guide](https://www.markdownguide.org) - Markdown help
- [GitHub Help](https://help.github.com) - Git and GitHub guide

## 🙏 Thank You

Your contributions make ultrathink better for everyone!

---

**Questions?** Open an issue or start a discussion on GitHub!

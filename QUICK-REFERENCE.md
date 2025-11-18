# Developer Roadmaps - Quick Reference Guide

## Overview
- **Total Roadmaps:** 69
- **Repository:** https://github.com/kamranahmedse/developer-roadmap
- **Website:** https://roadmap.sh
- **Agents:** 7 (each handling ~10 roadmaps)

---

## Agent Distribution

| Agent | Focus | Count | Roadmaps |
|-------|-------|-------|----------|
| 1 | Frontend & Web | 10 | frontend, html, css, javascript, typescript, react, vue, angular, nextjs, design-system |
| 2 | Backend & API | 10 | backend, nodejs, python, java, golang, php, spring-boot, aspnet-core, laravel, api-design |
| 3 | DevOps & Infra | 10 | devops, docker, kubernetes, terraform, linux, aws, cloudflare, git-github, shell-bash, system-design |
| 4 | Data AI & ML | 10 | ai-engineer, ai-data-scientist, ai-agents, ai-red-teaming, data-analyst, data-engineer, bi-analyst, machine-learning, mlops, prompt-engineering |
| 5 | Mobile & Gaming | 10 | android, ios, flutter, react-native, swift-ui, kotlin, rust, cpp, game-developer, server-side-game-developer |
| 6 | Database & Arch | 10 | postgresql-dba, sql, mongodb, redis, software-architect, software-design-architecture, computer-science, datastructures-and-algorithms, code-review, graphql |
| 7 | Specialized & Mgmt | 9 | full-stack, qa, blockchain, cyber-security, ux-design, engineering-manager, product-manager, technical-writer, devrel |

---

## Categorization

### Role-Based Roadmaps (28 total)
Career path roadmaps - Tag: `role-roadmap`

**Core Development (8):**
- frontend, backend, full-stack, devops, android, ios, flutter, react-native

**Data & AI (7):**
- ai-engineer, ai-data-scientist, ai-agents, ai-red-teaming, data-analyst, data-engineer, bi-analyst, mlops

**Specialized Tech (4):**
- software-architect, qa, postgresql-dba, blockchain

**Gaming (2):**
- game-developer, server-side-game-developer

**Leadership & Communication (4):**
- engineering-manager, product-manager, technical-writer, devrel

**Design & Security (2):**
- ux-design, cyber-security

### Skill-Based Roadmaps (41 total)
Technology/tool roadmaps - Tag: `skill-roadmap`

**Languages (10):**
javascript, typescript, python*, java, golang, rust, cpp, php, kotlin, shell-bash

**Frontend (6):**
html, css, react, vue, angular, nextjs, swift-ui

**Backend (4):**
nodejs, spring-boot, aspnet-core, laravel

**Infrastructure (6):**
docker, kubernetes, terraform, linux, aws, cloudflare, git-github

**Database (4):**
sql, mongodb, redis, postgresql-dba*

**Architecture/Design (5):**
api-design, system-design, software-design-architecture, design-system, graphql

**Fundamentals (4):**
computer-science, datastructures-and-algorithms, code-review, machine-learning

**AI/ML (2):**
prompt-engineering, mlops*

*Note: Some roadmaps are hybrid (both role and skill)

---

## File Structure

### Per Roadmap Directory
```
src/data/roadmaps/{roadmap-name}/
├── {roadmap-name}.json          # Visual roadmap (node-based)
├── {roadmap-name}.md            # Metadata (YAML frontmatter)
├── content/                     # Topic files
│   └── {topic}@{id}.md
├── faqs.astro                   # FAQ component (optional)
└── migration-mapping.json       # Version data (optional)
```

### JSON Structure
```json
{
  "nodes": [
    {
      "id": "node-id",
      "type": "topic|subtopic|title|paragraph|button|vertical",
      "position": { "x": 0, "y": 0 },
      "data": {
        "label": "Text",
        "style": { "fontSize": "16px", "backgroundColor": "#fff" },
        "legend": "recommended|alternative",
        "href": "/path"
      },
      "measured": { "width": 100, "height": 50 }
    }
  ]
}
```

### Metadata Frontmatter (YAML)
```yaml
order: 1
briefTitle: "Short"
title: "Full Title"
briefDescription: "Short desc"
description: "Full description"
renderer: editor
jsonUrl: /jsons/roadmaps/name.json
pdfUrl: /pdfs/roadmaps/name.pdf
hasTopics: true
tags: [roadmap, main-sitemap, role-roadmap]
relatedRoadmaps: [roadmap1, roadmap2]
dimensions: { width: 968, height: 2000 }
sitemap: { priority: 1, changefreq: monthly }
```

---

## URL Patterns

### Website Access
```
Base: https://roadmap.sh/
Roadmap: https://roadmap.sh/{roadmap-name}
JSON: https://roadmap.sh/jsons/roadmaps/{roadmap-name}.json
PDF: https://roadmap.sh/pdfs/roadmaps/{roadmap-name}.pdf
Image: https://roadmap.sh/roadmaps/{roadmap-name}.png
```

### GitHub Repository
```
Directory: https://github.com/kamranahmedse/developer-roadmap/tree/master/src/data/roadmaps/{roadmap-name}
Raw MD: https://raw.githubusercontent.com/kamranahmedse/developer-roadmap/master/src/data/roadmaps/{roadmap-name}/{roadmap-name}.md
Raw JSON: https://raw.githubusercontent.com/kamranahmedse/developer-roadmap/master/src/data/roadmaps/{roadmap-name}/{roadmap-name}.json
```

### GitHub API
```
List All: https://api.github.com/repos/kamranahmedse/developer-roadmap/contents/src/data/roadmaps
Specific: https://api.github.com/repos/kamranahmedse/developer-roadmap/contents/src/data/roadmaps/{roadmap-name}
```

---

## All 69 Roadmaps (Alphabetical)

1. ai-agents
2. ai-data-scientist
3. ai-engineer
4. ai-red-teaming
5. android
6. angular
7. api-design
8. aspnet-core
9. aws
10. backend
11. bi-analyst
12. blockchain
13. cloudflare
14. code-review
15. computer-science
16. cpp
17. css
18. cyber-security
19. data-analyst
20. data-engineer
21. datastructures-and-algorithms
22. design-system
23. devops
24. devrel
25. docker
26. engineering-manager
27. flutter
28. frontend
29. full-stack
30. game-developer
31. git-github
32. golang
33. graphql
34. html
35. ios
36. java
37. javascript
38. kotlin
39. kubernetes
40. laravel
41. linux
42. machine-learning
43. mlops
44. mongodb
45. nextjs
46. nodejs
47. php
48. postgresql-dba
49. product-manager
50. prompt-engineering
51. python
52. qa
53. react
54. react-native
55. redis
56. rust
57. server-side-game-developer
58. shell-bash
59. software-architect
60. software-design-architecture
61. spring-boot
62. sql
63. swift-ui
64. system-design
65. technical-writer
66. terraform
67. typescript
68. ux-design
69. vue

---

## Top Roadmaps by Order (Priority)

| Order | Roadmap | Type |
|-------|---------|------|
| 1 | frontend | Role |
| 2 | backend | Role |
| 2 | react | Skill |
| 3 | full-stack | Role |
| 3 | devops | Role |
| 4 | ai-engineer | Role |
| 4.7 | android | Role |
| 7 | python | Hybrid |
| 14 | docker | Skill |
| 14 | kubernetes | Skill |
| 14 | prompt-engineering | Skill |

---

## Relationships (Most Connected)

### Frontend
Related: full-stack, javascript, nodejs, react, angular, vue, design-system

### Backend
Related: frontend, full-stack, system-design, python, devops, javascript, nodejs, postgresql-dba

### DevOps
Related: backend, docker, kubernetes, python, java, golang, javascript, nodejs

### AI Engineer
Related: ai-data-scientist, prompt-engineering, data-analyst, python

### Full-Stack
Related: frontend, backend, devops, react, nodejs, docker

### Docker
Related: devops, backend, kubernetes, linux, aws

### Kubernetes
Related: docker, devops, cloudflare, backend

---

## Key Statistics

- **Total Roadmaps:** 69
- **Role-Based:** 28 (40.6%)
- **Skill-Based:** 41 (59.4%)
- **GitHub Stars:** 344k+
- **Registered Users:** 2.1M+
- **Update Frequency:** Monthly
- **Sitemap Priority:** 1 (highest for all)
- **Data Format:** JSON (visual), Markdown (content)
- **Tech Stack:** TypeScript (84.5%), Astro (10.9%)

---

## Implementation Checklist

### Phase 1: Setup
- [ ] Create plugin directory structure
- [ ] Define 7 agent skill files
- [ ] Create roadmap index
- [ ] Set up data sync scripts

### Phase 2: Agent Development
- [ ] Agent 1: Frontend & Web (10 roadmaps)
- [ ] Agent 2: Backend & API (10 roadmaps)
- [ ] Agent 3: DevOps & Infrastructure (10 roadmaps)
- [ ] Agent 4: Data AI & ML (10 roadmaps)
- [ ] Agent 5: Mobile & Gaming (10 roadmaps)
- [ ] Agent 6: Database & Architecture (10 roadmaps)
- [ ] Agent 7: Specialized & Management (9 roadmaps)

### Phase 3: Content Population
- [ ] Extract roadmap metadata for all 69
- [ ] Create learning paths
- [ ] Compile interview questions
- [ ] Generate project ideas
- [ ] Curate resources

### Phase 4: Integration
- [ ] Implement universal commands
- [ ] Set up agent routing
- [ ] Enable cross-agent collaboration
- [ ] Test comprehensive queries

### Phase 5: Testing & Launch
- [ ] Test all 69 roadmaps
- [ ] Validate agent responses
- [ ] Review cross-references
- [ ] Deploy plugin

---

## Command Templates

### Universal Commands (All Agents)
```
/roadmap-overview {name}        - Get roadmap summary
/learning-path {name}           - Personalized learning path
/interview-prep {name}          - Interview preparation
/project-ideas {name}           - Hands-on projects
/resource-links {name}          - Curated resources
/skill-assessment {name}        - Self-assessment
/career-path {name}             - Career progression
/related-roadmaps {name}        - Related learning paths
```

### Agent-Specific Commands
Each agent has 8-10 specialized commands for their domain.

**Example - Agent 1 (Frontend):**
```
/frontend-basics               - HTML, CSS, JS fundamentals
/framework-compare             - React vs Vue vs Angular
/typescript-migration          - Adopt TypeScript
/nextjs-ssg-ssr               - Next.js rendering
/design-system-setup          - Create design system
/web-performance              - Frontend optimization
/accessibility-audit          - WCAG compliance
/component-patterns           - Reusable components
```

---

## Data Update Process

### Monthly Sync
1. Fetch latest from roadmap.sh
2. Check for new roadmaps
3. Update metadata
4. Refresh content files
5. Validate links
6. Update agent assignments
7. Deploy changes

### GitHub API Script
```bash
#!/bin/bash
# Fetch all roadmap metadata
curl -s "https://api.github.com/repos/kamranahmedse/developer-roadmap/contents/src/data/roadmaps" \
  | jq -r '.[].name' \
  | while read roadmap; do
    echo "Fetching $roadmap..."
    curl -s "https://raw.githubusercontent.com/kamranahmedse/developer-roadmap/master/src/data/roadmaps/$roadmap/$roadmap.md" \
      > "data/roadmaps/$roadmap.md"
  done
```

---

## Support Resources

### Official Links
- Website: https://roadmap.sh
- GitHub: https://github.com/kamranahmedse/developer-roadmap
- Discord: 42k+ members
- Author: Kamran Ahmed (@kamrify)

### Documentation
- Repository README
- Contributing guidelines
- Roadmap guidelines
- Content structure docs

---

## Quick Start

1. **Choose Your Path:** Browse all 69 roadmaps
2. **Find Your Agent:** See which of the 7 agents covers your interest
3. **Get Started:** Use `/learning-path {roadmap-name}`
4. **Deep Dive:** Explore topics with agent-specific commands
5. **Practice:** Build projects with `/project-ideas {roadmap-name}`
6. **Prepare:** Interview prep with `/interview-prep {roadmap-name}`
7. **Advance:** Follow career path with `/career-path {roadmap-name}`

---

## Plugin Name Suggestions

1. **claude-dev-roadmaps** (recommended)
2. claude-roadmap-navigator
3. claude-learning-paths
4. claude-tech-roadmaps
5. claude-career-guide

---

## Version History

- **v1.0** - Initial release with 69 roadmaps across 7 agents
- **v1.1** - Add best-practices content
- **v1.2** - Include question-groups
- **v2.0** - Interactive assessments and progress tracking

---

## License & Attribution

**Source:** roadmap.sh by Kamran Ahmed
**Repository:** https://github.com/kamranahmedse/developer-roadmap
**License:** Check repository for current license
**Attribution:** Always credit roadmap.sh and Kamran Ahmed

---

## Success Metrics

Track:
- Most requested roadmaps
- Popular agent queries
- Cross-agent collaborations
- Learning path completions
- Resource click-through rates
- User satisfaction ratings

---

## End

---
name: devops-infrastructure
description: Master DevOps practices with Docker, Kubernetes, Terraform, CI/CD, AWS, and infrastructure automation. Learn to build, deploy, and manage scalable cloud infrastructure.
---

# DevOps & Infrastructure

## Quick Start

### Docker Fundamentals
```dockerfile
# Dockerfile
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
EXPOSE 3000

CMD ["npm", "start"]
```

### Docker Commands
```bash
# Build image
docker build -t myapp:1.0 .

# Run container
docker run -p 3000:3000 myapp:1.0

# Push to registry
docker push myregistry/myapp:1.0
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:1.0
        ports:
        - containerPort: 3000
```

### Terraform Infrastructure
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server"
  }
}
```

### CI/CD Pipeline (GitHub Actions)
```yaml
name: Deploy

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build
        run: docker build -t myapp .
      - name: Push
        run: docker push myregistry/myapp
      - name: Deploy
        run: kubectl apply -f k8s/
```

## Core Concepts

### 1. Containerization
- Docker images and containers
- Image layers
- Container networking
- Volume management
- Docker Compose
- Container registries

### 2. Orchestration
- Pod concepts
- Deployments and replicas
- Services and networking
- ConfigMaps and Secrets
- StatefulSets
- DaemonSets
- Helm charts

### 3. Infrastructure as Code
- Declarative infrastructure
- Terraform state management
- AWS CloudFormation
- Ansible playbooks
- Version control for IaC
- Cost management

### 4. CI/CD
- Pipeline design
- Automated testing
- Build automation
- Deployment strategies
- Rollback mechanisms
- Environment management

### 5. Monitoring & Logging
- Prometheus metrics
- Grafana dashboards
- ELK stack
- Distributed tracing
- Alert management
- SLOs and SLIs

## Tools & Technologies

### Container Management
- Docker
- Container registries (Docker Hub, ECR, GCR)
- Docker Compose
- Podman

### Orchestration
- Kubernetes
- Docker Swarm
- Nomad
- OpenShift

### Infrastructure as Code
- Terraform
- CloudFormation
- Ansible
- SaltStack
- Helm

### Cloud Platforms
- **AWS**: EC2, RDS, S3, Lambda, ECS, EKS
- **Azure**: VMs, App Service, Kubernetes Service
- **GCP**: Compute Engine, Cloud Run, GKE

### CI/CD Tools
- GitHub Actions
- GitLab CI
- Jenkins
- CircleCI
- GitOps tools (ArgoCD, Flux)

## Common Patterns

### Deployment Strategies
- Blue-Green Deployment
- Canary Deployment
- Rolling Updates
- Feature Flags

### Scaling Patterns
- Horizontal Pod Autoscaling
- Vertical Pod Autoscaling
- Cluster Autoscaling
- Load Balancing

### Multi-Region
- Active-Active setup
- Disaster recovery
- Data replication
- Failover mechanisms

## Projects to Build

1. **Containerized Application**
   - Dockerfile optimization
   - Multi-stage builds
   - Docker Compose setup

2. **Kubernetes Cluster**
   - Local cluster (Minikube)
   - Multi-node setup
   - Service discovery
   - Ingress configuration

3. **Infrastructure with Terraform**
   - AWS VPC setup
   - RDS database
   - Load balancer
   - Auto-scaling group

4. **CI/CD Pipeline**
   - Automated tests
   - Docker build and push
   - Kubernetes deployment
   - Automated rollback

5. **Monitoring Stack**
   - Prometheus scraping
   - Grafana dashboards
   - Alert rules
   - Log aggregation

## Interview Tips

### Common DevOps Questions
- Explain containerization benefits
- How would you deploy an app to Kubernetes?
- What's the difference between Terraform and Ansible?
- How do you implement CI/CD?
- Explain blue-green deployment

### System Design
- Design a scalable deployment pipeline
- Create a multi-region infrastructure
- Implement disaster recovery
- Design monitoring for microservices

## Security Best Practices

- Container image scanning
- Network policies in Kubernetes
- RBAC (Role-Based Access Control)
- Secrets management
- Pod security policies
- Image signing and verification
- Security scanning in CI/CD

## Advanced Topics

- Kubernetes operators
- Service mesh (Istio, Linkerd)
- GitOps workflows
- Infrastructure testing
- Cost optimization
- Chaos engineering
- Multi-cloud deployments

## Performance Optimization

- Resource requests and limits
- Horizontal Pod Autoscaling
- Node affinity and taints
- Image optimization
- Network policies
- Persistent volume optimization

---

For detailed information, visit the **DevOps Engineer** roadmap at https://roadmap.sh/devops

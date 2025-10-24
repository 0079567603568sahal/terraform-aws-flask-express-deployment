# 🚀 Terraform AWS ECS Fargate Flask + Express Microservices Deployment

This project demonstrates how to deploy two microservices — a **Flask (Python)** backend and an **Express.js (Node.js)** frontend — using **Terraform** on **AWS ECS Fargate**, with container images stored in **AWS ECR**.

---

## 🧩 Architecture Overview

1. **Terraform** provisions:
   - VPC, Subnets, and Security Groups
   - ECS Cluster (Fargate)
   - Task Definitions for Flask & Express
   - ECR repositories for both services
2. **Docker** builds both applications and pushes images to ECR.
3. **ECS Services** launch both containers with auto-networking via ENIs.
4. Logs are collected in **AWS CloudWatch**.

---

## 🛠️ Tech Stack

| Layer | Technology |
|--------|-------------|
| Infrastructure | Terraform, AWS ECS, Fargate, ECR, CloudWatch |
| Backend | Flask (Python) |
| Frontend | Express.js (Node.js) |
| Containerization | Docker |
| Language | Python, JavaScript |
| CI/CD Ready | AWS CLI, GitHub |

---

## 📦 Commands Summary

### 🧱 Build & Push Docker Images
```bash
docker build -t express-frontend-repo .
docker tag express-frontend-repo:latest 215764923642.dkr.ecr.ap-south-1.amazonaws.com/express-frontend-repo:latest
docker push 215764923642.dkr.ecr.ap-south-1.amazonaws.com/express-frontend-repo:latest

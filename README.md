Project 4 : Automated-Docker-Image-Deployment-to-Amazon-ECR-with-Jenkins-and-Lambda-Integration

## 📌 Project Overview

This project demonstrates how to build a fully automated CI/CD pipeline using **Jenkins** that:

- Builds and tags a **Docker image**
- Pushes it to **Amazon ECR (Elastic Container Registry)**
- Triggers an **AWS Lambda** function after a successful push

All infrastructure and automation components are managed through code.

---

## 🛠️ Tech Stack

- **Docker** – Containerize the application
- **Amazon ECR** – Store and manage Docker images
- **Jenkins** – Automate the build and deployment pipeline
- **AWS Lambda** – Trigger post-deployment logic
- **GitHub** – Source code versioning

---

## 📁 Project Structure

project4/
├── Dockerfile
├── Jenkinsfile
├── lambda/
│   └── index.py
├── app/
│   ├── app.py
│   └── requirements.txt
├── README.md



---

## 🔄 CI/CD Pipeline Flow

1. 🟢 GitHub Code Push  
2. ⚙️ Jenkins triggers pipeline  
3. 🐳 Docker image built  
4. 🚀 Docker image pushed to ECR  
5. 🔔 AWS Lambda function triggered

---

## 🚀 Setup Instructions

### ✅ 1. Docker Build & Test (Local)
```bash
docker build -t myapp .
docker run -p 5000:5000 myapp

✅ 2. Create ECR Repository

aws ecr create-repository --repository-name myapp-repo

✅ 3. Login & Push Docker Image

aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
docker tag myapp <account_id>.dkr.ecr.<region>.amazonaws.com/myapp-repo:latest
docker push <account_id>.dkr.ecr.<region>.amazonaws.com/myapp-repo:latest

✅ 4. Jenkins Pipeline Setup

    Create a pipeline job in Jenkins

    Connect to this GitHub repo

    Use Jenkinsfile from the root of this repo

    Add AWS credentials in Jenkins credentials manager

✅ 5. AWS Lambda Function

    Create Lambda function

    Use code from lambda/index.py

    Trigger Lambda using EventBridge or Jenkins CLI


🔐 Security Practices

    Use IAM roles with least privilege

    Store AWS credentials securely in Jenkins

    Avoid hardcoding secrets or access keys

🔧 Optional Enhancements

    Slack or SNS notifications on image push

    ECS Service update after Lambda trigger

    Terraform to provision all infrastructure

    GitHub Webhook integration for auto-triggers

# AWS Cloud Engineer Interview Preparation - 15 Day Plan

This repository contains a comprehensive 15-day preparation plan for AWS Cloud Engineer interviews, covering all core AWS services with hands-on labs, practice tasks, and exercises.

## Overview

- **Duration**: 15 days (September 15-29, 2026)
- **Services Covered**: EC2, S3, VPC, IAM, Lambda, RDS, CloudFormation, CloudWatch
- **Format**: Daily hands-on labs, practice questions, and infrastructure-as-code exercises
- **Goal**: End-to-end preparation for AWS Cloud Engineer interviews

## Repository Structure

```
aws-interview-prep-15days/
├── README.md
├── scripts/
│   ├── day01-iam-setup.sh
│   ├── day02-ec2-cli.sh
│   ├── day03-s3-cli.sh
│   ├── day04-vpc-setup.sh
│   ├── day05-iam-simulate.sh
│   ├── day06-lambda-deploy.sh
│   ├── day07-rds-connect.sh
│   ├── day08-cfn-deploy.sh
│   ├── day09-cloudwatch-setup.sh
│   ├── day10-practice-questions.sh
│   ├── day11-mock-interview.sh
│   ├── day12-scenario-labs.sh
│   ├── day13-review-weak-areas.sh
│   ├── day14-full-mock-exam.sh
│   └── day15-final-review.sh
├── terraform/
│   └── day02-ec2/
│       └── main.tf
├── cdk/
│   └── day03-s3-website/
│       ├── package.json
│       ├── tsconfig.json
│       └── lib/
│           └── day03-s3-website-stack.ts
├── cloudformation/
│   ├── day04-vpc.yaml
│   ├── day07-rds.yaml
│   ├── day08-infra.yaml
│   ├── day09-cloudwatch.yaml
│   └── day15-final-architecture.yaml
├── iam/
│   └── day05-role-policy.json
├── sam/
│   └── day06-lambda-thumbnail/
│       ├── template.yaml
│       ├── hello-world/
│       │   ├── app.py
│       │   └── requirements.txt
│       └── thumbnail-function/
│           ├── app.py
│           └── requirements.txt
└── practice/
    ├── ec2-questions.md
    ├── s3-questions.md
    ├── vpc-questions.md
    ├── iam-questions.md
    ├── lambda-questions.md
    ├── rds-questions.md
    ├── cloudformation-questions.md
    └── cloudwatch-questions.md
```

## Daily Schedule

### Week 1: Foundations & Core Services

**Day 1: AWS Foundations & IAM Basics**
- AWS Well-Architected Framework - Operational Excellence pillar
- Shared Responsibility Model
- Global Infrastructure
- IAM Basics
- **Deliverables**: IAM user/group setup scripts

**Day 2: EC2 Fundamentals**
- EC2 instance types, AMIs, Security Groups, Key Pairs
- Console and CLI launches
- Apache deployment
- Terraform provisioning
- **Deliverables**: EC2 launch scripts + Terraform files

**Day 3: S3 Basics**
- Bucket creation, versioning, static website hosting
- Lifecycle policies, public access
- AWS CDK implementation
- **Deliverables**: S3 website scripts + CDK TypeScript code

**Day 4: VPC Fundamentals**
- VPC, subnets, route tables, IGW, NAT Gateway
- NACLs, bastion hosts
- CloudFormation export
- **Deliverables**: VPC setup scripts + CloudFormation template

**Day 5: IAM Deep Dive**
- Policy types, roles, STS, least privilege
- Policy simulation, cross-account access
- Best practices checklist
- **Deliverables**: IAM role/policy JSON + simulation scripts

**Day 6: Lambda Basics**
- Lambda functions, event sources, execution role
- Layers, SAM deployment
- S3-triggered thumbnail generation
- **Deliverables**: Lambda SAM application + deployment scripts

**Day 7: RDS Fundamentals**
- Multi-AZ MySQL, security groups, backups
- Read replicas, snapshots
- CloudFormation snippets
- **Deliverables**: RDS connection scripts + CloudFormation template

**Day 8: CloudFormation Basics**
- Template anatomy, parameters, mappings, outputs
- Multi-service stack (VPC + EC2 + S3)
- Change sets, stack updates
- **Deliverables**: Infrastructure CloudFormation template + deployment scripts

**Day 9: CloudWatch Monitoring**
- Metrics, logs, alarms, dashboards, events
- CPU alarms, Lambda logging, custom dashboards
- EventBridge scheduled triggers
- **Deliverables**: CloudWatch setup scripts + monitoring templates

### Week 2: Practice & Integration

**Day 10: Practice Questions & Review**
- Top 100 AWS interview questions review
- Service-specific practice problems
- Hands-on scenario exercises
- **Deliverables**: Practice question sets + solution scripts

**Day 11: Mock Interview Preparation**
- Behavioral questions (STAR method)
- Technical deep-dive preparation
- Leadership Principles alignment
- **Deliverables**: Mock interview guides + preparation checklist

**Day 12: Scenario-Based Labs**
- Real-world architecture scenarios
- Cost optimization exercises
- Security and compliance scenarios
- **Deliverables**: Scenario lab scripts + architecture diagrams

**Day 13: Review Weak Areas**
- Personalized review based on practice results
- Focused remediation on challenging topics
- **Deliverables**: Targeted review materials + remediation scripts

**Day 14: Full Mock Exam**
- Comprehensive timed assessment
- All services covered
- Performance analysis and feedback
- **Deliverables**: Mock exam + answer key + performance tracker

**Day 15: Final Review & Mental Preparation**
- Key concepts review
- Interview day preparation
- Mental readiness and confidence building
- **Deliverables**: Final review notes + interview day checklist

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/abhinavpadige4/aws-interview-prep-15days.git
   ```

2. Configure AWS CLI with appropriate credentials:
   ```bash
   aws configure
   ```

3. Follow the daily schedule, completing each day's tasks and exercises.

## Prerequisites

- AWS Account (free tier eligible)
- AWS CLI installed and configured
- Basic Linux/Bash knowledge
- Terraform installed (for Day 2)
- Node.js and TypeScript installed (for Day 3 CDK)
- Python 3.11+ installed (for Day 6 Lambda)
- MySQL client installed (for Day 7 RDS)

## Resources Used

- AWS Documentation
- AWS Well-Architected Framework
- AWS Hands-on Labs (MinhHungPhan/aws-hands-on-labs)
- AWS Cloud Labs (eusrawayne/aws-cloud-labs)
- AWS CDK, SAM, CloudFormation documentation
- Various AWS blog posts and whitepapers

## License

This repository is for educational purposes only. Please ensure you clean up AWS resources after completing labs to avoid unexpected charges.

## Contributing

Feel free to submit issues or pull requests to improve this preparation plan.

---
*Last updated: September 2026*
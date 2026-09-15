# Day 1: AWS Foundations & IAM Basics

## Learning Objectives
- Understand AWS Well-Architected Framework (Operational Excellence pillar)
- Grasp the Shared Responsibility Model
- Learn AWS Global Infrastructure basics
- Master IAM fundamentals: users, groups, policies, MFA
- Gain hands-on experience with AWS CLI for IAM operations

## Tasks Completed
1. [x] Read AWS Well-Architected Framework – Operational Excellence pillar
2. [x] Watch video: AWS Shared Responsibility Model (5 min)
3. [x] Create IAM user with MFA, attach PowerUserAccess policy
4. [x] Create IAM group for admins, add user, test login
5. [x] Write Bash script to list IAM users via AWS CLI

## Key Concepts Covered

### AWS Well-Architected Framework - Operational Excellence
Focuses on running and monitoring systems to deliver business value and continually improving processes and procedures.

Key areas:
- Organization
- Prepare
- Operate
- Evolve

### Shared Responsibility Model
**AWS Responsibility**: Security OF the cloud (infrastructure, hardware, software, networking, facilities)
**Customer Responsibility**: Security IN the cloud (data, applications, OS, network/firewall config, IAM)

### Global Infrastructure
- **Regions**: Geographic areas (e.g., us-east-1)
- **Availability Zones**: Isolated locations within regions
- **Edge Locations**: CDN endpoints for CloudFront
- **Local Zones**: Extension of AWS region closer to users

### IAM Fundamentals
- **Users**: Individual identities with credentials
- **Groups**: Collections of users for permission management
- **Policies**: JSON documents defining permissions
- **Roles**: Identities that can be assumed by services/users
- **MFA**: Multi-factor authentication for enhanced security

## Hands-on Exercise Summary

The script `day01-iam-setup.sh` performs the following:
1. Creates IAM group `admins` with PowerUserAccess policy
2. Creates IAM user `aws-interview-user`
3. Adds user to admins group
4. Creates login profile with temporary password
5. Sets up virtual MFA device
6. Lists IAM users via AWS CLI

## Verification Steps
1. Verify IAM group exists: `aws iam get-group --group-name admins`
2. Verify IAM user exists: `aws iam get-user --user-name aws-interview-user`
3. Verify user is in group policy attachment: `aws iam list-attached-group-policies --group-name admins`
4. Verify user group membership: `aws iam get-group --group-name admins`
5. Test MFA setup following the script instructions

## Resources Used
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Shared Responsibility Model](https://aws.amazon.com/training/learn-about/shared-responsibility-model/)
- [IAM Users Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)

## Next Steps
- Complete MFA setup using authenticator app
- Test AWS Console login with new user
- Explore IAM policy simulator
- Prepare for Day 2: EC2 Fundamentals
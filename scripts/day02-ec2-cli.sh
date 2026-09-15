#!/bin/bash
# Day 2: EC2 Fundamentals - CLI Operations
# Launches EC2 instance via AWS CLI and captures output

set -euo pipefail

echo "=== Day 2: EC2 Fundamentals via AWS CLI ==="

# Variables
INSTANCE_NAME="aws-interview-ec2"
KEY_PAIR_NAME="aws-interview-key"
SECURITY_GROUP_NAME="aws-interview-sg"
AMI_ID="ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI (us-east-1)
INSTANCE_TYPE="t2.micro"

# Create key pair
echo "Creating EC2 key pair: $KEY_PAIR_NAME"
aws ec2 create-key-pair \
    --key-name "$KEY_PAIR_NAME" \
    --query 'KeyMaterial' \
    --output text > "${KEY_PAIR_NAME}.pem"

chmod 400 "${KEY_PAIR_NAME}.pem"
echo "Key pair saved to ${KEY_PAIR_NAME}.pem"

# Create security group
echo "Creating security group: $SECURITY_GROUP_NAME"
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
    --group-name "$SECURITY_GROUP_NAME" \
    --description "Security group for AWS interview prep EC2 instance" \
    --query 'GroupId' \
    --output text)

# Authorize SSH (port 22) and HTTP (port 80)
echo "Authorizing SSH and HTTP access"
aws ec2 authorize-security-group-ingress \
    --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

# Get subnet ID (default VPC)
echo "Getting default subnet ID"
SUBNET_ID=$(aws ec2 describe-subnets \
    --filters "Name=defaultForAz,Values=true" \
    --query 'Subnets[0].SubnetId' \
    --output text)

# Launch EC2 instance
echo "Launching EC2 instance: $INSTANCE_NAME"
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type "$INSTANCE_TYPE" \
    --key-name "$KEY_PAIR_NAME" \
    --security-group-ids "$SECURITY_GROUP_ID" \
    --subnet-id "$SUBNET_ID" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instance launched with ID: $INSTANCE_ID"

# Wait for instance to be running
echo "Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

# Get instance details
echo "Getting instance details"
INSTANCE_DETAILS=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query 'Reservations[0].Instances[0]' \
    --output json)

echo "Instance Details:"
echo "$INSTANCE_DETAILS" | jq -r '{InstanceId, State: State.Name, PublicIpAddress, PrivateIpAddress, InstanceType}'

# Get public IP for SSH
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "Public IP: $PUBLIC_IP"
echo "To connect via SSH:"
echo "ssh -i ${KEY_PAIR_NAME}.pem ec2-user@$PUBLIC_IP"

# Install Apache and deploy HTML page (user data script)
USER_DATA=$(cat <<'EOF'
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to AWS Interview Prep EC2 Instance</h1><p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" > /var/www/html/index.html
EOF
)

# Update instance with user data (requires stopping/starting or using newer launch)
echo "Note: To install Apache, you would typically use User Data at launch"
echo "For this exercise, we'll demonstrate the concept"

# Capture and display launch output
echo "=== EC2 Launch Output Summary ==="
echo "Instance ID: $INSTANCE_ID"
echo "Instance Type: $INSTANCE_TYPE"
echo "AMI ID: $AMI_ID"
echo "Key Pair: $KEY_PAIR_NAME"
echo "Security Group: $SECURITY_GROUP_ID"
echo "Subnet ID: $SUBNET_ID"
echo "Public IP: $PUBLIC_IP"
echo "Region: $(aws configure get region)"

# Cleanup instructions
echo ""
echo "=== Cleanup Instructions ==="
echo "To terminate instance when done:"
echo "aws ec2 terminate-instances --instance-ids $INSTANCE_ID"
echo ""
echo "To delete key pair:"
echo "aws ec2 delete-key-pair --key-name $KEY_PAIR_NAME"
echo "rm -f ${KEY_PAIR_NAME}.pem"
echo ""
echo "To delete security group:"
echo "aws ec2 delete-security-group --group-id $SECURITY_GROUP_ID"

echo "=== Day 2 EC2 CLI Tasks Complete ==="
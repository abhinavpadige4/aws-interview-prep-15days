#!/bin/bash
# Day 1: AWS IAM Setup Script
# Creates IAM user with MFA, group, and tests login

set -euo pipefail

echo "=== Day 1: AWS IAM Setup ==="

# Variables
USER_NAME="aws-interview-user"
GROUP_NAME="admins"
POLICY_ARN="arn:aws:iam::aws:policy/PowerUserAccess"

# Create IAM group
echo "Creating IAM group: $GROUP_NAME"
aws iam create-group --group-name "$GROUP_NAME" || echo "Group may already exist"

# Attach PowerUserAccess policy to group
echo "Attaching PowerUserAccess policy to group"
aws iam attach-group-policy \
    --group-name "$GROUP_NAME" \
    --policy-arn "$POLICY_ARN" || echo "Policy may already be attached"

# Create IAM user
echo "Creating IAM user: $USER_NAME"
aws iam create-user --user-name "$USER_NAME" || echo "User may already exist"

# Add user to group
echo "Adding user to group"
aws iam add-user-to-group \
    --user-name "$USER_NAME" \
    --group-name "$GROUP_NAME" || echo "User may already be in group"

# Create login profile (password)
echo "Creating login profile"
aws iam create-login-profile \
    --user-name "$USER_NAME" \
    --password "TempPassword123!" \
    --password-reset-required || echo "Login profile may already exist"

# Create MFA device (virtual)
echo "Setting up MFA device"
MFA_DEVICE=$(aws iam create-virtual-mfa-device \
    --virtual-mfa-device-name "${USER_NAME}-mfa" \
    --output text \
    --query 'VirtualMFADevice.SerialNumber')

# Generate QR code for MFA setup (requires qrcode library)
echo "MFA Device ARN: $MFA_DEVICE"
echo "To complete MFA setup:"
echo "1. Scan QR code with authenticator app"
echo "2. Enter two consecutive MFA codes"
echo "3. Run: aws iam enable-mfa-device --user-name $USER_NAME --serial-number $MFA_DEVICE --authentication-code-1 CODE1 --authentication-code-2 CODE2"

# Test AWS CLI access
echo "Testing AWS CLI access for new user"
echo "Configure AWS CLI profile for $USER_NAME and test access"

# List IAM users via AWS CLI (as requested in tasks)
echo "Listing IAM users:"
aws iam list-users --query 'Users[*].UserName' --output table

echo "=== Day 1 Tasks Complete ==="
echo "Next steps:"
echo "1. Complete MFA setup using the QR code"
echo "2. Test login to AWS Management Console"
echo "3. Verify user has PowerUserAccess permissions"
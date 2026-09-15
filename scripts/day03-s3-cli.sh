#!/bin/bash
# Day 3: S3 Basics - CLI Operations
# Creates S3 bucket, enables versioning, hosts static website

set -euo pipefail

echo "=== Day 3: S3 Basics via AWS CLI ==="

# Variables
BUCKET_NAME="aws-interview-prep-s3-$(date +%s)"  # Unique bucket name
REGION="us-east-1"
WEBSITE_DIR="./website-files"

# Create website directory and files
echo "Creating website files directory"
mkdir -p "$WEBSITE_DIR"

cat > "$WEBSITE_DIR/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS Interview Prep S3 Website</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .header { color: #ff9900; }
        .feature { margin: 20px 0; padding: 15px; background: #f5f5f5; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="header">Welcome to AWS Interview Prep</h1>
        <p>This is a static website hosted on Amazon S3.</p>
        
        <div class="feature">
            <h2>📚 Services Covered</h2>
            <ul>
                <li>EC2 - Virtual Servers</li>
                <li>S3 - Object Storage</li>
                <li>VPC - Networking</li>
                <li>IAM - Security & Identity</li>
                <li>Lambda - Serverless Computing</li>
                <li>RDS - Managed Databases</li>
                <li>CloudFormation - Infrastructure as Code</li>
                <li>CloudWatch - Monitoring & Logging</li>
            </ul>
        </div>
        
        <div class="feature">
            <h2>🎯 Today's Focus: S3</h2>
            <p>Amazon S3 provides scalable object storage for data backup, archival, and analytics.</p>
        </div>
        
        <footer>
            <p>Generated on: $(date)</p>
        </footer>
    </div>
</body>
</html>
EOF

cat > "$WEBSITE_DIR/error.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - AWS Interview Prep</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; text-align: center; }
        .error-code { font-size: 8em; color: #ff9900; }
        .message { margin: 20px 0; }
    </style>
</head>
<body>
    <div class="error-code">404</div>
    <div class="message">
        <h1>Page Not Found</h1>
        <p>The requested page could not be found on this S3 static website.</p>
        <a href="index.html">Return to Homepage</a>
    </div>
</body>
</html>
EOF

# Create S3 bucket
echo "Creating S3 bucket: $BUCKET_NAME"
aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$REGION" \
    --create-bucket-configuration LocationConstraint="$REGION" || \
aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$REGION"

# Enable versioning
echo "Enabling versioning on bucket"
aws s3api put-bucket-versioning \
    --bucket "$BUCKET_NAME" \
    --versioning-configuration Status=Enabled

# Upload website files
echo "Uploading website files to S3"
aws s3 sync "$WEBSITE_DIR/" "s3://$BUCKET_NAME/" \
    --content-type "text/html" \
    --cache-control "max-age=86400"

# Configure bucket for static website hosting
echo "Configuring bucket for static website hosting"
aws s3api put-bucket-website \
    --bucket "$BUCKET_NAME" \
    --website-configuration file://<(cat <<WEBSITE_CONFIG
{
    "IndexDocument": {
        "Suffix": "index.html"
    },
    "ErrorDocument": {
        "Key": "error.html"
    }
}
WEBSITE_CONFIG
)

# Set bucket policy for public read access
echo "Setting bucket policy for public read access"
aws s3api put-bucket-policy \
    --bucket "$BUCKET_NAME" \
    --policy file://<(cat <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
        }
    ]
}
POLICY
)

# Configure lifecycle rule to transition to IA after 30 days
echo "Configuring lifecycle rule for IA transition"
aws s3api put-bucket-lifecycle-configuration \
    --bucket "$BUCKET_NAME" \
    --lifecycle-configuration file://<(cat <<LIFECYCLE
{
    "Rules": [
        {
            "ID": "TransitionToIAAfter30Days",
            "Status": "Enabled",
            "Filter": {},
            "Transitions": [
                {
                    "Days": 30,
                    "StorageClass": "STANDARD_IA"
                }
            ],
            "NoncurrentVersionTransitions": [
                {
                    "NoncurrentDays": 30,
                    "StorageClass": "STANDARD_IA"
                }
            ]
        }
    ]
}
LIFECYCLE
)

# Get website endpoint
WEBSITE_ENDPOINT=$(aws s3api get-bucket-website \
    --bucket "$BUCKET_NAME" \
    --query 'WebsiteEndpoint' \
    --output text)

# Display results
echo "=== S3 Bucket Configuration Complete ==="
echo "Bucket Name: $BUCKET_NAME"
echo "Region: $REGION"
echo "Versioning: Enabled"
echo "Static Website Hosting: Enabled"
echo "Website Endpoint: http://$WEBSITE_ENDPOINT"
echo "Public Read Access: Configured"
echo "Lifecycle Rule: Transition to IA after 30 days"

echo ""
echo "Website Files Uploaded:"
aws s3 ls "s3://$BUCKET_NAME/" --recursive

echo ""
echo "=== Verification Steps ==="
echo "1. Visit website: http://$WEBSITE_ENDPOINT"
echo "2. Test error page: http://$WEBSITE_ENDPOINT/nonexistent.html"
echo "3. Check versioning: aws s3api get-bucket-versioning --bucket $BUCKET_NAME"
echo "4. Check website config: aws s3api get-bucket-website --bucket $BUCKET_NAME"
echo "5. Check bucket policy: aws s3api get-bucket-policy --bucket $BUCKET_NAME"
echo "6. Check lifecycle config: aws s3api get-bucket-lifecycle-configuration --bucket $BUCKET_NAME"

echo ""
echo "=== Cleanup Instructions ==="
echo "To delete website files:"
echo "aws s3 rm s3://$BUCKET_NAME/ --recursive"
echo ""
echo "To delete the bucket (must be empty first):"
echo "aws s3 rb s3://$BUCKET_NAME/ --force"

echo "=== Day 3 S3 CLI Tasks Complete ==="
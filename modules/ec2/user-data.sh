#!/bin/bash
# User data script for EC2 instance

# Update system packages
yum update -y

# Set hostname
hostnamectl set-hostname ${hostname}

# Install common packages
yum install -y \
    amazon-cloudwatch-agent \
    aws-cli \
    docker \
    git

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Configure CloudWatch agent
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
    "agent": {
        "metrics_collection_interval": 60,
        "run_as_user": "root"
    },
    "metrics": {
        "metrics_collected": {
            "disk": {
                "measurement": ["used_percent"],
                "resources": ["/"]
            },
            "mem": {
                "measurement": ["mem_used_percent"]
            }
        }
    }
}
EOF

# Start CloudWatch agent
systemctl start amazon-cloudwatch-agent
systemctl enable amazon-cloudwatch-agent

# Add environment tag to instance metadata
echo "ENVIRONMENT=${environment}" >> /etc/environment

# Create a welcome message
echo "Welcome to ${hostname} in ${environment} environment" > /etc/motd 
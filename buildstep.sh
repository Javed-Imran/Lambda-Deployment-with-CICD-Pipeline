#!/bin/bash


# Step-1 Clone the Git repository
git clone https://github.com/harshartz/task.git

export AWS_REGION='us-east-1'
export AWS_ACCOUNT_ID=
export ECR_REPO_NAME='go-digi-task2'
export IMAGE_NAME='helloworld-lambda'
export LAMBDA_FUNCTION_NAME='ecr-trigger'
export aws_access_key_id=
export aws_secret_access_key_id=
export IAM_ROLE_ARN=

# Step-2 Configure AWS credentials
aws configure set aws_access_key_id $aws_access_key_id
aws configure set aws_secret_access_key $aws_secret_access_key_id
aws configure set default.region $AWS_REGION

# Step-4 Create ECR repository
docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com < <(aws ecr get-login-password --region $AWS_REGION)

aws ecr create-repository --repository-name $ECR_REPO_NAME

# Step-5 Build and push Docker image
docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest

# Step-6 Deploy Lambda function
aws lambda create-function \
    --function-name $LAMBDA_FUNCTION_NAME \
    --package-type Image \
    --code ImageUri=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest \
    --role $IAM_ROLE_ARN \
    --region $AWS_REGION
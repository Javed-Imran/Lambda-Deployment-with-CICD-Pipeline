# Lambda-Deployment-with-CICD-Pipeline

## Project Overview

This repository demonstrates a straightforward CI/CD setup for deploying an AWS Lambda function using Jenkins, Docker, and Amazon Elastic Container Registry (ECR). The project includes a basic Python Lambda function that prints "Hello, World!" when invoked. The CI/CD pipeline, orchestrated by Jenkins, utilizes Docker for containerized builds and ECR for efficient container image storage.


## Prerequisites

Before you begin, ensure the following prerequisites are met:

- AWS account with appropriate permissions.
- AWS CLI installed.
- Docker installed.
- Jenkins installed.
- Git installed.

## Setup

1. **Lambda Execution Role:**
   - In your AWS account, create a role for the Lambda function with the following permissions:
     - `logs:CreateLogGroup`
     - `logs:CreateLogStream`
     - `logs:PutLogEvents`
   - Alternatively, you can use the default Lambda execution role.

2. **Jenkins AWS Credentials:**
   - Install the AWS credentials extension in Jenkins.
   - Set up AWS credentials in Jenkins with the following details:
     - `credentialsId: 'aws-credentials'`
     - `accessKeyVariable: 'AWS_ACCESS_KEY_ID'`
     - `secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'`

3. **Clone Repository:**
   - Clone the repository using the following commands:
     ```bash
     git clone https://github.com/harshartz/Lambda-Deployment-with-CICD-Pipeline.git
     cd Lambda-Deployment-with-CICD-Pipeline
     ```

4. **Update Jenkinsfile:**
   - Open the `Jenkinsfile` and make the following changes in the `environment` section:
     ```groovy
     environment {
         AWS_REGION = 'ap-south-1'
         AWS_ACCOUNT_ID = '054774128594'
         ECR_REPO_NAME = 'go-digi-task2'
         IMAGE_NAME = 'helloworld-lambda'
         LAMBDA_FUNCTION_NAME = 'ecr-trigger'
         IAM_ROLE_ARN = 'arn:aws:iam::054774128594:role/go-digi-task'
     }
     ```
   - Change the values of the environment variables according to your AWS setup.

5. **Run the Pipeline:**
   - Trigger the Jenkins pipeline to build, push, and deploy the Docker image and Lambda function.

You are now ready to deploy the Lambda function using Jenkins and Docker.

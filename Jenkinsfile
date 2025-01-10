pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '354918404626'
        ECR_REPO_NAME = 'go-digi-task2'
        IMAGE_NAME = 'helloworld-lambda'
        LAMBDA_FUNCTION_NAME = 'ecr-trigger'
        IAM_ROLE_ARN = 'arn:aws:iam::354918404626:role/go-digi-task'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git 'https://github.com/harshartz/task.git'
                }
            }
        }

        stage('Create a ECR repository & Authentication of Docker client') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                    aws ecr create-repository --repository-name $ECR_REPO_NAME
                    '''
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh '''
                    docker build -t $IMAGE_NAME .
                    docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest
                    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest
                    '''
                }
            }
        }
        
        stage('Deploy Lambda Function') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                    aws lambda create-function --function-name $LAMBDA_FUNCTION_NAME --package-type Image --code ImageUri=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest --role $IAM_ROLE_ARN --region $AWS_REGION
                    '''
                }
            }
        }
    }
}

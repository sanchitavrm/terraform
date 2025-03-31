pipeline{
    agent any 
    
    environment {
        AWS_CREDENTIALS = credentials(env.ENVIRONMENT == 'prod' ? 'aws-prod-credentials' : 'aws-credentials-id')
    }

    stages{
        stage('Deploy to AWS') {
            steps {
                withAWS(credentials: env.AWS_CREDENTIALS, region: 'us-east-2') {
                    // Initialize Terraform
                    sh 'terraform init'
                    
                    // Plan Terraform changes with environment variables
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: env.AWS_CREDENTIALS,
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}

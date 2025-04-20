pipeline{
    agent any 
    
    parameters {
        booleanParam(name: 'DEPLOY_EC2', defaultValue: false, description: 'Deploy EC2 resources')
        booleanParam(name: 'DEPLOY_VPC', defaultValue: false, description: 'Deploy VPC resources')
    }
    
    environment {
        AWS_CREDENTIALS = 'aws-credentials-id'
        AWS_REGION = 'us-east-2'
    }

    stages{
        stage('Deploy to AWS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: env.AWS_CREDENTIALS,
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    // Change to services directory and initialize Terraform
                    dir('services') {
                        sh 'terraform init'
                        
                        script {
                            // Create a target list based on selected services
                            def targets = []
                            if (params.DEPLOY_EC2) {
                                targets.add('-target=module.ec2')
                            }
                            if (params.DEPLOY_VPC) {
                                targets.add('-target=module.vpc')
                            }
                            
                            // Run terraform plan with selected targets
                            if (!targets.isEmpty()) {
                                sh "terraform plan ${targets.join(' ')}"
                                sh "terraform apply -auto-approve ${targets.join(' ')}"
                            } else {
                                echo 'No services selected for deployment'
                            }
                        }
                    }
                }
            }
        }
    }
}

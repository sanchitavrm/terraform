pipeline{
    agent any 
    
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'staging'],
            description: 'Select deployment environment'
        )
        booleanParam(name: 'DEPLOY_EC2', defaultValue: false, description: 'Deploy EC2 resources')
        booleanParam(name: 'DEPLOY_VPC', defaultValue: false, description: 'Deploy VPC resources')
    }
    
    environment {
        AWS_CREDENTIALS = credentials("aws-${params.ENVIRONMENT}-credentials")  // different credentials per environment
        AWS_REGION = 'us-east-2'
        WORKSPACE = "${params.ENVIRONMENT}"
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
                        sh 'pwd'
                        sh "terraform init -backend-config=backend/${params.ENVIRONMENT}/backend.tfvars"
                        sh 'terraform validate'
                        script {
                            // Create a target list based on selected services
                            def targets = []
                            if (params.DEPLOY_EC2) {
                                targets.add('-target=module.ec2')
                            }
                            if (params.DEPLOY_VPC) {
                                targets.add('-target=module.vpc')
                            }
                            
                            // Run terraform plan with selected targets and workspace
                            if (!targets.isEmpty()) {
                                sh "terraform workspace select ${env.WORKSPACE} || terraform workspace new ${env.WORKSPACE}"
                                sh "terraform plan -var-file=variables/${params.ENVIRONMENT}/terraform.tfvars ${targets.join(' ')}"
                                sh "terraform apply -auto-approve -var-file=variables/${params.ENVIRONMENT}/terraform.tfvars ${targets.join(' ')}"
                            } else {
                                echo 'No services selected for deployment'
                            }
                        }
                    }
                }
            }
        }
    }

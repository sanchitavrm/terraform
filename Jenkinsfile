pipeline{
    agent any 
        
    tools{
        maven "maven"
    }
    stages{
        stage('Deploy to AWS') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
                
                // Plan Terraform changes
                sh 'terraform plan'
                
                // Apply Terraform changes
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

pipeline{
    agent any 
        
    tools{
        maven "maven"
    }
    stages{
        stage('Build') {
            steps{
            git "https://github.com/sanchitavrm/samplejavaapp.git"
            sh "mvn clean package"
             }
        }
        stage('Test'){
            steps{
                sh 'make check || true' 
                junit '**/target/*.xml' 
            }
        }
    }
}

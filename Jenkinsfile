pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
    registry = '815965821970.dkr.ecr.us-east-1.amazonaws.com/devops-terra'
    registryCredential = 'aws-credentials'
    SONAR_TOKEN = credentials('sonarqubeID')
    dockerimage = ''
  }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/maeva2023/maven-test.git'
            }
        }
       
        stage('Code Build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage("SonarQube Scan") {
      steps {
        withCredentials([string(credentialsId: 'sonarqubeID', variable: 'SONAR_TOKEN')]) {
          withSonarQubeEnv('sonar') {
            sh 'mvn sonar:sonar'
                }
              }
             }
         }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                } 
            }
        }
        stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry("https://"+registry,"ecr:us-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}

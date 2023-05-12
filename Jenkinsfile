pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
    registry = '815965821970.dkr.ecr.us-east-1.amazonaws.com/devops-terra'
    registryCredential = 'aws-credentials'
    dockerimage = ''
  }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/maeva2023/maven-test.git'
            }
        }
        stage ("Sonarqube scan") {
          steps{
          withSonarQubeEnv('sonar') {
        sh 'mvn sonar:sonar -Dsonar.projectKey=maeva2023_geolocation2 -Dsonar.projectName=Geolocation2'   
               }
          }
        }
        stage('Code Build') {
            steps {
                sh 'mvn clean install package'
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

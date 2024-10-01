pipeline {   
    agent any
    tools {
        maven 'maven-3.9'
    }
    stages {
       
        stage("Increment Version") {
            steps {
                script {
                    echo "Increment Version"
                }
            }
        }

        stage("build") {
            steps {
                script {
                    echo "Building the application...."
                    sh 'mvn clean package'
                }
            }
        }

        stage("build docker image") {
            steps {
                script {
                    echo "building the docker image...."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t moonshine42/devops-exercise-8:$IMAGE_NAME ."
                        sh "echo '$PASS' | docker login -u '$USER' --password-stdin"
                        sh "docker push moonshine42/devops-exercise-8:$IMAGE_NAME"
                    }
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "Deploying the application...."
                }
            }
        }               
    }
} 
pipeline {   
    agent any
    stages {
       
        stage("Initialice") {
            steps {
                script {
                    echo "Initialice the pipeline...."
                    sh 'apt install nodejs npm -y'
                }
            }
        }

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
                    sh 'npm install'
                }
            }
        }

        stage("run tests") {
            steps {
                script {
                    echo "Testing the application...."
                    sh 'npm run test'
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

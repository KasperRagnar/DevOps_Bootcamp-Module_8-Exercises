pipeline {   
    agent any
    tools {
        nodejs 'my-nodejs 20.6.0'
    }
    stages {
       
        stage("Initialice") {
            steps {
                script {
                    echo "Initialice the pipeline...."
                    //sh 'apt install nodejs'
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
                    sh 'npm install ./app'
                }
            }
        }

        stage("run tests") {
            steps {
                script {
                    echo "Testing the application...."
                    //sh 'npm run server.test.js'
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

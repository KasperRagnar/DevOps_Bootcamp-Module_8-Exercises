def gv

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

                    // scho "install NodeJS"
                    // sh 'apt install nodejs'

                    // installs dependencies
                    //sh 'npm install'
                }
            }
        }

        stage("Increment Version") {
            steps {
                script {
                    echo "increment the application 'patch' version...."

                    // Increment NPM version in package.json
                    //sh 'npm version major'
                    //sh 'npm version minor'
                    sh 'npm version patch'


                    // get current NPM version
                    //def NPM_VERSION = sh(returnStdout: true, script: 'npm pkg get version')
                    def NPM_VERSION = sh 'npm pkg get version'

                    // make new version numbers
                    env.IMAGE_NAME = "$NPM_VERSION-$BUILD_NUMBER"

                    echo "NPM_VERSION = $NPM_VERSION"
                    echo "BUILD NUMBER = $BUILD_NUMBER"
                    echo "IMAGE_NAME = $IMAGE_NAME"
                }
            }
        }

        // stage("build") {
        //     steps {
        //         script {
        //             echo "Building the application...."
        //             //sh 'npm install ./app'
        //         }
        //     }
        // }

        // stage("run tests") {
        //     steps {
        //         script {
        //             echo "Testing the application...."
        //             //sh 'npm run server.test.js'
        //         }
        //     }
        // }

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

        // stage("deploy") {
        //     steps {
        //         script {
        //             echo "Deploying the application...."
        //         }
        //     }
        // }               
    }
} 

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
                    // Change work directory
                    sh 'pwd'
                    sh 'ls'
                    sh 'cd app'
                    sh 'ls'

                    // display current version
                    def CURRENT_NPM_VERSION = sh 'npm pkg get version'
                    echo "CURRENT_NPM_VERSION = $CURRENT_NPM_VERSION"

                    echo "increment the application version in package.json...."
                    //sh 'npm version major'
                    //sh 'npm version minor'
                    sh 'npm version patch'

                    // get updated NPM version
                    def NEW_NPM_VERSION = sh 'npm pkg get version'

                    echo "NEW_NPM_VERSION = $NEW_NPM_VERSION"
                    echo "BUILD NUMBER = $BUILD_NUMBER"

                    // make new version numbers
                    env.IMAGE_NAME = "$NEW_NPM_VERSION-$BUILD_NUMBER"
                    echo "IMAGE_NAME = $IMAGE_NAME"

                    // Commit version changes to git
                    sh 'git add .'
                    sh "git comit -m 'jenkins - increment application version'"
                    sh 'git push'
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

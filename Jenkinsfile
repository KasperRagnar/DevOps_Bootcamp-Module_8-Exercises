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
                    //sh 'apt install nodejs'
                }
            }
        }

        stage("Increment Version") {
            steps {
                script {
                    echo "increment the application 'patch' version...."

                    // get current version
                    def current_npm_version = sh(returnStdout: true, script: 'npm pkg get version')
                    echo "$current_npm_version"
                    // define version numbers
                    def major = $current_npm_version[1]
                    def minor = $current_npm_version[3]
                    def patch = $current_npm_version[5]

                    echo "major = $major"
                    echo "minor = $minor"
                    echo "patch = $patch"

                    // increments version number
                    def new_patch = sh(returnStdout: true, script: '$patch = $(($patch + 1))')

                    echo "new_patch = $new_patch"

                    // make new version numbers
                    def new_npm_version = "$major.$minor.$new_patch"
                    env.IMAGE_NAME = "$NEW_NPM_VERSION-$BUILD_NUMBER"

                    echo "new_npm_version = $new_npm_version"
                    echo "IMAGE_NAME = $IMAGE_NAME"
                    
                    // update application version number
                    sh "npm version $NEW_NPM_VERSION"
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

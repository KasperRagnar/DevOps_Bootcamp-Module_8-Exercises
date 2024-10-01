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
                    $CURRENT_NPM_VERSION = sh(returnStdout: true, script: 'npm pkg get version')
                    echo "$CURRENT_NPM_VERSION"
                    // define version numbers
                    $major = $CURRENT_NPM_VERSION[1]
                    $minor = $CURRENT_NPM_VERSION[3]
                    $patch = $CURRENT_NPM_VERSION[5]

                    echo "major = $major"
                    echo "minor = $minor"
                    echo "patch = $patch"

                    // increments version number
                    $NEW_PATCH = sh(returnStdout: true, script: '$patch = $(($patch + 1))')

                    echo "NEW_PATCH = $NEW_PATCH"

                    // make new version numbers
                    $NEW_NPM_VERSION = "$major.$minor.$NEW_PATCH"
                    env.IMAGE_NAME = "$NEW_NPM_VERSION-$BUILD_NUMBER"

                    echo "NEW_NPM_VERSION = $NEW_NPM_VERSION"
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

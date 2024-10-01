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
                    $CURRENT_NPM_VERSION = $(node -p -e "require('./package.json').version")

                    // define version numbers
                    $major = $CURRENT_NPM_VERSION[0]
                    $minor = $CURRENT_NPM_VERSION[2]
                    $patch = $CURRENT_NPM_VERSION[4]

                    // increments version number
                    sh "$patch = $(($patch + 1))"

                    // make new version number
                    $NEW_NPM_VERSION = "$major.$minor.$patch"
                    env.IMAGE_NAME = "$NEW_NPM_VERSION-$BUILD_NUMBER"
                    
                    // update version number
                    sh "npm version $IMAGE_NAME"
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

def versionTools

pipeline {   
    agent any
    tools {
        nodejs 'my-nodejs 20.6.0'
    }
    stages {
       
        stage("Initialice") {
            steps {
                dir('app') { 
                    script {
                        echo "Initialice the pipeline...."

                        // initialize a groovy script af gv
                        versionTools = load "../scripts/versionTools.groovy"
                    }
                }
            }
        }

        stage("Increment Version") {
            steps {
                // Change work directory
                dir('app') { 
                    script {
                        // display current version
                        def CURRENT_NPM_VERSION = versionTools.getPackageVersionNumber()
                        echo "CURRENT_NPM_VERSION = ${CURRENT_NPM_VERSION}"


                        // increment current version
                        echo "increment the application version in package.json...."
                        //sh 'npm version major'
                        //sh 'npm version minor'
                        sh 'npm version patch'


                        // display incremented version
                        def NEW_NPM_VERSION = versionTools.getPackageVersionNumber()
                        echo "NEW_NPM_VERSION = ${NEW_NPM_VERSION}"

                        // display current build number
                        echo "BUILD NUMBER = $BUILD_NUMBER"

                        // make new version numbers
                        env.IMAGE_NAME = "$NEW_NPM_VERSION-$BUILD_NUMBER"
                        echo "IMAGE_NAME = $IMAGE_NAME"

                        // Commit version changes to git
                        sh 'git add .'
                        sh "git commit -m 'jenkins - increment application version'"
                        sh 'git push'
                    }
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

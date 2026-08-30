pipeline {
    agent none

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'fil-rouge-build:1.1'
                    args '-u root'
                }
            }
            steps {
                sh 'composer install --no-interaction --prefer-dist'
                sh 'npm ci'
                sh 'npm run build'
                sh 'cp .env.example .env'
                sh 'php artisan key:generate'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'fil-rouge-build:1.1'
                    args '-u root'
                }
            }
            steps {
                sh 'php artisan test --log-junit storage/logs/junit.xml || true'
            }
            post {
                always { junit 'storage/logs/junit.xml' }
            }
        }

        stage('Quality') {
            agent {
                docker {
                    image 'fil-rouge-build:1.1'
                    args '-u root'
                }
            }
            steps {
                sh 'composer audit || true'
                sh 'npm audit --audit-level=high || true'
                sh 'vendor/bin/phpstan analyse --error-format=raw'
            }
        }

        stage('Docker Build & Push') {
            agent any
            steps {
                script {
                    env.IMAGE_TAG = "${BUILD_NUMBER}-" + sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                }
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'docker build -t $DOCKER_USER/fil-rouge-app:$IMAGE_TAG .'
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_USER/fil-rouge-app:$IMAGE_TAG'
                }
            }
        }
    }
}
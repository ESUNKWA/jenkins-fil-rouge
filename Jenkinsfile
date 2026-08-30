pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:/usr/bin:${env.PATH}"
    }
    stages {
        stage('Build') {
            steps {
                sh 'which composer && which node'
                sh 'composer install --no-interaction --prefer-dist'
                sh 'npm ci'
                sh 'npm run build'
            }
        }
    }
}
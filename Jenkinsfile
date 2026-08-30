pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/usr/bin:${env.PATH}"
    }

    stages {
        stage('Build') {
            steps {
                sh 'echo "PATH=$PATH"'
                sh 'id'
                sh 'ls -la /usr/local/bin || true'
                sh 'composer install --no-interaction --prefer-dist'
                sh 'npm ci'
                sh 'npm run build'
            }
        }
    }
}
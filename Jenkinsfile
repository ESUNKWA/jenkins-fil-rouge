pipeline {
    agent any
    stages {
        stage('Checkout Info') {
            steps {
                sh 'echo "Contenu du workspace après checkout :"'
                sh 'ls -la'
                sh 'git log -1 --oneline'
                sh 'git status'
                sh 'echo "Contenu du workspace après checkout :"'
            }
        }
    }
}
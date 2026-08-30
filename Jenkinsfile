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
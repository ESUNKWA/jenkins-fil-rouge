   pipeline {
       agent any
       stages {
           stage('Build') {
               steps {
                   sh 'composer install --no-interaction --prefer-dist'
                   sh 'npm ci'
                   sh 'npm run build'
               }
           }
       }
   }
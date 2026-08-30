   pipeline {
       agent {
           docker {
               image 'fil-rouge-build:1.0'
               args '-u root'
           }
       }
       stages {
           stage('Build') {
               steps {
                   sh 'composer install --no-interaction --prefer-dist'
                   sh 'npm ci'
                   sh 'npm run build'
                   sh 'cp .env.example .env'
                   sh 'php artisan key:generate'
               }
           }
           stage('Test') {
               steps {
                   sh 'php artisan test --log-junit storage/logs/junit.xml || true'
               }
               post {
                   always { junit 'storage/logs/junit.xml' }
               }
           }
           stage('Quality') {
               steps {
                   sh 'composer audit || true'
                   sh 'npm audit --audit-level=high || true'
                   sh 'vendor/bin/phpstan analyse --error-format=raw'
               }
           }
       }
   }
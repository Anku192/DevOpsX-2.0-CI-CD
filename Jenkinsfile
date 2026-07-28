pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                bat '"C:\\Users\\Prashanth\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install -r app\\requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                bat '"C:\\Users\\Prashanth\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest app\\tests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t devopsx2-app:1.0 .'
            }
        }

        stage('Docker Login and Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    bat '''
                        echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
                        docker tag devopsx2-app:1.0 %DOCKER_USERNAME%/devopsx2-app:1.0
                        docker push %DOCKER_USERNAME%/devopsx2-app:1.0
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'DevOpsX 2.0 CI/CD Pipeline completed successfully!'
        }

        failure {
            echo 'DevOpsX 2.0 CI/CD Pipeline failed!'
        }
    }
}
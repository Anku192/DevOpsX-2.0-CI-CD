pipeline {
    agent any

    environment {
        IMAGE_NAME = "ankurpb/devopsx2-app:1.0"
    }

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
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    bat '''
                    if "%DOCKER_PASSWORD%"=="" (
                        echo PASSWORD IS EMPTY
                        exit /b 1
                    ) else (
                        echo PASSWORD RECEIVED
                    )
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                bat 'docker push %IMAGE_NAME%'
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
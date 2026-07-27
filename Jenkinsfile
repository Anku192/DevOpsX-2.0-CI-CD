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
    }

    post {
        success {
            echo 'DevOpsX 2.0 CI Pipeline completed successfully!'
        }

        failure {
            echo 'DevOpsX 2.0 CI Pipeline failed!'
        }
    }
}
node {
    stage('Get Source'){
        git 'https://github.com/Kirtigup/CloudRepo.git'
        
    }
    stage('Docker-build'){
        sh 'docker build -t kirtigupta123456/my-app'
    }
    stage('Docker-push'){
        docker.withRegistry('https://registry.hub.docker.com','DockerIdentity'){
            def customImage = docker.build('kirtigupta123456/my-app')
            customImage.push()
        }
    }
    stage('Kubernetes pod'){
        sh 'kubectl apply -f servicepy.yaml'
        sh 'kubectl apply -f flask-deployment.yaml'
        sh 'kubectl get pods'
    }
}

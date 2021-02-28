node {
    stage('Get Source'){
        git 'https://github.com/rtxverma123/flaskrunkubernetes.git'
        
    }
    stage('Docker-build'){
        sh 'docker build -t rtxverma123/bootstrapkubernetesflask .'
    }
    stage('Docker-push'){
        docker.withRegistry('https://registry.hub.docker.com','Docker'){
            def customImage = docker.build('rtxverma123/bootstrapkubernetesflask')
            customImage.push()
        }
    }
    stage('Kubernetes pod'){
        sh 'kubectl apply -f servicepy.yaml'
        sh 'kubectl apply -f flask-deployment.yaml'
        sh 'kubectl get pods'
    }
}

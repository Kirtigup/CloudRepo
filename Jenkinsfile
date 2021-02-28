pipeline{
  
  environment{
    
  IBM_CLOUD_REGION='eu-de'
  REGISTRY_HOSTNAME='de.icr.io'
  IKS_CLUSTER='c0sf25ud0fesivtjm07g'
  DEPLOYMENT_NAME='samikaaaiks-jar'
  PORT='5000'
  }
  agent any
    tools {
              maven 'jenkins-maven'
          }
  stages {
            stage('Build'){
                            steps{
                                   sh 'mvn -B -DskipTests clean package'
                                 }
                          }
              stage('Test'){
                            steps{
                                   sh 'mvn test'
                                 }
              
                            post {
                                always {
                                          junit 'target/surefire-reports/TEST-hello.GreeterTest.xml'
                                       }
                                }
                            }
               stage('Install IBM cloud CLI'){
    
                        steps{
                             sh '''
                                     curl -fsSL https://clis.cloud.ibm.com/install/linux | sh 
                                      ibmcloud --version
                                      ibmcloud config --check-version=false
                                      ibmcloud plugin install -f kubernetes-service
                                      ibmcloud plugin install -f container-registry
                                '''
                              }
                          }
    
              stage('Authenticate with IBM cloud CLI'){
      
                         steps{
                                  sh '''
                                       ibmcloud login --apikey ${IBM_API_KEY} -r "${IBM_CLOUD_REGION}" -g Default
                                      ibmcloud ks cluster config --cluster ${IKS_CLUSTER}
                                      
                                      '''
                               }
      
      
                       }
    
    
              stage('Build-Docker-image with Docker'){
                                   
                                   steps{
                                            sh 'docker build -t samrika26/ibm_java_app":$BUILD_NUMBER" .'
                                        }
                                  
                  }
                                  
              stage('Push-Docker_image-DockerHub'){
              
                                   steps{
                                               withDockerRegistry([credentialsId: "dockerhub_id",url:""])
                                               {sh 'docker push samrika26/ibm_java_app":$BUILD_NUMBER"'
                                               }
                                       }
                                  }
                                                                              
               stage('Deploy_to_IKS'){
                                                                             
                                        steps{
                                                    sh '''
                                                    
                                                           ibmcloud ks cluster config --cluster ${IKS_CLUSTER}
                                                           kubectl config current-context
                                                           kubectl create deployment ${DEPLOYMENT_NAME} --image=samrika26/ibm_java_app:$BUILD_NUMBER --dry-run=client -o yaml>deployment.yaml
                                                           kubectl apply -f deployment.yaml
                                                           kubectl rollout status deployment/${DEPLOYMENT_NAME}
                                                           kubectl create service loadbalancer ${DEPLOYMENT_NAME} --tcp=80:${PORT} --dry-run=client -o yaml>service.yaml
                                                           kubectl apply -f service.yaml
                                                           kubectl get services -o wide
                                                       '''
                                             }
               
                                     }                                                                
           
           
           }
  

}

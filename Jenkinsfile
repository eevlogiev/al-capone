pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = "767397771039"
        AWS_REGION = "us-east-1"
        REPO_NAME = "al-capone"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        CLUSTER_NAME = "al-capone-cluster"
        SERVICE_NAME = "al-capone-service"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/eevlogiev/al-capone.git'
            }
        }

        stage ("Build Docker image") {
        steps {
            sh '''
            docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG} .
            '''
        }
    }
    //     stage ("Test") {
    //     steps {
    //         sh '''
    //         port=$(shuf -i 2000-10000 -n 1)
    //         docker run -dit -p $port:5000 ${image_name}:$GIT_COMMIT
    //         sleep 5
    //         curl http://localhost:$port
    //         exit_status=$?
    //         if [[ $exit_status == 0 ]]
    //         then echo "TEST OK" && docker stop $(docker ps -a -q)
    //         else echo "TEST FAILED" && docker stop $(docker ps -a -q) && exit 1
    //         fi
    //         '''
    //     }
    // }
        stage('Login to AWS ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }

        stage ("Push image to ECR") {
            steps {
                sh '''
                docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                '''
             }
        }
        stage ("Deploy to ECS") {
            steps {
                sh '''
                aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment \
                --region ${AWS_REGION} --output json
                '''
            }
        }
       
    }
}
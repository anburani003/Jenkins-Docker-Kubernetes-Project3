pipeline {
    agent any
	tools {
		maven 'Maven'
	}
	
	environment {
		PROJECT_ID = 'spry-ether-410313'
                CLUSTER_NAME = 'cluster-1'
                LOCATION = 'us-central1-c'
                CREDENTIALS_ID = 'kubernetes'		
	}
	
    stages {
	    stage('Scm Checkout') {
		    steps {
			    checkout scm
		    }
	    }
	    
	    stage('Build') {
		    steps {
			    sh 'mvn clean package'
		    }
	    }
	    
	    stage('Test') {
		    steps {
			    echo "Testing..."
			    sh 'mvn test'
		    }
	    }
	    
	    stage('Build Docker Image') {
		    steps {
			    sh 'whoami'
			    script {
				    myimage = docker.build("anbuvanitha/prod:${env.BUILD_ID}")
			    }
		    }
	    }
	    
        stage("Push Docker Image") {
            steps {
                script {
                    echo "Push Docker Image"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        // Use DOCKERHUB_USERNAME and DOCKERHUB_PASSWORD as needed
                        myimage.push("${env.BUILD_ID}")
                    }
                }
            }
        }

	    stage('Deploy to K8s') {
	        steps {
	            echo "Deployment started ..."
	            sh 'ls -ltr'
	            sh 'pwd'
	            sh "sed -i 's/tagversion/${env.BUILD_ID}/g' serviceLB.yaml"
	            sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml"
	            
	            echo "Applying serviceLB.yaml"
	            sh "kubectl apply -f serviceLB.yaml"
	            echo "Applying deployment.yaml"
	            sh "kubectl apply -f deployment.yaml"
	            
	            echo "Deployment Finished ..."
	        }
        }

    }
}

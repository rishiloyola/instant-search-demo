pipeline {
    agent {
        docker {
            image 'node:6-alpine' 
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') { 
            steps {
                sh 'docker build -t algolia-test .'
		sh 'docker build -t algolia-prod .' 
            }
            post {
        	failure {
            		echo 'This build has failed. See logs for details.'
        	}
      	    }
	}
	stage('Test') {
		steps {
			sh 'docker run --name nodeapp-dev -d algolia-test'
		}
		post {
       			success {
            			echo 'Test run succeeded.'
				sh 'docker stop nodeapp-dev'
				sh 'docker rm nodeapp-dev'
        		}
        		unstable {
            			echo 'This docker run returned an unstable status.'
        		}
        		failure {
            			echo 'This docker run has failed. See logs for details.'
        		}
      		}
	}
	stage('Deliver') {
            steps {
		sh 'docker stop nodeapp-prod'
		sh 'docker rm nodeapp-prod'
		sh 'docker system prune -f'
                sh 'docker run --name nodeapp-prod -p 3000:3000 -d algolia-prod'
            }
	    post {
	    	failure {
			sh 'docker stop nodeapp-prod'
			sh 'docker rm nodeapp-prod'
			sh 'docker system prune -f'
		}
	    }
        }

    }
}

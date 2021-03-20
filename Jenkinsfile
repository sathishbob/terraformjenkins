  pipeline {
    agent any
	tools {
	terraform 'terraform'
    }
    parameters {
    choice(
      name: 'choice',
      choices: ['apply', 'destroy'],
      description: 'Passing the choice'
     )
    }
    stages {
      stage('TF Init&Plan') {
        steps {
            script {
        if ("${params.choice}" == "apply") {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_access_key', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
		sh '''
		export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
		export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
		export AWS_DEFAULT_REGION="us-east-1"
        terraform init
        terraform plan
		  ''' 
           }
        }
        else {
                   echo "destroy the ec2 instance"
                }
            }
         }      
      }

      stage('Approval') {
        steps {
          script {
            def userInput = input(id: 'confirm', message: 'Apply / destroy Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply / destroy terraform', name: 'confirm'] ])
          }
        }
      }

      stage('TF Apply') {
        steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_access_key', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
		sh '''	export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
		export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
		export AWS_DEFAULT_REGION="us-east-1"
        terraform $choice -auto-approve'''
          }
        }
      }
    } 
  }

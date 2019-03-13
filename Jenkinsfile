pipeline {
  environment {
    localRegistry = 'registry.continuous-delivery:5000'
    imageName = 'kafka'
  }

  agent {
    label 'docker'
  }

  stages {
    stage('build image') {
      steps {
        script {
          container('docker') {
            dockerImage = docker.build localRegistry + '/' + imageName
          }
        }
      }
    }
    stage('push image ') {
      steps {
        script {
          container('docker') {
            dockerImage.push('snapshot')
          }
        }
      }
    }
  }
}

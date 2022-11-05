pipeline {
    agent any

    stages {
        stage('pull code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/${branch}']], extensions: [], userRemoteConfigs: [[credentialsId: 'ssh-auth', url: 'git@192.168.175.134:it_group/web_demo.git']]])
            }
        }
        stage('build project') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('publish project') {
            steps {
                echo 'publish project'
            }
        }

    }
    post {
        always {
            emailext( subject: '构建通知：${PROJECT_NAME} - Build # ${BUILD_NUMBER} -${BUILD_STATUS}!',
            mimeType: 'text/html',
                body: '''${FILE,path="abc"}''', to: '1162025261@qq.com'
            )
        }
    }
}

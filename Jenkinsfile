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
        stage('code check'){
            script{
                sonarHome= tool 'sonar-scanner'  //获取sonar-scanner工具
            }
            withSonarQubeEnv('sonar'){
                sh "${sonarHome}/bin/sonar-scanner"
            }
        }

    }
    post {
        always {
            emailext( subject: '构建通知：${PROJECT_NAME} - Build # ${BUILD_NUMBER} -${BUILD_STATUS}!',
            mimeType: 'text/html',
                body: '''${FILE,path="email.html"}''', to: '1162025261@qq.com'
            )
        }
    }
}

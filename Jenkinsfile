def git_url = "git@192.168.175.134:it_group/web_demo.git"
def harbor_url = "192.168.175.134:85"
def harbor_project="library"
def currentProjectName ="webdemo"
def tag = "1.0-SNAPSHOT"
def currentProjectPort=9999

pipeline {
    agent any

    stages {
        stage('pull code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/${branch}']], extensions: [], userRemoteConfigs: [[credentialsId: 'ssh-auth', url: "${git_url}"]]])
            }
        }
        stage('build project') {
            steps {
                sh 'mvn clean package dockerfile:build dockerfile:push'
            }
        }
        stage('publish project') {
            steps {
                echo 'publish project'
                sshPublisher(publishers: [sshPublisherDesc(configName: "192.168.175.130", transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "/home/deploy/deploy.sh $harbor_url $harbor_project $currentProjectName $tag $currentProjectPort", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
//        stage('code check') {
//            steps {
//                script {
//                    sonarHome = tool 'sonar-scanner'  //获取sonar-scanner工具
//                }
//                withSonarQubeEnv('sonar') {
//                    sh "${sonarHome}/bin/sonar-scanner"
//                }
//            }
//        }

    }

    post {
        always {
            emailext(
                    subject: '构建通知：${PROJECT_NAME} - Build # ${BUILD_NUMBER} -${BUILD_STATUS}!',
                    mimeType: 'text/html',
                    body: '''${FILE,path="email.html"}''', to: '1162025261@qq.com'
            )
        }
    }
}

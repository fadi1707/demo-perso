pipeline {

    agent { label "master" }

    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {
        // Stage conf to setup environment variable for build
        stage("conf") {
            steps {
                script {
                    def pom = readMavenPom file: 'pom.xml'
                    env['PROJ'] = pom.artifactId
                    def inventory = readTrusted 'deployment/inventory'
                    env['SERVER_IP'] = inventory.split('\n')[1]
                }
            }
        }
        // Building the artifacts
        stage("build") {
            agent {
                docker {
                    image "maven:3-jdk-8-slim"
                    args "-v \$HOME/.m2:/root/.m2"
                }
            }
            steps {
                sh 'mvn --version'
                sh 'mvn clean install -ntp -B -e'
                // Using stash to copy from downstream agent to upstream agent
                stash includes: 'target/demo.jar', name: 'demo-jar'
            }
        }

        // building the image locally
        stage("build img") {
            steps {
                unstash 'demo-jar'
                script {
                    env["IMAGE"] = "${env.PROJ}:${env.BRANCH_NAME}.${env.BUILD_ID}"
                    def customImage = docker.build(env["IMAGE"])
                    sh "docker save -o deployment/${env["IMAGE"]}.tar ${env["IMAGE"]}"
                }
            }
        }

        stage("deploy") {
            when {
                branch "release*"
            }
            agent {
                dockerfile {
                    filename 'ansible_Dockerfile'
                    dir 'deployment'
                    args '-v /home/ec2-user/.ansible:/home/centos/.ansible'
                }
            }
            steps {
                script {
                    ansiblePlaybook(
                            playbook: 'deployment/deploy.yml',
                            inventory: 'deployment/inventory',
                            colorized: true,
                            extras: "-e image=${env.IMAGE} " +
                                    "-e server_ip=${env.SERVER_IP} " +
                                    "-e project_name=${env.PROJ} " +
                                    "-vv",
                            credentialsId: 'test-key'
                    )
                }
            }
        }

        stage("test-deployment") {
            when {
                branch "release*"
            }
            steps {
                script {
                    sleep 30
                    sh "curl http://${env.SERVER_IP}:8080/greeting?name=katsok"
                }
            }
        }

    }
    post {
        always {
            script {
                def status = "${env.BUILD_TAG} - ${currentBuild.currentResult}"
                def body = """
Build: ${currentBuild.displayName}
Result: ${currentBuild.currentResult}
"""
                mail body: body, subject: status, to: 'katsok@personetics.com'
            }
        }
    }
}

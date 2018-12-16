// update docker hub build

node('') {

    currentBuild.result = "SUCCESS"
    service_name = 'docker-cyberchef-ci'

    env.GIT_COMMITTER_NAME="Martijn Pepping"
    env.GIT_COMMITTER_EMAIL="martijn.pepping@automiq.nl"
    env.GIT_AUTHOR_NAME="Martijn Pepping"
    env.GIT_AUTHOR_EMAIL="martijn.pepping@automiq.nl"

    try {

      stage('Checkout'){ checkout scm }

      stage('Update docker-cyberchef'){
        sh "bash update-releases.sh"
      }

      stage('Commit and Push'){
        sshagent(['0787eef6-cb0e-4904-87ef-8ee1e4723b60']) {
          sh """
            if [ "`git log origin/master..master`" != "" ]; then  
              git push
            fi
            """
        }
      }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }
}


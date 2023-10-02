import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstanceOrNull()

if (instance) {
    def jenkinsUser = System.getenv('JENKINS_USER') ?: 'admin'
    def jenkinsPass = System.getenv('JENKINS_PASS') ?: 'admin'
  
    def hudsonRealm = new HudsonPrivateSecurityRealm(false)
    hudsonRealm.createAccount(jenkinsUser, jenkinsPass)
    instance.setSecurityRealm(hudsonRealm)
  
    def strategy = new GlobalMatrixAuthorizationStrategy()
    strategy.add(Jenkins.ADMINISTER, jenkinsUser)
    instance.setAuthorizationStrategy(strategy)
  
    instance.save()
} else {
    println("Jenkins instance is not ready yet.")
}

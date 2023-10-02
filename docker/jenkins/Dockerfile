FROM jenkins/jenkins:lts

# Skip initial setup
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Create admin user
ENV JENKINS_USER=admin
ENV JENKINS_PASS=admin

# Install default plugins + OIDC and Nomad
RUN jenkins-plugin-cli --plugins \
  antisamy-markup-formatter:latest \
  build-timeout:latest \
  credentials-binding:latest \
  email-ext:latest \
  github-branch-source:latest \
  gradle:latest \
  ldap:latest \
  matrix-auth:latest \
  pam-auth:latest \
  role-strategy:latest \
  script-security:latest \
  ssh-slaves:latest \
  timestamper:latest \
  ws-cleanup:latest \
  oidc-provider:latest \
  workflow-aggregator:latest \
  nomad:latest

# Add default user
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

#!/bin/bash

# Get absolute path of the current script's directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Build Jenkins image with custom plugins and auto-bootstrap
docker build -t jenkins:demo $DIR/docker/jenkins/

# Start Nomad in dev mode with custom config in the background
nomad agent -dev &

# Nomad PID
NOMAD_PID=$!

# Wait for Nomad to become available
while true; do
  if curl --silent --output /dev/null --fail --head http://127.0.0.1:4646; then
    break
  else
    echo "Waiting for Nomad to start..."
    sleep 1
  fi
done

# Run the Vault job
nomad job run $DIR/nomad_jobs/vault.hcl

# Run the Jenkins job
nomad job run $DIR/nomad_jobs/jenkins.hcl

# Keep the script running to keep Nomad in the foreground
wait $NOMAD_PID

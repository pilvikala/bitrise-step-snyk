#!/bin/bash
set -ex

npm install -g snyk

snyk auth ${auth_token}



snyk ${command} --severity-threshold=${severity_threshold} --fail-on-issues=${fail_on_issues}

if [["${monitor}" == "true"]]; then
    snyk monitor
fi

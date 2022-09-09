#!/bin/bash
set -ex
set -o pipefail

run_test()
{
  if [[ "$3" == "yes" ]]; then
    snyk $1 --severity-threshold=$2 $4 $5 --json | snyk-to-html -o $BITRISE_DEPLOY_DIR/snyk_report.html
  else
    snyk $1 --severity-threshold=$2 $4 $5
  fi
}

packages="snyk"

if [[ "${create_report}" == "yes" ]]; then
  packages="snyk snyk-to-html"
  export SNYK_REPORT_PATH="${PWD}/snyk_report.html"
fi

npm install --location=global ${packages}

if [[ ${command} != "test_this_step" ]]; then
  snyk auth ${auth_token}
else
  snyk -v
  snyk help
  exit 0
fi

target_file_arg=""
org_arg=""

[[ ! -z "$target_file" ]] && target_file_arg="--file=${target_file}"
[[ ! -z "$organization" ]] && org_arg="--org=${organization}"

if [[ "${fail_on_issues}" == "yes" ]]; then
    run_test ${command} ${severity_threshold} ${create_report} ${target_file_arg} ${additional_arguments}
else
    run_test ${command} ${severity_threshold} ${create_report} ${target_file_arg} ${additional_arguments} || true
fi

if [[ "${monitor}" == "yes" ]]; then
    snyk monitor ${target_file_arg} ${org_arg} ${additional_arguments}
fi

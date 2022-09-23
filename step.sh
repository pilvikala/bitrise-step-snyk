#!/bin/bash
set -ex
set -o pipefail

run_test()
{
  command=$1
  sev_threshold=$2
  create_report=$3
  target_file_arg=$4
  additional_arguments=$5
  if [[ "$create_report" == "yes" ]]; then
    snyk $command --severity-threshold=$sev_threshold $target_file_arg $additional_arguments --json | snyk-to-html -o $BITRISE_DEPLOY_DIR/snyk_report.html
  else
    snyk $command --severity-threshold=$sev_threshold $target_file_arg $additional_arguments
  fi
}

if [[ ${command} != "test_this_step" ]]; then
  snyk auth ${auth_token}
else
  ./run_tests.sh
  exit $?
fi

packages="snyk"

if [[ "${create_report}" == "yes" ]]; then
  packages="snyk snyk-to-html"
fi

npm install --location=global ${packages}

target_file_arg=""
org_arg=""

[[ ! -z "$target_file" ]] && target_file_arg="--file=${target_file}"
[[ ! -z "$organization" ]] && org_arg="--org=${organization}"

if [[ "${fail_on_issues}" == "yes" ]]; then
    run_test "${command}" ${severity_threshold} ${create_report} ${target_file_arg} ${additional_arguments}
else
    run_test "${command}" ${severity_threshold} ${create_report} ${target_file_arg} ${additional_arguments} || true
fi

if [[ "${monitor}" == "yes" ]]; then
    snyk monitor ${target_file_arg} ${org_arg} ${additional_arguments}
fi

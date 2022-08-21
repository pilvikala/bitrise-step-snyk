#!/bin/bash
set -ex

run_test()
{
    snyk $1 --severity-threshold=$2 $3 $4
}

npm install --location=global snyk

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
    run_test ${command} ${severity_threshold} ${target_file_arg} ${additional_arguments}
else
    run_test ${command} ${severity_threshold} ${target_file_arg} ${additional_arguments} || true
fi

if [[ "${monitor}" == "yes" ]]; then
    snyk monitor ${target_file_arg} ${org_arg} ${additional_arguments}
fi

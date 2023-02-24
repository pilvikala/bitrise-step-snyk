source .env
if [[ -z $SNYK_AUTH_TOKEN ]]; then
    echo "SNYK_AUTH_TOKEN is not set"
    exit 1
fi

command=test
severity_threshold=low
fail_on_issues=yes
create_report=no
monitor=no
target_file=tests/test-data/package-lock.json
organization=

auth_token=$SNYK_AUTH_TOKEN command=$command severity_threshold=$severity_threshold fail_on_issues=$fail_on_issues create_report=$create_report monitor=$monitor target_file=$target_file organization=$organization ./step.sh
exit_code=$?
if [[ $exit_code -ne 1 ]]; then
    echo "Failed Snyk Test test. Returned code: $exit_code"
    exit 1
else
    echo "Test passed"
    exit 0
fi
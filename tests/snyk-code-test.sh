source .env
if [[ -z $SNYK_AUTH_TOKEN ]]; then
    echo "SNYK_AUTH_TOKEN is not set"
    exit 1
fi

command="code test"
severity_threshold=low
fail_on_issues=true
create_report=no
monitor=no
target_file=
organization=

auth_token=$SNYK_AUTH_TOKEN command=$command severity_threshold=$severity_threshold fail_on_issues=$fail_on_issues create_report=$create_report monitor=$monitor target_file=$target_file organization=$organization ./step.sh

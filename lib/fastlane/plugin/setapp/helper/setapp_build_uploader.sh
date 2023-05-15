#!/bin/sh

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

function help() {
    echo "
    USAGE
        $(basename "${BASH_SOURCE[0]}") [options...]

    OPTIONS
        -t, --token
            Your Setapp Automation token for continious integration. 

        -p, --path
            Path to an archive with a new bundle version.

        -n, --notes
            Release notes for a new version. Add them as a plain text or as a path to file with text.

        -s, --status
            Choose a status for the build. You can save a new uploaded version as a draft and manage it from your Developer Account,
            or you can send it on a review.
            Available options: (draft/review)

        -r, --release-on-approval
            Indicate whether Setapp must publish a new version automatically after review approval.
            Available options: (true/false)

        -b | --beta
            Is beta or stable build.
            Available options: (true/false)
        
        -a | --allow-overwrite
            Can ovewrite existing version, including release notes and archive. 
            Available options: (true/false)

        -h, --help
            Usage help
    "
    exit 0
}

function parse_params() {
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h| --help)
                help
                exit 0
                ;;
            -t | --token)
                if test $# -gt 0; then
                    automation_token="${1}"
                fi
                shift;;
            -p | --path)
                if test $# -gt 0; then
                    archive_path="${1}"
                fi
                shift;;
            -n | --notes)
                if test $# -gt 0; then
                    release_notes="${1}"
                    if [[ -f "$release_notes" ]]; then
                        release_notes=$(cat "${release_notes}")
                    fi
                fi
                shift;;
            -s | --status)
                if test $# -gt 0; then
                    version_status="${1}"
                fi
                shift;;
            -r | --release-on-approval)
                if test $# -gt 0; then
                    release_on_approval="${1}"
                fi
                shift;;
            -b | --beta)
                if test $# -gt 0; then
                    beta="${1}"
                fi
                shift;;
            -a| --allow-overwrite)
                if test $# -gt 0; then
                    allow_overwrite="${1}"
                fi
                shift;;
            *)
                die "Invalid parameter was provided: $param" 1
                ;;
        esac
    done
}

function check_parameters() {
    [[ -z "${automation_token}" ]] && die "Missing required parameter: token"
    [[ -z "${archive_path}" ]] && die "Missing required parameter: path"
    [[ -z "${release_notes}" ]] && die "Missing required parameter: notes"
    [[ -z "${version_status}" ]] && die "Missing required parameter: status"
    [[ -z "${release_on_approval}" ]] && die "Missing required parameter: release-on-approval"
    [[ -z "${beta}" ]] && die "Missing required parameter: beta"
    [[ -z "${allow_overwrite}" ]] && die "Missing required parameter: allow-ovewrite"
}

function validate_server_response() {
    local server_response="${1}"
    local response_code=${server_response##*HTTPSTATUS:}
    local response_body=$(echo ${server_response%%HTTPSTATUS*})

    if [ "$response_code" -ge 200 ] && [ "$response_code" -lt 300 ]; then
        echo "✅ The app version is uploaded. All checks are passed."
    elif [ $response_code -eq 401 ]; then
        die "⚠️ Something went wrong with your Setapp Automation token.\n${response_body}"
    elif [ $response_code -eq 400 ]; then
        die "🚨 Bundle validation error occured. See details in description below.\n${response_body}"
    else 
        die "⛔️ Something went wrong. Server returned $response_code. See details in description below.\n${response_body}"
    fi
}

function create_or_overwrite_existing_app_version() {
    response=$(
        curl -X POST "https://developer-api.setapp.com/v1/ci/version" \
        --write-out "HTTPSTATUS:%{http_code}" \
        -H "Authorization: Bearer ${automation_token}" \
        -H "accept: application/json" \
        -H "Content-Type: multipart/form-data" \
        -F "release_notes=${release_notes}" \
        -F "status=${version_status}" \
        -F "release_on_approval=${release_on_approval}" \
        -F "beta=${beta}" \
        -F "allow_overwrite=${allow_overwrite}" \
        -F "archive=@${archive_path};type=application/zip"
    )
    validate_server_response "${response}"
}

function main() {
    parse_params "$@"
    check_parameters
    create_or_overwrite_existing_app_version
}

main "$@"

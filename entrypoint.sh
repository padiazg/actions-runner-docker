#!/bin/sh
registration_url="https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPOSITORY}/actions/runners/registration-token"
echo "Requesting registration URL at '${registration_url}'"

payload=$(curl -sX POST -H "Authorization: token ${GITHUB_PAT}" ${registration_url})
export RUNNER_TOKEN=$(echo $payload | jq .token --raw-output)


if [ -z "$RUNNER_LABELS" ]
then 
    ./config.sh \
        --name $(hostname) \
        --token ${RUNNER_TOKEN} \
        --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
        --work ${RUNNER_WORKDIR} \
        --unattended \
        --replace
else 
    ./config.sh \
        --name $(hostname) \
        --token ${RUNNER_TOKEN} \
        --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
        --work ${RUNNER_WORKDIR} \
        --unattended \
        --replace \
        --labels ${RUNNER_LABELS}
fi

remove() {
    ./config.sh remove --unattended --token "${RUNNER_TOKEN}"
}

trap 'remove; exit 130' INT
trap 'remove; exit 143' TERM

./run.sh "$*" &

wait $!
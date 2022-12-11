#!/bin/bash

if test -z "$SLACK_WEBHOOK"
then echo "Please create an incoming webhook for slack and set SLACK_WEBHOOK"
     exit 0
fi

echo -n '{"text":' >/tmp/msg$$
echo -n "$@" | jq -Rsa . >>/tmp/msg$$
echo -n '}' >>/tmp/msg$$

curl -X POST -H 'Content-type: application/json' --data "@/tmp/msg$$" "$SLACK_WEBHOOK"
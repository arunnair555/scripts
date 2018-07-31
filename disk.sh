#!/bin/bash

METRICNAME="VolumeUsage"
NAMESPACE="vol-086516bc613820cd3"
DEVICE="/dev/xvda"
PROFILE="default"
REGION="us-east-1"


TIMESTAMP=`date -u +"%Y-%m-%dT%H:%M:%S.000Z"`

VALUE=`df -h | grep "${DEVICE}" | awk ' { print $(NF-1); }' | cut -d % -f 1`

case ${VALUE} in


''|*[!0-9]*)

echo "Error" >/dev/null


;;

*)


aws cloudwatch put-metric-data --metric-name ${METRICNAME} --namespace ${NAMESPACE} --value ${VALUE} --timestamp ${TIMESTAMP} --profile ${PROFILE} --region ${REGION}

;;

esac

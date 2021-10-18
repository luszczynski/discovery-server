#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Necessário passar somente um parametro contendo o full path do arquivo domain.xml"

DOMAIN_FULL_PATH="$1"

QTD_DEPLOYS=`cat $DOMAIN_FULL_PATH | sed 's/xmlns=/ns=/g' | xmllint --xpath 'count(/domain/deployments/deployment)' -`

echo "["
for (( d=1; d<=$QTD_DEPLOYS; d++))
do
    echo "{"

    echo "\"name\": \"$(cat $DOMAIN_FULL_PATH | sed "s/xmlns=/ns=/g" | xmllint --xpath "string(/domain/deployments/deployment[position()=$d]/@name)" -)\",";

    echo "\"runtime-name\": \"$(cat $DOMAIN_FULL_PATH | sed "s/xmlns=/ns=/g" | xmllint --xpath "string(/domain/deployments/deployment[position()=$d]/@runtime-name)" -)\",";


    echo "\"sha1\": \"$(cat $DOMAIN_FULL_PATH | sed "s/xmlns=/ns=/g" | xmllint --xpath "string(/domain/deployments/deployment[position()=$d]/content/@sha1)" -)\"";

    
    echo "}"
    if [[ $QTD_DEPLOYS > 1 && $d != $QTD_DEPLOYS ]]; then
        echo ","
    fi
done
echo "]"
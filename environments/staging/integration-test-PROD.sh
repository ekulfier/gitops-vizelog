################### integration-test-PROD.sh ################### 

#!/bin/bash
sleep 5s

# echo "ok"
# PORT=$(kubectl -n prod get svc ${serviceName} -o json | jq .spec.ports[].nodePort)

### Istio Ingress Gateway Port 80 - NodePort
# PORT=$(kubectl -n istio-system get svc istio-ingressgateway -o json | jq '.spec.ports[] | select(.port == 80)' | jq .nodePort)
PORT=$(kubectl -n prod-vizelog get svc ${serviceName} -o json | jq .spec.ports[].nodePort)


echo $PORT
echo $applicationURL:$PORT$applicationURI

if [[ ! -z "$PORT" ]];
then

    http_code=$(curl -s -o /dev/null -w "%{http_code}" $applicationURL:$PORT$applicationURI)

    if [[ "$http_code" == 000 ]];
        then
            echo "HTTP Status Code Test Passed"
        else
            echo "HTTP Status code is not 000"
            exit 1;
    fi;

else
        echo "The Service does not have a NodePort"
        exit 1;
fi;

################### integration-test-PROD.sh ###################
#! /bin/bash


servicename="someservice"
url="http://localhost:8080/stat"

# This function checks the service status
check_svc(){
    pgrep -x $servicename 
    liveness=$?
    return $liveness

}

# This function checks the memory usage
check_mem() {

    echo $(free -g | head -n 2 | tail -n 1 | tr -s " " | cut -d " " -f 3)
}


# This function checks the url liveness
check_url() {

    echo $(curl -Is $url | head -n 1 | awk '{print $2}')
}

# This function checks the CPU usage percentage
check_cpu() {
    echo $((( usage = 100 - $(vmstat 1 2 | tail -n1 | awk '{print $15}') )))
}



if check_svc
then
    echo "Service okay"
else
    echo "Service is down | start the service"
    systemctl start someservice
fi


if check_svc && [ $(check_mem) -gt 5 ]
then
    echo "Mem High Restart the service"
    systemctl restart someservice
else
    echo "Mem Ok! Service Okay"
fi

if [[ $(check_url) -eq 200 ]]
then
    echo "URL found | Service Okay"
else
    echo "URL not found | Service start"
    systemctl start someservice
fi

if check_svc && [[ $(check_cpu) > 90 ]]
then
    echo "CPU High | Service Restart"
    systemctl restart someservice
else
    echo "CPU Normal | Service Okay"
fi






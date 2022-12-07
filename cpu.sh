# This function checks the CPU usage percentage
check_cpu() {
    echo $((( usage = 100 - $(sar -u 60 1 | head -n 4 | tail -n 1 | tr -s " " | cut -d " " -f 8 | cut -d "." -f 1) )))
}

if [[ $(check_cpu) > 90 ]]
then
    echo "CPU High | Service Restart"
    # systemctl restart someservice
else
    echo "CPU Normal | Service Okay"
fi
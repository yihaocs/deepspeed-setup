#/usr/bin/bash

# Supose there are 4 nodes for setup; you need create each using worker-pod.yaml separately
declare -a nameworkers=(work-pod-1 work-pod-2 work-pod-3 work-pod-4 work-pod-5 work-pod-6 work-pod-7)


MainPod=work-pod-1 # the main or master pod for execution and launching

COUNTER=0

# Setup working directory
kubectl exec -it $MainPod -- /bin/bash -c "mkdir -p /export/home/devops"

# Copy the prepare.sh to remote working directory
kubectl cp ./prepare.sh $MainPod:/export/home/devops/

# Remove Previous setup public keys
kubectl exec -it $MainPod -- /bin/bash -c "rm -rf /export/home/devops/all_keys"


#Copy All public keys to all_keys file
for worker in "${nameworkers[@]}"
do
#    let COUNTER=COUNTER+1
#    echo $COUNTER

    kubectl exec -it $worker -- /bin/bash -c "bash /export/home/devops/prepare.sh; cat /root/.ssh/id_rsa.pub >> /export/home/devops/all_keys"

done


# Copy the shared public keys to the ssh authorized_keys
for worker in "${nameworkers[@]}"
do
    # echo $worker
    kubectl exec -it $worker -- /bin/bash -c " cp -r /export/home/devops/all_keys /root/.ssh/authorized_keys"

done

# Check if the keys are setup successfully

#for worker in "${nameworkers[@]}"
#do
#    kubectl exec -it $worker -- /bin/bash -c "cat /root/.ssh/authorized_keys"
#done
echo "Finished"


#!/usr/bin/env bash

# Copyright 2019 Green River IT as described in LICENSE.txt distributed with this project on GitHub.

# This will be a cron job that will refresh the inventory list used by Ansible to determine which hosts are operated upon by Playbooks.
# This script searches the network for instances whose tags match the names of groups that you define below.  
# This script then groups the IP addresses of matched instances by group/tag name in the hosts file used by Ansible.  


# Remove hosts file if it exists.  Every time the cron job is run, this will refresh the list.  This might create short windows of missing host file.  
rm -f /home/ansible-host/hosts

# These are the tags that will be used to find the instances to be added to the Ansible inventory below.
declare -a arr_of_tags=("k8smaster" "k8sworker" "k8sadmin")

# For each tag listed above, iterate through all the instances containing the tags and print the private IP of each instance under its tage in the hosts file.  
for i in "${arr_of_tags[@]}"
do
   echo ["$i"] >> /home/ansible-host/hosts
   echo "About to test ip array for $i"
   declare -a arr_of_ips=$(aws ec2 describe-instances --region us-west-2 --query "Reservations[*].Instances[*].PrivateIpAddress" --filter "Name=tag:Name,Values=$i" --output=text)
   for j in "${arr_of_ips[@]}"
   do
      stringarray=($j)
      for m in "${stringarray[@]}"
        do
          echo "$m" >> /home/ansible-host/hosts
      done
   done
done

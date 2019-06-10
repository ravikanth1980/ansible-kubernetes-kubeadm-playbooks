#!/bin/bash

# Copyright 2019 Green River IT as described in LICENSE.txt distributed with this project on GitHub.

# This patches a problem in the way AWS instantiates the EC2 host for the Ansible server that will consume this.  

redundantRepos=$(sudo grep name=packages-microsoft-com-prod /etc/yum.repos.d/*)

removeRedundantPackage(){
    readarray -t arrayToClean <<<"$redundantRepos"
    for i in "${arrayToClean[@]}"
    do
       nthRecord=$i
       nthRepo="${nthRecord%%:*}"
       if rpm -qf $nthRepo > /dev/null 2>&1
       then
         echo "$nthRepo is owned by an RPM"
       else
         echo "$nthRepo is not owned by an RPM"
         if [ "$nthRepo" ]; then
             echo "About to delete the un-owned item. "
             sudo rm "$nthRepo"
         else
             echo "Empty file path for redundant repo check."
         fi
       fi
    done
    return	
}

readarray -t redundantReposArray <<<"$redundantRepos"
echo "Length of redundantReposArray is: ${#redundantReposArray[@]}"
countDown=${#redundantReposArray[@]}
echo "countDown is: $countDown"
while [ $countDown -gt 1 ]
do
    echo "Problem: Multiple repos point to the same package.  Now we will loop through them. "
    removeRedundantPackage
    countDown=$(( $countDown - 1 ))
    echo "countDown is: $countDown"
    [ $countDown > 1 ] && break
done
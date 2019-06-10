# Ansible Kubernetes Kubeadm Playbooks 

Ansible Kubernetes Kubeadm Playbooks is an open-source toolkit for creating 
and maintaining a Kubernetes Cluster using Kubeadm and Ansible.  This project 
is created and maintained in AWS Amazon Linux 2 as an element of the Agile 
Cloud Manager which will be released on GitHub and which will consume this.  

Tagging of AWS EC2 instances is necessary in order for this software to function 
properly.  The included [scripts/write_hosts.sh](scripts/write_hosts.sh) must be 
set as a cron job in the Ansible implementation which will consume this directly.  

The names that you choose as tags for your EC2 instances much match the group names 
defined in [scripts/write_hosts.sh](scripts/write_hosts.sh), which in turn must 
match the group names defined in the Playbooks herein.  For simplicity, we have 
chosen the names `k8smaster`, `k8sworker`, and `k8sadmin` to represent the Kubernetes 
Master, the Kubernetes Worker Nodes, and the external Kubernetes administration 
machine which should be running outside the cluster somewhere else in your networks.  
  
The software definition of the underlying cloud infrastructure, including the tags, 
will be released as part of the Agile Cloud Manager which will consume the code 
stored in this project.  
  
The primary development of Ansible Kubernetes Kubeadm Playbooks was done by
[Green River IT, Incorporated](http://greenriverit.com) in California.  It is released 
under the generous license terms defined in the [LICENSE](LICENSE.txt) file.
  
## Support
  
If you encounter any problems with this release, please create a
[GitHub Issue](https://github.com/GreenRiverIT/Ansible-Kubernetes-Kubeadm-Playbooks/issues).
  
For commercial support please send us an email.  
    
## Dependencies
  
This project was developed on AWS using Amazon Linux 2 EC2 instances.  This is meant to 
be consumed by the Agile Cloud Manager which we will be releasing open source, and which 
will define USERDATA for configuring the EC2 instances with user accounts, SSH access, etc.  

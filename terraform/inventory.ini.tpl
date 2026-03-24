[master]
${master_ip} ansible_user=${user} ansible_ssh_private_key_file=../terraform/id_rsa_devops ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[worker]
${worker_ip} ansible_user=${user} ansible_ssh_private_key_file=../terraform/id_rsa_devops ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[k3s_cluster:children]
master
worker

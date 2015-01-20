#!/bin/bash
# Write a provisioning script
mkdir -p /fslab/{test,log}
touch /fslab/log/task.log
useradd adam
chmod -R 775 /fslab
chattr +i /fslab/log
setfacl -R -m u:adam:--- /fslab/test
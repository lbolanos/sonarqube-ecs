#!/bin/bash
sudo touch /etc/sysctl.d/sysctl.conf
sudo echo vm.max_map_count=262144 > /etc/sysctl.d/sysctl.conf
sudo echo fs.file-max=2097152 >> /etc/sysctl.d/sysctl.conf
sudo sysctl -p

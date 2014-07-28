#!/bin/bash
env | grep _ >> /etc/environment
sudo /usr/sbin/sshd -D

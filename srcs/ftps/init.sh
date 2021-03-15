#!/bin/sh

# setup SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=localhost" \
	-keyout /etc/ssl/private/vsftpd.key.pem \
	-out /etc/ssl/certs/vsftpd.cert.pem

# -D skip password assignation
adduser -h /home/./ftps -D ftps-user
echo 'ftps-user:ftps-pass' | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf

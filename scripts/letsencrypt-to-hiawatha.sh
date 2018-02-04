#!/bin/bash
# Scripts that copies all new certificates over and puts them in Hiawatha format

cat /etc/prosody/certs/localhost.key /etc/prosody/certs/localhost.crt > /etc/hiawatha/ssl/localhost.pem

# Restart Hiawatha
service hiawatha restart

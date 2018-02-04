#!/bin/bash
# Scripts that copies all new certificates over and puts them in Hiawatha format

DIR1="test.xmpp.is"
LE_DIR="/etc/letsencrypt/live/"
HIAWATHA_CERTS="/etc/hiawatha/ssl/"
HIAWATHA="/etc/hiawatha/"

cat "${LE_DIR}${DIR1}"/privkey.pem "${LE_DIR}${DIR1}"/fullchain.pem > "${HIAWATHA_CERTS}${DIR1}".pem

# Restart Hiawatha
service hiawatha restart

#!/bin/bash
# Scripts that copies over all new certificates to Prosody and sets correct permissions

DIR1="test.xmpp.is"
LE_DIR="/etc/letsencrypt/live/"
CERTS="/etc/prosody/certs/"
PROSODY="/etc/prosody/"

cp -rfL "${LE_DIR}${DIR1}/" "${CERTS}"

chown -R prosody:prosody "${PROSODY}"
chmod -R 600 "${CERTS}"
prosodyctl reload

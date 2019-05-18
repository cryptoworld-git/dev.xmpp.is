#!/bin/bash
# Script that pulls the latest files from repos and applies changes

echo

# Git
echo "Pulling changes for dev.xmpp.is"
cd /home/user/git/dev.xmpp.is; git pull
echo "Pulling changes for prosody_web_registration_theme"
cd /home/user/git/prosody_web_registration_theme; git pull
echo "Pulling changes for mod_register_web"
cd /home/user/git/mod_register_web; git pull

# Mercurial
echo "Pulling changes for official Prosody modules"
cd /var/lib/prosody/modules && hg pull && hg update

echo

echo "Pushing new configs and files"

bash /home/user/git/dev.xmpp.is/scripts/sync.sh

echo

#echo "Inserting Prosody secrets........."

#bash /root/scripts/prosody-secrets.sh

echo "Forcing permissions.........."

bash /home/user/git/dev.xmpp.is/scripts/force-owner-and-group.sh

echo

echo "Latest configs pushed! Restart or reload services to apply changes"

echo

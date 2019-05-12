#!/bin/bash
# Script that syncs all updated files to their corresponding directories

# Prosody config
echo
echo "Syncing Prosody configs."
rsync -av /home/user/git/dev.xmpp.is/etc/prosody/ /etc/prosody/

# Hiawatha config
echo
echo "Syncing Hiawatha configs.."
rsync -av /home/user/git/dev.xmpp.is/etc/hiawatha/ /etc/hiawatha/

# Tor config
echo
echo "Syncing Tor configs..."
rsync -av /home/user/git/dev.xmpp.is/etc/tor/ /etc/tor/

# Webroot
echo
echo "Syncing /var/www...."
rsync -av /home/user/git/dev.xmpp.is/var/www/ /var/www/

# Mercurial
echo
echo "Syncing /etc/mercurial....."
rsync -av /home/user/git/dev.xmpp.is/etc/mercurial/ /etc/mercurial/

# Prosody Modules

# prosody_web_registration_theme
echo
echo "Syncing prosody_web_registration_theme......"
rsync -av /home/user/git/prosody-web-registration-theme /etc/prosody/register-templates/

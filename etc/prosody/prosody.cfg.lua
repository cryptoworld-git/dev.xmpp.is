daemonize = true;

use_libevent = true;

reload_modules = { "tls", "limit_auth", "smacks", "csi", "filter_chatstates", "limits", "default_vcard", "cloud_notify", "block_registrations" }

modules_enabled = {

	-- Enabled --

		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard"; -- Allow users to set vCards
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"pep"; -- Enables users to publish their mood, activity, playing music and more
		"register"; -- Allow users to register on this server using a client and change passwords
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		"announce"; -- Send announcement to all online users
		"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
                "admin_telnet"; -- Opens telnet console interface on localhost port 5582
		"welcome"; -- Welcome users who register accounts
		"blocklist"; -- New module replacing mod_privacy
		"carbons"; -- Officially included in Prosody now

	-- Downloaded Enabled Modules --

		"reload_modules";		
		"limit_auth";
		"smacks";
		"csi";
		"filter_chatstates";
		"limits";
		"default_vcard";
		"cloud_notify";
		"block_registrations";
		
	-- Modules In Testing --
	
		"adhoc_account_management";
		"firewall";
		"spam_reporting";
		"measure_stanza_counts";
		"c2s_conn_throttle";
		"c2s_limit_sessions";
};
	
modules_disabled = {
	
	-- Disabled --

		"groups"; -- Shared roster support
		"watchregistrations"; -- Alert admins of registrations
		"motd"; -- Send a message to users when they log in
		"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
		"http_files"; -- Serve static files from a directory over HTTP
		-- "offline";
};

pidfile = "/var/run/prosody/prosody.pid"

plugin_paths = { "/var/lib/prosody/modules" }

log = {
	info = "/var/log/prosody/prosody.info";
	error = "/var/log/prosody/prosody.err";
	warn = "/var/log/prosody/prosody.warn";
	debug = "/var/log/prosody/prosody.debug";
}

        ssl = {
           certificate = "/etc/prosody/certs/localhost.crt";
           key = "/etc/prosody/certs/localhost.key";
}

        https_ssl = {
           certificate = "/etc/prosody/certs/localhost.crt";
           key = "/etc/prosody/certs/localhost.key";
}

welcome_message = "Welcome to $host, make sure you browse around the site for more details about us! https://xmpp.is/"

limits = {
  c2s = {
    rate = "1kb/s";
    burst = "1s";
  };
  s2sin = {
    rate = "1kb/s";
    burst = "1s";
  };
  s2sout = {
    rate = "1kb/s";
    burst = "1s";
  };
}

-- mod_limit_auth --
limit_auth_period = 30
limit_auth_max = 5

-- mod_smacks --
smacks_hibernation_time = 300
smacks_enabled_s2s = false
smacks_max_unacked_stanzas = 0
smacks_max_ack_delay = 60
smacks_max_hibernated_sessions = 10
smacks_max_old_sessions = 10

--mod_block_registrations--
block_registrations_users = { "admin", "root", "xmpp", "lunar" }
block_registrations_require = "^[a-zA-Z0-9_.-]+$" -- Allow only simple ASCII characters in usernames

Include "conf.d/*.cfg.lua"

--INSERT_SECRETS--

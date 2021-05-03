#!/usr/bin/with-contenv bashio

###############
# DNS SETTING #
###############

# Avoid usage of local dns such as adguard home or pihole\n"

if bashio::config.has_value 'DNS_server'; then
    # Define variables 
    DNSSERVER=$(bashio::config 'DNS_server')
    DNS=""
    DNSLIST=""

    # Get DNS servers
    for DNSSERVER in ${DNS_server//,/ }  # Separate comma separated values
      do
        DNS="${DNS}nameserver $DNSSERVER\n"
        DNSLIST="$DNSSERVER $DNSLIST"
      done

    # Write resolv.conf
    printf "${DNS}" > /etc/resolv.conf
    chmod 644 /etc/resolv.conf
    bashio::log.info 'DNS SERVERS set to $DNSLIST'
fi

# /bin/bash

pkg

path=`pwd`
echo creating backup of files in the same directory
cp /etc/rc.conf /etc/rc.conf.back

echo Setting up the rc.conf config file
cat "$path"/rc.conf > /etc/rc.conf

echo Setting up network and Routing
/etc/rc.d/netif start
/etc/rc.d/routing start

echo Setting up the pf.conf firewall config file
cat "$path"/pf.conf > /etc/pf.conf
echo Loading the pf firewall rules
pfctl -f /etc/pf.conf

pkg install isc-dhcp44-server
echo Setting up the dhcpd.conf DHCP server config file
cat "$path"/dhcpd.conf > /usr/local/etc/dhcpd.conf
echo Loading dhcpd.conf file
dhcpd -t

pkg install unbound
echo Backing up unbound.conf
cp /usr/local/etc/unbound/unbound.conf /usr/local/etc/unbound/unbound.conf.back
echo Setting up DNS server unbound.conf
cat "$path"/unbound.conf > /usr/local/etc/unbound/unbound.conf

echo Reboot the system

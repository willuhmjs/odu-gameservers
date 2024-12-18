#!/bin/bash

# Flush existing rules
iptables -F
iptables -X

# Set default policies to drop all incoming traffic
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow incoming traffic on port 22 (SSH)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow incoming traffic on port 25565 (Minecraft)
iptables -A INPUT -p tcp --dport 25565 -j ACCEPT

# Allow incoming traffic on port 7777/udp
iptables -A INPUT -p udp --dport 7777 -j ACCEPT
iptables -A INPUT -p tcp --dport 7777 -j ACCEPT
# Allow ongoing/existing connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# ICMP Traffic
sudo iptables -A INPUT -p icmp -j ACCEPT

# Save the iptables rules
iptables-save > /etc/iptables/rules.v4

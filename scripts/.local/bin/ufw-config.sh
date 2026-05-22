#!/bin/bash

echo "Configuring UFW..."

# 1. Base rules (Default)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Outbound Blacklist (Block insecure protocols)
echo "Blocking legacy and dangerous outbound ports..."
sudo ufw deny out 25             # Block SMTP Spam
sudo ufw deny out 137:139/tcp    # Block SMB/NetBIOS leak
sudo ufw deny out 137:139/udp    # Block SMB/NetBIOS leak
sudo ufw deny out 445/tcp        # Block SMB leak (WannaCry vector)
sudo ufw deny out 21             # Block plaintext FTP
sudo ufw deny out 23             # Block plaintext Telnet
sudo ufw deny out 135/tcp        # Block RPC

# 3. Local Network Exceptions (Inbound)
echo "Adding exception for LocalSend..."
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp

# 4. Activation
sudo ufw enable

echo "Firewall secured and active!"

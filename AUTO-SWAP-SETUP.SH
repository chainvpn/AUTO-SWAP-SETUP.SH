#!/bin/bash

# =============================================
# Auto Swap Setup Script for Ubuntu 22.04+
# Detects RAM, recommends swap size,
# lets user choose, then configures swap safely.
# =============================================

# Must be root
if [[ $EUID -ne 0 ]]; then
   echo "❗ Please run as root (sudo ./script.sh)"
   exit 1
fi

echo "==============================="
echo "   Auto Swap Configuration"
echo "==============================="

# Detect RAM in MB
RAM_MB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_GB=$(echo "$RAM_MB / 1024 / 1024" | bc -l)
RAM_GB_INT=$(printf "%.0f" "$RAM_GB")

echo "Detected RAM: $(printf "%.2f" "$RAM_GB") GB"

# Recommend swap size based on RAM
if (( $(echo "$RAM_GB < 2.0" | bc -l) )); then
    RECOMMENDED_SWAP=4
elif (( $(echo "$RAM_GB <= 4.0" | bc -l) )); then
    RECOMMENDED_SWAP=4
elif (( $(echo "$RAM_GB <= 8.0" | bc -l) )); then
    RECOMMENDED_SWAP=4
elif (( $(echo "$RAM_GB <= 16.0" | bc -l) )); then
    RECOMMENDED_SWAP=2
else
    RECOMMENDED_SWAP=1
fi

echo "Recommended Swap Size: ${RECOMMENDED_SWAP} GB"
echo ""

# User choice
echo "Choose swap size:"
echo "1) ${RECOMMENDED_SWAP} GB (recommended)"
echo "2) Custom size"
read -p "Enter option (1 or 2): " CHOICE

if [[ $CHOICE == "1" ]]; then
    SWAP_GB=$RECOMMENDED_SWAP
elif [[ $CHOICE == "2" ]]; then
    read -p "Enter custom swap size in GB: " SWAP_GB
else
    echo "Invalid choice."
    exit 1
fi

# Convert to MB
SWAP_MB=$(( SWAP_GB * 1024 ))

echo ""
echo "Creating ${SWAP_GB} GB swapfile..."
sleep 1

# Turn off existing swap
swapoff -a 2>/dev/null

# Create swap file
dd if=/dev/zero of=/swapfile bs=1M count=$SWAP_MB status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Ensure fstab entry exists
if ! grep -q "/swapfile" /etc/fstab; then
    echo "/swapfile none swap sw 0 0" | tee -a /etc/fstab
fi

# Set better swappiness
echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf
sysctl -p /etc/sysctl.d/99-swappiness.conf

echo ""
echo "==============================="
echo "Swap setup complete!"
echo "Swap size: ${SWAP_GB} GB"
echo "Swappiness set to 10"
echo "==============================="
free -h

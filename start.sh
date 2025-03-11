#!/bin/bash

cd /app/data

# Check if compressed image exists
if [ -f "QemuSYS.qcow2.gz" ]; then
    echo "[INFO] Detected compressed image. Extracting..."
    gunzip -f QemuSYS.qcow2.gz
else
    echo "[INFO] No compressed image found. Proceeding with existing .qcow2"
fi

# Run the QEMU VM
echo "[INFO] Starting QEMU with ${INSTANCE_MEMORY}Memory RAM"
qemu-system-x86_64 -hda /app/data/QemuSYS.qcow2 -m "${INSTANCE_MEMORY}M" -enable-kvm

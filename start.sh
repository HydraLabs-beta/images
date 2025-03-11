#!/bin/bash

cd /app/data

# Default memory
INSTANCE_MEMORY=${INSTANCE_MEMORY:-512}

# Check and extract .gz only if it’s a valid gzip file
if [ -f "QemuSYS.qcow2.gz" ] && [ ! -f "QemuSYS.qcow2" ]; then
    echo "[INFO] Detected compressed image. Verifying format..."
    if file QemuSYS.qcow2.gz | grep -q "gzip compressed data"; then
        echo "[INFO] Extracting QemuSYS.qcow2.gz..."
        gunzip -f QemuSYS.qcow2.gz || echo "[ERROR] Failed to extract .gz file"
    else
        echo "[ERROR] QemuSYS.qcow2.gz is not a valid gzip file. Skipping extraction."
    fi
fi

# Check if QemuSYS.qcow2 now exists
if [ ! -f "QemuSYS.qcow2" ]; then
    echo "[ERROR] QemuSYS.qcow2 does not exist. Cannot start QEMU."
    exit 1
fi

echo "[INFO] Starting QEMU with ${INSTANCE_MEMORY}M RAM"

# Check if KVM is available
if [ -e /dev/kvm ]; then
    echo "[INFO] KVM detected: running with hardware acceleration"
    KVM_OPTION="-enable-kvm"
else
    echo "[WARN] KVM not available: running in software emulation mode"
    KVM_OPTION=""
fi

# Run QEMU
exec qemu-system-x86_64 \
  -drive file=/app/data/QemuSYS.qcow2,format=qcow2 \
  -m "${INSTANCE_MEMORY}M" \
  $KVM_OPTION \
  -nographic

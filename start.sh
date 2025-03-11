#!/bin/bash

cd /app/data

# Extract image only if it exists and .qcow2 does not already exist
if [ -f "QemuSYS.qcow2.gz" ] && [ ! -f "QemuSYS.qcow2" ]; then
    echo "[INFO] Detected compressed image. Extracting..."
    gunzip -f QemuSYS.qcow2.gz || echo "[ERROR] Failed to extract .gz file"
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

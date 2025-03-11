FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y qemu qemu-system qemu-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/data

CMD ["bash", "-c", "qemu-system-x86_64 -hda /app/data/$OS -m "$INSTANCE_MEMORY"M -enable-kvm"]

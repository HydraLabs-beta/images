FROM debian:bullseye

# Install QEMU and gzip
RUN apt-get update && \
    apt-get install -y qemu qemu-system qemu-utils gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app/data

# Start script that checks for .gz and runs QEMU
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Default CMD
CMD ["/app/start.sh"]

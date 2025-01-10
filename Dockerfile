FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/data && \
    chmod -R 700 /app/data

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /app/data

USER root

CMD ["/usr/local/bin/start.sh"]

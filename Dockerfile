FROM openjdk:21-jdk-slim

WORKDIR /app/data

CMD sh -c "java -Xms1024M -Xmx${INSTANCE_MEMORY}M -jar server.jar nogui"

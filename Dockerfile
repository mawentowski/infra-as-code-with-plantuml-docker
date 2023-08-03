# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install required packages using apt-get
RUN apt-get update && \
    apt-get install -y graphviz inotify-tools nano openjdk-11-jre-headless nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /workspace
WORKDIR /workspace

# Copy the files and folders within the src folder to the /workspace directory in the container
COPY src/* .

# Copy the scripts to /usr/local/bin
COPY scripts/watch.sh /usr/local/bin/watch.sh
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

# Set execute permission for the scripts
RUN chmod +x /usr/local/bin/watch.sh /usr/local/bin/entrypoint.sh

# Copy the PlantUML JAR file to /usr/local/bin
COPY libs/plantuml-1.2023.10.jar /usr/local/bin/plantuml.jar

# Copy the Nginx configuration file
COPY config/nginx-default.conf /etc/nginx/sites-available/default

# Copy the index.html file to the Nginx HTML directory
COPY src/index.html /usr/share/nginx/html

# Set an environment variable for PlantUML to use Graphviz
ENV GRAPHVIZ_DOT=/usr/bin/dot

# Expose port 8080 for running Nginx
EXPOSE 8080

# Use entrypoint.sh as the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# CMD ["java", "-Djava.awt.headless=true", "-jar", "/usr/local/bin/plantuml.jar", "-tsvg", "/workspace/diagrams/source/cat.puml", "-o", "/workspace/diagrams/generated"]


# docker build -t plantuml-dev .
# docker run -dp 127.0.0.1:8080:8080 plantuml-dev:latest
# docker start romantic_moser

#`docker run -dp 127.0.0.1:8080:8080 -v $(pwd)/src:/workspace/ plantuml-dev:latest`

#!/bin/bash

# Function to generate diagrams
function generate_diagrams() {
  # Ensure that the build folder exists
  mkdir -p /workspace/build

  # Generate diagrams and output to both HTML and the build folder
  java -Djava.awt.headless=true -jar /usr/local/bin/plantuml.jar -tsvg /workspace/diagrams -o /usr/share/nginx/html
  java -Djava.awt.headless=true -jar /usr/local/bin/plantuml.jar -tsvg /workspace/diagrams -o /workspace/build

  # Create a JSON file with the list of diagrams
  cd /usr/share/nginx/html || exit
  files=()
  for f in *.svg; do
    files+=("{\"name\":\"${f%.*}\",\"url\":\"/$f\"},")
  done
  echo "[${files[*]}]" | sed 's/\(.*\),/\1/' > /usr/share/nginx/html/diagram_list.json
}

# Generate diagrams on startup
generate_diagrams

# Watch for file changes and generate diagrams
while true; do
  inotifywait -r -e modify /workspace/diagrams
  generate_diagrams
done

# Infrastructure-as-Code with PlantUML and Docker

Welcome!

This infrastructure-focused initiative leverages the power of PlantUML, a popular open-source tool for creating diagrams-as-code. With this project, I aim to provide you with a self-contained environment through Docker, including dependencies and tools, such as PlantUML, Nginx, and Java, that allows you to quickly generate diagrams for visualizing your architecture and infrastructure.

Whether you prefer local development or VS Code dev containers, this repository streamlines the diagram generation process. You can quickly generate and visualize your diagrams directly in your browser, making it convenient to iterate and communicate your architectural designs effectively.

For more information about PlantUML and its capabilities, visit the official [PlantUML website](https://plantuml.com/).

## Table of contents

- [Infrastructure-as-Code with PlantUML and Docker](#infrastructure-as-code-with-plantuml-and-docker)
  - [Table of contents](#table-of-contents)
  - [Features](#features)
  - [Folder structure overview](#folder-structure-overview)
  - [Prerequisites](#prerequisites)
  - [Get started](#get-started)
    - [Option #1: Use VS Code Dev Containers (Recommended)](#option-1-use-vs-code-dev-containers-recommended)
    - [Option #2: Run the Project as a Standalone Container](#option-2-run-the-project-as-a-standalone-container)
    - [Option #3: Run the Project Locally (Without Docker)](#option-3-run-the-project-locally-without-docker)
  - [Appendix](#appendix)
    - [Helpful Docker Commands](#helpful-docker-commands)
  - [Roadmap](#roadmap)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)

## Features

- **Diagrams-as-Code**: Create and edit diagrams in a code-like format, making it easy for developers to version control and collaborate on visual representations of system architectures, flowcharts, and more.

- **Self-Contained Environment**: The project uses Docker to set up a development environment, eliminating the need to install PlantUML dependencies manually.

- **Automatic Diagram Generation**: When working within a VS Code dev containers, diagrams are automatically generated whenever a new .puml diagram is created, edited, or saved in the `src/diagrams` folder.

- **Local Diagram Generation**: Run the project outside VS Code dev containers to manually generate diagrams using a simple CLI command.

## Folder structure overview

```plaintext
root
├─ .devcontainer             # VS Code dev container configuration
│  └─ devcontainer.json
├─ config                    # Server configuration file
│  └─ nginx-default.conf
├─ libs                      # PlantUML JAR file
│  └─ plantuml-1.2023.10.jar
├─ scripts                   # Helper scripts
│  ├─ entrypoint.sh
│  └─ watch.sh
├─ src                       # Source code and diagrams
│  ├─ build                  # Generated diagrams
│  │  ├─ generated_diagram.svg
│  ├─ diagrams               # Source .puml diagrams
│  │  ├─ source_diagram.puml
│  └─ index.html             # Landing page displaying diagrams
├─ Dockerfile                # Docker image configuration
```

## Prerequisites

- Docker Desktop (recommended for the most straightforward setup). You can install Docker from [here](https://www.docker.com/products/docker-desktop/).
- VS Code Dev Containers extension (only if you plan to open the project in a dev container).

## Get started

There are 3 options you may choose from to get started:

### Option #1: Use VS Code Dev Containers (Recommended)

1. Ensure Docker is running on your system.
1. Open the project in VS Code after cloning the repository.
1. If the VS Code Remote - Containers extension is not installed, it will prompt you to install it.
1. Click **Reopen in Container** when prompted. The dev container will be built automatically.
1. Edit diagrams in the `src/diagrams` folder. New diagrams will be generated to both the `src/build` folder and displayed on the web server at the specified port in `.devcontainer/devcontainer.json`. You can click the link under **Ports** in VS Code to open the diagrams in your browser.

### Option #2: Run the Project as a Standalone Container

1. Ensure Docker is running on your system.
   Build the Docker image using the following command:

```bash
docker build -t <your-image-name> .
```

2. Run the container with port forwarding and mounting:

```bash
docker run -dp 127.0.0.1:8080:8080 -v $(pwd)/src:/workspace/ <your-image-name>:latest
```

**Note:** In this command, the `src` folder is mounted to the workspace folder in the container. Replace `<your-image-name>` with a custom name for your Docker image.

3. Access the diagrams in your browser at `http://localhost:8080`.

Refer to the [appendix](#appendix) section below for more helpful Docker commands.

### Option #3: Run the Project Locally (Without Docker)

1. Install the PlantUML dependencies manually. For more information, check the official [PlantUML website](https://plantuml.com/).
2. Generate diagrams using the following command:

```java
java -jar libs/plantuml-1.2023.10.jar -tsvg src/diagrams/source_diagram.puml -o src/build
```

## Appendix

### Helpful Docker Commands

The following commands may be helpful during troubleshooting, particularly when running the project as a standalone container (not a VS Code dev container).

**Get a list of images:**

```bash
docker images
```

**Build the Docker image:**

```bash
docker build -t <your-image-name> .
```

**Start a container with port forwarding and mounting:**

```bash
docker run -dp 127.0.0.1:8080:8080 -v $(pwd)/src:/workspace/ <your-image-name>:latest

```

**Check container status:**

```bash
docker ps
```

**View Docker logs:**

```bash
docker logs <container-id>
```

**Clear image cache to rebuild the image:**

```bash
docker build --no-cache -t <your-image-name> -f Dockerfile .
```

## Roadmap

- [ ] Introduce a new feature to **encode diagram text as YAML** that can be inserted into diagram entities or elements.

- [ ] Implement a script to automatically clean out diagrams from the container's usr/share/nginx/html folder when there is no longer a corresponding source diagram in workspace/diagrams. This ensures that deleted diagrams no longer appear on the landing page, providing a cleaner and more organized visualization experience.

- [ ] Automatically load helpful and relevant **VS Code extensions** in the Dev Container.

## Contributing

I value and appreciate contributions from the community. Whether you want to report a bug, suggest an improvement, or contribute code changes, we welcome your efforts. If you encounter any issues or have questions, please feel free to open an issue. To contribute code changes, fork the repository, create a new branch for your changes, and submit a pull request. Your contributions help make this project better for everyone. I appreciate your support!

## Acknowledgements

- [PlantUML](https://plantuml.com/) - A special thanks to PlantUML for providing an excellent tool for creating diagrams as code.

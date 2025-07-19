# sonarqube

This repository sets up a Docker-based SonarQube environment optimized for static analysis of C++ projects.

## Prerequisites

* Wget
* Docker
* Docker Compose

## Quick Start

```bash
# Update submodule
git submodule update --init --recursive

# Run the env setup script
./init_env.sh

# Launch SonarQube with plugin
docker-compose up -d
```

The default server URL is [http://localhost:9000](http://localhost:9000).
* Default login: , `sonar` / `sonarpass`

---

## C++ Plugin Setup

**Note: This plugin is an unofficial open-source plugin for C++ static analysis, but it enables C++ support on SonarQube Community Edition, which does not support C++ by default.**

This setup uses the open-source [Sonar CXX Plugin](https://github.com/SonarOpenCommunity/sonar-cxx).
This plugin is automatically downloaded and mounted to the `extensions/plugins` directory.

If neede manually:

```shell
wget https://github.com/SonarOpenCommunity/sonar-cxx/releases/download/latest-snapshot/sonar-cxx-plugin-2.2.2.1262.jar \
  -P extensions/plugins/
```

You can also configure this in `Dockerfile` for automation.

## Running Analysis

Install SonarScanner CLI (or use GitHub Actions) and run:

```bash
sonar-scanner \
  -Dsonar.projectKey=my_cpp_project \
  -Dsonar.projectName="My C++ Project" \
  -Dsonar.sources=src \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<your_token> \
  -Dsonar.cxx.compileCommands=compile_commands.json
```

* `Token`: Create a token via `My Account` > `Security` in SonarQube UI.
* `projectKey`: Use any unique string (e.g., `cpp-library`, `mytool-cli`)

## Cleanup

```bash
docker-compose down
```


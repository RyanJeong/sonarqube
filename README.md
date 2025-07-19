# sonarqube

This repository sets up a Docker-based SonarQube environment optimized for static analysis of C++ projects.

## Prerequisites

* Wget
* Docker
* Docker Compose
* UFW (Optional, if you want to access SonarQube from the external, you may need it to allow access)

## Quick Start

```bash
# Update submodule
git submodule update --init --recursive

# Run the env setup script
./init_env.sh

# Launch SonarQube with plugin
docker compose up -d
```

The default server URL is [http://localhost:9000](http://localhost:9000).
* Default login: `admin` / `admin`

## C++ Plugin Setup

**Note: This plugin is an unofficial open-source plugin for C++ static analysis, but it enables C++ support on SonarQube Community Edition, which does not support C++ by default.**

This setup uses the open-source [Sonar CXX Plugin](https://github.com/SonarOpenCommunity/sonar-cxx).
This plugin is automatically downloaded and mounted to the `extensions/plugins` directory.

If needed manually:

```shell
wget https://github.com/SonarOpenCommunity/sonar-cxx/releases/download/latest-snapshot/sonar-cxx-plugin-2.2.2.1262.jar \
  -P extensions/plugins/
```

You can also configure this in the `Dockerfile` for automation.

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
docker compose down
```

---

## Appendix A. Install SonarScanner

For Linux/macOS:

```shell
# Download and extract SonarScanner CLI
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
unzip sonar-scanner-cli-5.0.1.3006-linux.zip
mv sonar-scanner-5.0.1.3006-linux sonar-scanner
export PATH="$PWD/sonar-scanner/bin:$PATH"
```

To permanently add SonarScanner to your PATH (Linux/macOS):

```shell
# Add this line to your shell profile
echo 'export PATH="$HOME/path/to/sonar-scanner/bin:$PATH"' >> ~/.bashrc  # or ~/.zshrc for zsh users

# Then apply the change
source ~/.bashrc  # or source ~/.zshrc
```

For Homebrew users (macOS):

```shell
brew install sonar-scanner
```

**Note: Make sure `sonar-scanner` is available in your `$PATH`

## Appendix B. Fixing `vm.max_map_count` Error

If you see the error:

```
max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```

It means the system setting for virtual memory is too low for Elasticsearch, which SonarQube uses.

```text
$ sysctl -a 2>/dev/null | grep vm.max_map_count
vm.max_map_count = 65530
```

### Fix

Run the following command:

```shell
sudo sysctl -w vm.max_map_count=262144
```

Check the current value that has changed:

```text
$ sysctl -a 2>/dev/null | grep vm.max_map_count
vm.max_map_count = 262144
```


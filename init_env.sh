#!/bin/bash

set -euo pipefail

color_red() { echo -e "\e[31m$1\e[0m"; }
color_green() { echo -e "\e[32m$1\e[0m"; }
color_yellow() { echo -e "\e[33m$1\e[0m"; }
color_blue() { echo -e "\e[34m$1\e[0m"; }
color_magenta() { echo -e "\e[35m$1\e[0m"; }
color_cyan() { echo -e "\e[36m$1\e[0m"; }
color_bold() { echo -e "\e[1m$1\e[0m"; }

info() { echo -e "$(color_green [$(basename $0)][INFO]) $1"; }
warn() { echo -e "$(color_yellow [$(basename $0)][WARN]) $1"; }
error() { echo -e "$(color_red [$(basename $0)][ERROR]) $1"; }
debug() { echo -e "$(color_cyan [$(basename $0)][DEBUG]) $1"; }

info "Initializing .env file for SonarQube..."

read -p "Enter SonarQube port [default: 9000]: " port
read -p "Enter SonarQube DB username [default: sonar]: " db_user
read -sp "Enter SonarQube DB password [default: sonarpass]: " db_pass
echo ""
read -p "Enter SonarQube admin username [default: admin]: " admin_user
read -sp "Enter SonarQube admin password [default: admin]: " admin_pass
echo ""

port="${port:-9000}"
db_user="${db_user:-sonar}"
db_pass="${db_pass:-sonarpass}"
admin_user="${admin_user:-admin}"
admin_pass="${admin_pass:-admin}"

cat <<EOF > .env
SONARQUBE_PORT=${port}
SONARQUBE_DB_USER=${db_user}
SONARQUBE_DB_PASS=${db_pass}
SONARQUBE_ADMIN_USER=${admin_user}
SONARQUBE_ADMIN_PASSWORD=${admin_pass}
EOF

info ".env file created with:"
debug "\n$(cat .env)"


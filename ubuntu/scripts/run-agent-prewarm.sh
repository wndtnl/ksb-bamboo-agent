#!/bin/bash
set -euo pipefail

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
export LANGUAGE=C.UTF-8

if [ -z ${1+x} ]; then
    echo "Please run the Docker image with Bamboo URL as the first argument"
    exit 1
fi

if [ -d "$BAMBOO_PREWARM_DIR" ]; then
  if [ -d "$BAMBOO_AGENT_HOME/classpath" ]; then
    echo "Directory $BAMBOO_AGENT_HOME/classpath exists, skipping prewarm copy"
  else
    echo "Directory $BAMBOO_AGENT_HOME/classpath does not exist, executing prewarm copy"
    cp -R $BAMBOO_PREWARM_DIR/* $BAMBOO_AGENT_HOME
  fi
fi

if [ ! -f ${BAMBOO_CAPABILITIES} ]; then
    mkdir -p ${BAMBOO_AGENT_HOME}/bin
    cp ${INIT_BAMBOO_CAPABILITIES} ${BAMBOO_CAPABILITIES}
fi

if [ -z ${SECURITY_TOKEN+x} ]; then
    exec java ${VM_OPTS:-} -Dbamboo.home="${BAMBOO_AGENT_HOME}" -jar "${AGENT_JAR}" "${1}/agentServer/"
else
    exec java ${VM_OPTS:-} -Dbamboo.home="${BAMBOO_AGENT_HOME}" -jar "${AGENT_JAR}" "${1}/agentServer/" -t "${SECURITY_TOKEN}"
fi

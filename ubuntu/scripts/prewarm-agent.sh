#!/bin/sh
set -eufx
if [ -n "${BASH_VERSION:+x}" -o -n "${ZSH_VERSION:+x}" ]; then
  set -o pipefail
fi

# Start agent installation
set +e
java -Dbamboo.home="${BAMBOO_PREWARM_DIR}" -jar "${AGENT_JAR}" "${BAMBOO_SERVER}/agentServer" | tee prewarm-agent.log | while read LOGLINE
do
  # Wait for classpath synchronization completion
  if echo "${LOGLINE}" | grep -q 'Registering agent on the server'; then
    pkill -P $$ java
  fi
done
set -e

# Cleanup non-library files
rm -f "${BAMBOO_PREWARM_DIR}/bamboo-agent.cfg.xml"
rm -f "${BAMBOO_PREWARM_DIR}/atlassian-bamboo-agent.log"
rm -f "${BAMBOO_PREWARM_DIR}/installer.properties"
rm -rf "${BAMBOO_PREWARM_DIR}/bin/"
rm -rf "${BAMBOO_PREWARM_DIR}/conf/"
rm -rf "${BAMBOO_PREWARM_DIR}/caches/"
rm -rf "${BAMBOO_PREWARM_DIR}/lib/"
rm -rf "${BAMBOO_PREWARM_DIR}/logs/"

# Optional: cleanup user installed libraries (i.e. Bamboo add-ons)
rm -rf "${BAMBOO_PREWARM_DIR}/plugins/user-installed"

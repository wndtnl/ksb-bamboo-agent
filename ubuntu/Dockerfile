ARG BASE_IMAGE=ubuntu:20.04
FROM $BASE_IMAGE

LABEL maintainer="hello@windtunnel.io"

ARG BAMBOO_VERSION=6.8.0

ARG DOWNLOAD_URL=https://packages.atlassian.com/mvn/maven-atlassian-external/com/atlassian/bamboo/atlassian-bamboo-agent-installer/${BAMBOO_VERSION}/atlassian-bamboo-agent-installer-${BAMBOO_VERSION}.jar

# Environment

ENV BAMBOO_USER=bamboo
ENV BAMBOO_UID=1000

ENV BAMBOO_GROUP=bamboo
ENV BAMBOO_GID 1000

ENV BAMBOO_USER_HOME=/home/${BAMBOO_USER}
ENV BAMBOO_AGENT_HOME=${BAMBOO_USER_HOME}/bamboo-agent-home

ENV AGENT_JAR=${BAMBOO_USER_HOME}/atlassian-bamboo-agent-installer.jar
ENV SCRIPT_WRAPPER=${BAMBOO_USER_HOME}/runAgent.sh
ENV INIT_BAMBOO_CAPABILITIES=${BAMBOO_USER_HOME}/init-bamboo-capabilities.properties
ENV BAMBOO_CAPABILITIES=${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties

# Install prerequisites

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y curl

# Create user

RUN groupadd --gid ${BAMBOO_GID} ${BAMBOO_GROUP} && \
    useradd --uid ${BAMBOO_UID} --gid ${BAMBOO_GID} --home-dir ${BAMBOO_USER_HOME} --shell /bin/bash ${BAMBOO_USER} && \
    mkdir -p ${BAMBOO_AGENT_HOME} && \
    chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${BAMBOO_USER_HOME}

# Download agent JAR

RUN curl -L --silent ${DOWNLOAD_URL} -o ${AGENT_JAR}

# Install files

COPY bamboo-update-capability.sh ${BAMBOO_USER_HOME}/bamboo-update-capability.sh 
COPY runAgent.sh ${SCRIPT_WRAPPER} 

RUN chmod +x ${BAMBOO_USER_HOME}/bamboo-update-capability.sh && \
    chmod +x ${SCRIPT_WRAPPER} && \
    mkdir -p ${BAMBOO_USER_HOME}/bamboo-agent-home/bin

RUN chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${BAMBOO_USER_HOME}

# Set user

USER ${BAMBOO_USER}

# Update agent capabilities

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.jdk.JDK 1.8" /usr/lib/jvm/java-1.8-openjdk/bin/java

WORKDIR ${BAMBOO_USER_HOME}

ENTRYPOINT ["./runAgent.sh"]

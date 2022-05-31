ARG BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2019
FROM $BASE_IMAGE

LABEL maintainer="hello@windtunnel.io"

ARG BAMBOO_VERSION=6.8.0

ARG DOWNLOAD_URL="https://packages.atlassian.com/mvn/maven-atlassian-external/com/atlassian/bamboo/atlassian-bamboo-agent-installer/${BAMBOO_VERSION}/atlassian-bamboo-agent-installer-${BAMBOO_VERSION}.jar"

# Environment

ENV BAMBOO_USER=bamboo
ENV BAMBOO_GROUP=bamboo

ENV BAMBOO_USER_HOME="c:\\Users\\${BAMBOO_USER}"
ENV BAMBOO_AGENT_HOME="${BAMBOO_USER_HOME}\\bamboo-agent-home"

ENV AGENT_JAR="${BAMBOO_USER_HOME}\\atlassian-bamboo-agent-installer.jar"
ENV SCRIPT_WRAPPER="${BAMBOO_USER_HOME}\\run-agent.bat"

# Install prerequisites

RUN powershell (new-object System.Net.WebClient).Downloadfile('http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185', 'C:\jre-8u91-windows-x64.exe')
RUN powershell start-process -filepath C:\jre-8u91-windows-x64.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\Java\jre1.8.0_91,/L,install64.log"
RUN del C:\jre-8u91-windows-x64.exe

ENV JAVA_HOME="c:\\Java\\jre1.8.0_91"

RUN powershell -Command "[Environment]::SetEnvironmentVariable('PATH', $Env:PATH + ';c:\Java\jre1.8.0_91\bin', [EnvironmentVariableTarget]::Machine)"

# Create user

RUN powershell New-LocalUser -Name $env:BAMBOO_USER -Description $env:BAMBOO_USER -NoPassword -AccountNeverExpires -UserMayNotChangePassword
RUN powershell Set-LocalUser -Name $env:BAMBOO_USER -PasswordNeverExpires $true
RUN powershell Add-LocalGroupMember -Group "Administrators" -Member $env:BAMBOO_USER -Verbose

USER $BAMBOO_USER
RUN mkdir $BAMBOO_USER_HOME

# Download agent JAR

RUN powershell (new-object System.Net.WebClient).Downloadfile($env:DOWNLOAD_URL, $env:AGENT_JAR)

# Install files

COPY --chown=$BAMBOO_USER scripts/run-agent.bat $SCRIPT_WRAPPER

WORKDIR $BAMBOO_USER_HOME

ENTRYPOINT ["run-agent.bat"]

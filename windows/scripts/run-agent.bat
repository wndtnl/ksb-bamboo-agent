@echo off

set BAMBOO_SERVER=%1

if [%BAMBOO_SERVER%] == [] (
    echo "Please run the Docker image with Bamboo URL as the first argument"
    exit /b 1
)

if [%SECURITY_TOKEN%] == [] (
    "%JAVA_HOME%\bin\java.exe" -Dbamboo.home="%BAMBOO_AGENT_HOME%" -jar "%AGENT_JAR%" "%BAMBOO_SERVER%/agentServer/"
) else (
    "%JAVA_HOME%\bin\java.exe" -Dbamboo.home="%BAMBOO_AGENT_HOME%" -jar "%AGENT_JAR%" "%BAMBOO_SERVER%/agentServer/" -t "%SECURITY_TOKEN%"
)

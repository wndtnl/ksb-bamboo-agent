@echo on

set BAMBOO_SERVER=%1

if [%BAMBOO_SERVER%] == [] (
    echo "Please run the Docker image with Bamboo URL as the first argument"
    exit /b 1
)

if exist "%$BAMBOO_PREWARM_DIR%" (
    if exist "%BAMBOO_AGENT_HOME%/classpath" (
        echo "Directory %BAMBOO_AGENT_HOME%/classpath exists, skipping prewarm copy"
    ) else (
        echo "Directory %BAMBOO_AGENT_HOME%/classpath does not exist, executing prewarm copy"
        xcopy %BAMBOO_PREWARM_DIR% %BAMBOO_AGENT_HOME%\ /E/H
    )
)

if [%SECURITY_TOKEN%] == [] (
    "%JAVA_HOME%\bin\java.exe" -Dbamboo.home="%BAMBOO_AGENT_HOME%" -jar "%AGENT_JAR%" "%BAMBOO_SERVER%/agentServer/"
) else (
    "%JAVA_HOME%\bin\java.exe" -Dbamboo.home="%BAMBOO_AGENT_HOME%" -jar "%AGENT_JAR%" "%BAMBOO_SERVER%/agentServer/" -t "%SECURITY_TOKEN%"
)
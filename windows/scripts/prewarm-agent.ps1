
# Start agent installation

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "$env:JAVA_HOME\bin\java.exe"
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$pinfo.Arguments = "-Dbamboo.home=`"$env:BAMBOO_PREWARM_DIR`" -jar `"$env:AGENT_JAR`" $env:BAMBOO_SERVER/agentServer"

Write-Host $pinfo.Arguments

$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo

$p.Start() | Out-Null

while(!$p.HasExited)
{
    $output = $p.StandardOutput.Readline()
    Write-Host $output

    if($output -like '*Registering agent on the server*')
    {
        $p.Kill()
        break
    }
}

$p.WaitForExit()

# Cleanup non-library files

Remove-Item -Path "$env:BAMBOO_PREWARM_DIR\bamboo-agent.cfg.xml" -Force -ErrorAction Ignore
Remove-Item -Path "$env:BAMBOO_PREWARM_DIR\atlassian-bamboo-agent.log" -Force -ErrorAction Ignore
Remove-Item -Path "$env:BAMBOO_PREWARM_DIR\installer.properties" -Force -ErrorAction Ignore

Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\bin" –Recurse -Force -ErrorAction Ignore
Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\conf" –Recurse -Force -ErrorAction Ignore
Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\caches" –Recurse -Force -ErrorAction Ignore
Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\lib" –Recurse -Force -ErrorAction Ignore
Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\logs" –Recurse -Force -ErrorAction Ignore

# Optional: cleanup user installed libraries (i.e. Bamboo add-ons)

Remove-Item –Path "$env:BAMBOO_PREWARM_DIR\plugins\user-installed" –Recurse -Force -ErrorAction Ignore

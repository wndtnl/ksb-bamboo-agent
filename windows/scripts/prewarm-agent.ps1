
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

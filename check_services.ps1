<#
.SYNOPSIS
	Check all automatic services are running.
.DESCRIPTION
	Check all automatic services are running and returns Nagios output and code.
.OUTPUTS
	OK: All services running.
	CRITICAL: Services stopped.
.NOTES 
	Author:	Juan Granados and Diego Pastore
#>

$Services = Get-CimInstance win32_service -Filter "startmode = 'auto' AND state != 'running' AND exitcode != 0"  | select name, startname, exitcode
$ServicesRunning = Get-CimInstance win32_service -Filter "state = 'running'"
if ([string]::IsNullOrEmpty($Services)) {
    Write-Output "OK: All services running | ServicesRunning=$($ServicesRunning.Count);0;0;0;0"
    Exit(0)
} else {
            $ServicesStopped += "$($Service.Name)(Stopped),"
            $ExitCode = 1
        }
    if ($ExitCode -eq 1) {
        Write-Output "CRITICAL: Service(s) stopped: $($ServicesStopped.TrimEnd(",")) | ServicesRunning=$($ServicesRunning.Count);0;0;0;0"
        Exit(1)
}

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $step
)

if (!$step -or ($step -eq "Start")){
    choco install ./chocolatey.config -y

    Write-Host "Installed Chocolatey dependencies"
    if ($LASTEXITCODE -in (1641, 3010)) {
        Write-Host "A reboot is needed to complete the installation steps
Restarting..."

        $action =  New-ScheduledTaskAction -Execute "$env:USERPROFILE/.dotfile/packages/packages.ps1 continue"
        $trigger = New-ScheduledTaskTrigger -Once -AtLogOn

        Register-ScheduledTask InstallStep2 -Action $action -Trigger $trigger
        Restart-Computer -Wait
    }
}

# Remove task scheduler
Unregister-ScheduledTask InstallStep2
choco install "wsl-ubuntu-2004" -y

pip install -r pip.txt

Get-Content ./npm.txt | % {
    npm i -g $_
} 

Write-Host "Installed all dependencies"

# Check to see if we are currently running "as Administrator"
function Validate-Administrator {
    $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (!(Validate-Administrator)) {
    throw "Error: Run this script as administrator"
}

Set-ExecutionPolicy  Bypass -Scope Process -Force

if (!(Get-Command clist -ErrorAction SilentlyContinue)){
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    RefreshEnv.cmd
}

cinst git.install --params "/NoAutoCrlf /NoShellIntegration" --limit-output

if (!(Test-Path ~/dotrepo)){
    git clone "https://github.com/mykaelll87/dotfiles.git" "$env:HOMEPATH/.dotfiles"
} 

Push-Location "~/.dotfiles"

Pop-Location

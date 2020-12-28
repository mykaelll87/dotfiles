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

cinst git.install --params "/NoAutoCrlf /NoShellIntegration" --limit-output -y

if (!(Test-Path ~/dotrepo)){
    [System.Environment]::SetEnvironmentVariable("DOTFILES", "$env:HOMEPATH\.dotfiles", [System.EnvironmentVariableTarget]::User)
    git clone "https://github.com/mykaelll87/dotfiles.git" "DOTFILES"
} 

Push-Location "~/.dotfiles"

./windows.ps1

Push-Location "packages"
    ./packages.ps1 -step "Start"
Pop-Location
Push-Location "symlink"
    ./setLinks.ps1
Pop-Location
Pop-Location

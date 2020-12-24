# dotfiles
Dotfiles for Windows dev machine

Will install dependencies, config files

Intended to check be idempotent, and therefore the setup must be able to be ran multiple times

## Usage

```powershell
Set-ExecutionPolicy  Bypass -Scope Process -Force
iex (new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mykaelll87/dotfiles/master/README.md')
```

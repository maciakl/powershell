Import-Module PSGet
Import-Module PsCX
Import-Module Posh-Git
Import-Module PsUrl

$PROFILEFOLDER = Split-Path -parent $profile

function prompt
{
    # Some apps like to reset this to white - making sure we stay solarized
    (Get-Host).Ui.RawUi.ForegroundColor = "DarkYellow"

    # Check for Administrator elevation
    $w=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p=new-object System.Security.Principal.WindowsPrincipal($w)
    $a=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    $isAdmin=$p.IsInRole($a)

    if ($isAdmin) 
    {
        Write-Host "ADMIN" -NoNewLine -ForegroundColor White -BackgroundColor Red
        Write-Host " " -NoNewLine
    }

    Write-Host $ENV:USERNAME -NoNewLine -ForegroundColor Green
    Write-Host " @ " -NoNewLine
    Write-Host $ENV:COMPUTERNAME -NoNewLine -ForegroundColor Yellow
    Write-Host ": " -NoNewLine
    Write-Host $(get-location) -NoNewLine -ForegroundColor Magenta

    Write-VcsStatus 

    Write-Host " >" -NoNewLine
    return " "

}

# Aliases
# -------

set-alias gvim "C:\Program Files (x86)\Vim\vim74\gvim.exe"
function g { gvim --remote-silent $args }
function gd { gvim --servername DEV $args }

set-alias make "C:\Program Files (x86)\GnuWin32\bin\make.exe"

# to create soft link, we need to jump out to cmd
function mklink { cmd /c mklink $args }

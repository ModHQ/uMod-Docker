# uMod Installer Script - uMod.org
# Copyright (c) uMod team and contributors. All rights reserved.
# Licensed under the MIT license. https://tldrlegal.com/license/mit-license

function Log($str) { Write-Host $str -ForegroundColor Cyan }

function LogError($str) { $host.UI.WriteErrorLine($str) }

Log @"
  _   _ __  __  ___  ____
 | | | |  \/  |/ _ \|  _ \
 | | | | |\/| | | | | | | |
 | |_| | |  | | |_| | |_| |
  \___/|_|  |_|\___/|____/`n
"@

if($PSVersionTable.PSVersion.Major -lt 5)
{
    LogError "PowerShell 5 or greater is required to use this script (PowerShell $($PSVersionTable.PSVersion.Major)). https://github.com/PowerShell/PowerShell/releases"
    exit 1;
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Log "Installing uMod tool..."
if (-not $(Get-PackageSource -Name uMod -ProviderName NuGet -ErrorAction Ignore))
{
    dotnet nuget add source https://www.myget.org/f/umod/api/v3/index.json --name uMod
}
dotnet tool install --tool-path /usr/local/bin uMod --version "*-*"


Log ""
if ($LastExitCode -ne 0) {
    LogError "uMod install did not complete, please try again"
    exit 1
}
else
{
    Log "uMod install complete! Please restart the terminal window to use the umod commands."
    exit 0
}

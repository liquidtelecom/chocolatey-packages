﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-beta/93.0.4585.3/win/Opera_beta_93.0.4585.3_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-beta/93.0.4585.3/win/Opera_beta_93.0.4585.3_Setup_x64.exe'
  checksum       = '5cb23e09727bcd9232df7e5441ac740e6d7e9a38c21ee826f7f25886ac2a0285'
  checksum64     = '4ea2813052a71372ff8af83070168ad576100ecd5389687860d4ccc7163b835d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '93.0.4585.3'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}

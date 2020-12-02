$ErrorActionPreference = 'Stop';
$packageName = 'vtex-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$installerFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing x64 bit version"; Get-Item "$toolsDir\*x64.exe"
} else { Write-Host "Installing x32 bit version"; Get-Item "$toolsDir\*x86.exe" }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $installerFile
  softwareName  = 'VTEX CLI'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item ($toolsDir + '\*.' + $packageArgs.fileType)
New-Item -ItemType SymbolicLink -Path 'C:\Program Files\vtex\client\node_modules\vtex' -Target 'C:\Program Files\vtex\client'    
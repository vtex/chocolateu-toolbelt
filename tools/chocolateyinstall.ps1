$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://vtex-toolbelt-test.s3.us-east-2.amazonaws.com/vtex-x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url      = $url

  softwareName  = 'vtex*'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

New-Item -ItemType SymbolicLink -Path 'C:\Program Files\vtex\client\node_modules\vtex' -Target 'C:\Program Files\vtex\client'    
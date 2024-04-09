sal wget (Join-Path $env:ChocolateyInstall "bin\wget.exe") -O AllScope
# gal wget

$BASEDIR = $args[0]
$TARGETDIR = $args[1]
Write-Host "BASEDIR=" $BASEDIR
Write-Host "TARGETDIR=" $TARGETDIR
$TMPDIR = "$BASEDIR\tmp"

New-Item $TMPDIR -ItemType Directory -ErrorAction SilentlyContinue
Set-Location -Path $TMPDIR

# get source
wget --progress=dot:mega -c --content-disposition https://github.com/POV-Ray/povray/archive/refs/tags/v3.7.0.10.tar.gz

tar xzf povray-3.7.0.10.tar.gz
Set-Location -Path ./povray-3.7.0.10

New-Item $TARGETDIR/povray -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item -Recurse "distribution/include" "$TARGETDIR/povray"

# Get-ChildItem ./
(Get-Content source\backend\povray.h).replace('FILL IN NAME HERE.........................', 'CueMol') | Set-Content source\backend\povray.h
(Get-Content source\backend\povray.h).replace('#error Please complete the following DISTRIBUTION_MESSAGE_2 definition', '') | Set-Content source\backend\povray.h
(Get-Content vfe/win/syspovconfig.h).replace('// #define _CONSOLE', '#define _CONSOLE') | Set-Content vfe/win/syspovconfig.h

(Get-Content vfe/win/console/winconsole.cpp).replace('POV_RAY_VERSION', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('PVENGINE_VER', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('DISTRIBUTION_MESSAGE_1', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('DISTRIBUTION_MESSAGE_2', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('DISTRIBUTION_MESSAGE_3', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('POV_RAY_COPYRIGHT', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('DISCLAIMER_MESSAGE_1', '') | Set-Content vfe/win/console/winconsole.cpp
(Get-Content vfe/win/console/winconsole.cpp).replace('DISCLAIMER_MESSAGE_2', '') | Set-Content vfe/win/console/winconsole.cpp

msbuild windows\vs10\openexr_toFloat.vcxproj /t:rebuild /p:Configuration=Release /p:PlatformToolset=v142 /p:Platform=x64
msbuild windows\vs10\openexr_eLut.vcxproj /t:rebuild /p:Configuration=Release /p:PlatformToolset=v142 /p:Platform=x64
msbuild windows\vs10\tiff.vcxproj /t:rebuild /p:Configuration=Release /p:PlatformToolset=v142 /p:Platform=x64
msbuild windows\vs10\console.vcxproj /t:rebuild /p:Configuration=Release /p:PlatformToolset=v142 /p:Platform=x64

# Get-ChildItem ./windows/vs10/bin64/
New-Item $TARGETDIR/povray/bin -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item windows/vs10/bin64/*.exe $TARGETDIR/povray/bin/
# Get-ChildItem $TARGETDIR/povray/bin/
Set-Location -Path $TARGETDIR

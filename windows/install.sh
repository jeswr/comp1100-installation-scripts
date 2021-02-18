# !!! THIS FILE IS INCOMPLETE !!!


# Setting permissions (powershell)
Set-ExecutionPolicy AllSigned

# Installing chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco

choco install -y msys2
C:\tools\msys64\msys2.exe
# https://stackoverflow.com/questions/47438779/executing-a-script-in-msys2-mingw
C:\msys64\usr\bin\mintty.exe -w hide /bin/env MSYSTEM=MINGW64 /bin/bash -l /c/Users/rom1v/project/release.sh